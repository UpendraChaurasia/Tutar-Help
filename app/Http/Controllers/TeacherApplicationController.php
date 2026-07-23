<?php

namespace App\Http\Controllers;

use App\Models\TeacherApplication;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;

class TeacherApplicationController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();

        abort_unless($user && ($user->hasRole('Admin') || $user->hasRole('Superadmin')), 403);

        $applications = TeacherApplication::with(['profile.user', 'reviewer'])
            ->latest('submitted_at')
            ->get()
            ->map(function (TeacherApplication $application) {
                return [
                    'id' => $application->id,
                    'status' => $application->status,
                    'submitted_at' => $application->submitted_at?->toDateTimeString(),
                    'reviewed_at' => $application->reviewed_at?->toDateTimeString(),
                    'remarks' => $application->remarks,
                    'teacher' => [
                        'id' => $application->profile?->user?->id,
                        'name' => $application->profile?->user?->name,
                        'email' => $application->profile?->user?->email,
                    ],
                    'reviewer' => $application->reviewer ? [
                        'id' => $application->reviewer->id,
                        'name' => $application->reviewer->name,
                    ] : null,
                ];
            });

        return Inertia::render('Admin/TeacherApplications/Index', [
            'applications' => $applications,
        ]);
    }

    public function show(Request $request, TeacherApplication $application)
    {
        $user = $request->user();

        abort_unless($user && ($user->hasRole('Admin') || $user->hasRole('Superadmin')), 403);

        $application->load(['profile.user', 'profile.subjects', 'profile.languages', 'profile.educations', 'profile.experiences', 'profile.certificates', 'profile.documents', 'profile.availabilities', 'profile.bankAccount', 'profile.socialLinks', 'reviewer']);

        return Inertia::render('Admin/TeacherApplications/Show', [
            'storageUrl' => $this->storageBaseUrl(),
            'application' => [
                'id' => $application->id,
                'status' => $application->status,
                'submitted_at' => $application->submitted_at?->toDateTimeString(),
                'reviewed_at' => $application->reviewed_at?->toDateTimeString(),
                'remarks' => $application->remarks,
                'teacher' => [
                    'id' => $application->profile?->user?->id,
                    'name' => $application->profile?->user?->name,
                    'email' => $application->profile?->user?->email,
                    'phone' => $application->profile?->phone,
                    'profile_photo' => $application->profile?->profile_photo,
                    'profile_photo_url' => $this->storageFileUrl($application->profile?->profile_photo),
                    'country' => $application->profile?->country,
                    'state' => $application->profile?->state,
                    'city' => $application->profile?->city,
                    'headline' => $application->profile?->headline,
                    'short_bio' => $application->profile?->short_bio,
                    'about_me' => $application->profile?->about_me,
                    'current_occupation' => $application->profile?->current_occupation,
                    'teaching_level' => $application->profile?->teaching_level,
                    'experience_years' => $application->profile?->experience_years,
                    'hourly_rate' => $application->profile?->hourly_rate,
                    'subjects' => $application->profile?->subjects->pluck('subject_name')->all() ?? [],
                    'languages' => $application->profile?->languages->pluck('language')->all() ?? [],
                    'educations' => $application->profile?->educations->toArray() ?? [],
                    'experiences' => $application->profile?->experiences->toArray() ?? [],
                    'certificates' => ($application->profile?->certificates ?? collect())->map(function ($certificate) {
                        return array_merge($certificate->toArray(), [
                            'certificate_file_url' => $this->storageFileUrl($certificate->certificate_file),
                        ]);
                    })->values()->all(),
                    'documents' => ($application->profile?->documents ?? collect())->map(function ($document) {
                        return array_merge($document->toArray(), [
                            'front_image_url' => $this->storageFileUrl($document->front_image),
                            'back_image_url' => $this->storageFileUrl($document->back_image),
                            'selfie_image_url' => $this->storageFileUrl($document->selfie_image),
                            'address_proof_url' => $this->storageFileUrl($document->address_proof),
                        ]);
                    })->values()->all(),
                    'availabilities' => $application->profile?->availabilities->toArray() ?? [],
                    'bank' => $application->profile?->bankAccount->first() ? $application->profile->bankAccount->first()->toArray() : null,
                    'social' => $application->profile?->socialLinks->first() ? $application->profile->socialLinks->first()->toArray() : null,
                ],
                'reviewer' => $application->reviewer ? [
                    'id' => $application->reviewer->id,
                    'name' => $application->reviewer->name,
                ] : null,
            ],
        ]);
    }

    private function storageBaseUrl(): string
    {
        $configuredUrl = config('filesystems.disks.s3.url');

        if ($configuredUrl) {
            return rtrim($configuredUrl, '/');
        }

        $bucket = config('filesystems.disks.s3.bucket');
        $region = config('filesystems.disks.s3.region');

        if ($bucket && $region) {
            return "https://{$bucket}.s3.{$region}.amazonaws.com";
        }

        return rtrim(config('app.url'), '/') . '/storage';
    }

    private function storageFileUrl(?string $path): ?string
    {
        if (! $path) {
            return null;
        }

        if (str_starts_with($path, 'http://') || str_starts_with($path, 'https://')) {
            return $path;
        }

        try {
            return Storage::disk('s3')->temporaryUrl($path, now()->addMinutes(60));
        } catch (\Throwable $e) {
            $baseUrl = $this->storageBaseUrl();

            return $baseUrl ? rtrim($baseUrl, '/') . '/' . ltrim($path, '/') : null;
        }
    }

    public function review(Request $request, TeacherApplication $application)
    {
        $user = $request->user();

        abort_unless($user && ($user->hasRole('Admin') || $user->hasRole('Superadmin')), 403);

        $validated = $request->validate([
            'decision' => ['required', 'in:approved,rejected,held'],
            'remarks' => ['nullable', 'string', 'max:2000'],
        ]);

        DB::transaction(function () use ($application, $user, $validated): void {
            $application->status = $validated['decision'] === 'approved' ? 'approved' : ($validated['decision'] === 'rejected' ? 'rejected' : 'held');
            $application->reviewed_at = now();
            $application->reviewed_by = $user->id;
            $application->remarks = $validated['remarks'] ?? $application->remarks;
            $application->save();

            if ($application->profile) {
                $application->profile->status = $application->status;
                $application->profile->approved_by = $user->id;
                $application->profile->approved_at = now();
                $application->profile->save();
            }
        });

        return redirect()->route('teacher.applications.index')->with('success', 'Application review updated successfully.');
    }
}
