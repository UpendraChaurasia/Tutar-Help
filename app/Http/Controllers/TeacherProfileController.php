<?php

namespace App\Http\Controllers;

use App\Http\Requests\TeacherProfileUpdateRequest;
use App\Models\TeacherApplication;
use App\Models\TeacherProfile;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;
use Inertia\Response;

class TeacherProfileController extends Controller
{
    public function edit(Request $request): Response
    {
        $user = $request->user();
        abort_unless($user->hasRole('Teacher'), 403);

        $profile = TeacherProfile::with([
            'user',
            'subjects',
            'languages',
            'educations',
            'experiences',
            'certificates',
            'documents',
            'availabilities',
            'bankAccount',
            'socialLinks',
        ])->withCount([
            'applications as pending_applications_count' => function ($query) {
                $query->where('status', 'pending');
            },
        ])->firstOrCreate(['user_id' => $user->id]);

        $lastApplication = $profile->applications()->with('reviewer')->latest('submitted_at')->first();
        $canSubmit = ! $lastApplication || $lastApplication->status !== 'pending';

        return Inertia::render('Teacher/Profile/Edit', [
            'profile' => $this->profilePayload($profile),
            'progress' => $this->calculateCompletion($profile),
            'canSubmit' => $canSubmit,
            'storageUrl' => $this->storageBaseUrl(),
            'lastSubmission' => $lastApplication ? [
                'submitted_at' => $lastApplication->submitted_at?->toDateTimeString(),
                'status' => $lastApplication->status,
                'reviewed_at' => $lastApplication->reviewed_at?->toDateTimeString(),
                'reviewed_by_name' => $lastApplication->reviewer?->name,
            ] : null,
        ]);
    }

    public function update(TeacherProfileUpdateRequest $request): RedirectResponse
    {
        $user = $request->user();

        abort_unless($user->hasRole('Teacher'), 403);


        $profile = TeacherProfile::firstOrCreate(['user_id' => $user->id]);

        Log::info('Teacher profile update request received', [
            'user_id' => $user->id,
            'profile_id' => $profile->id,
            'submit_for_approval' => $request->boolean('submit_for_approval'),
            'step' => $request->input('step'),
        ]);

        $shouldSubmitForApproval = $request->boolean('submit_for_approval');

        try {
            DB::transaction(function () use ($request, $profile, $user): void {
                $validated = $request->validated();

                if ($request->hasFile('profile_photo')) {
                    $validated['profile_photo'] = $request->file('profile_photo')
                        ->store('teacher/profile_photos');
                }

                if ($request->hasFile('introduction_video')) {
                    $validated['introduction_video'] = $request->file('introduction_video')
                        ->store('teacher/videos');
                }

                $profile->fill(array_filter($validated, fn($value) => ! is_array($value) || $value !== []));
                $profile->profile_completion_percentage = $this->calculateCompletion($profile);
                $profile->status = $request->boolean('submit_for_approval') ? 'pending' : $profile->status;
                $profile->save();

                if (isset($validated['subjects'])) {
                    $profile->subjects()->delete();
                    $profile->subjects()->createMany(array_map(fn($subject) => ['subject_name' => $subject], $validated['subjects']));
                }

                if (isset($validated['languages'])) {
                    $profile->languages()->delete();
                    $profile->languages()->createMany(array_map(fn($language) => ['language' => $language], $validated['languages']));
                }

                if (isset($validated['educations'])) {
                    $profile->educations()->delete();
                    $profile->educations()->createMany($validated['educations']);
                }

                if (isset($validated['experiences'])) {
                    $profile->experiences()->delete();
                    $profile->experiences()->createMany($validated['experiences']);
                }

                if (isset($validated['certificates'])) {
                    $existingCertificates = $profile->certificates()->get();
                    $profile->certificates()->delete();

                    foreach ($validated['certificates'] as $certificate) {
                        if (isset($certificate['certificate_file']) && is_object($certificate['certificate_file'])) {
                            $certificate['certificate_file'] = $certificate['certificate_file']
                                ->store('teacher/certificates');
                        }

                        if (!empty($certificate['delete_certificate_file'])) {
                            $certificate['certificate_file'] = null;
                        }

                        if (empty($certificate['certificate_file']) && !empty($certificate['existing_file']) && !empty($certificate['delete_certificate_file'])) {
                            $existingPath = $certificate['existing_file'];
                            $this->deleteStoredFile($existingPath);
                        }

                        $profile->certificates()->create($certificate);
                    }
                }

                $document = $profile->documents()->first();
                $documentData = [
                    'document_type' => $validated['document_type'] ?? null,
                    'document_number' => $validated['document_number'] ?? null,
                    'verification_status' => 'pending',
                ];

                $documentActionRequired = $request->hasFile('front_image') || $request->hasFile('back_image') || $request->hasFile('selfie_image') || $request->hasFile('address_proof') || $request->boolean('delete_front_image') || $request->boolean('delete_back_image') || $request->boolean('delete_selfie_image') || $request->boolean('delete_address_proof') || isset($validated['document_type']) || isset($validated['document_number']);

                if ($documentActionRequired) {
                    if ($request->hasFile('front_image')) {
                        $documentData['front_image'] = $request->file('front_image')->store('teacher/documents');
                    }

                    if ($request->hasFile('back_image')) {
                        $documentData['back_image'] = $request->file('back_image')->store('teacher/documents');
                    }

                    if ($request->hasFile('selfie_image')) {
                        $documentData['selfie_image'] = $request->file('selfie_image')->store('teacher/documents');
                    }

                    if ($request->hasFile('address_proof')) {
                        $documentData['address_proof'] = $request->file('address_proof')->store('teacher/documents');
                    }

                    if ($request->boolean('delete_front_image') && $document?->front_image) {
                        $this->deleteStoredFile($document->front_image);
                        $documentData['front_image'] = null;
                    }

                    if ($request->boolean('delete_back_image') && $document?->back_image) {
                        $this->deleteStoredFile($document->back_image);
                        $documentData['back_image'] = null;
                    }

                    if ($request->boolean('delete_selfie_image') && $document?->selfie_image) {
                        $this->deleteStoredFile($document->selfie_image);
                        $documentData['selfie_image'] = null;
                    }

                    if ($request->boolean('delete_address_proof') && $document?->address_proof) {
                        $this->deleteStoredFile($document->address_proof);
                        $documentData['address_proof'] = null;
                    }

                    $profile->documents()->updateOrCreate([], $documentData);
                }

                if (isset($validated['availabilities'])) {
                    $profile->availabilities()->delete();
                    $profile->availabilities()->createMany($validated['availabilities']);
                }

                if (isset($validated['bank'])) {
                    $profile->bankAccount()->updateOrCreate([], $validated['bank']);
                }

                if (isset($validated['social'])) {
                    $profile->socialLinks()->updateOrCreate([], $validated['social']);
                }

                if ($request->boolean('submit_for_approval')) {
                    Log::info('Teacher profile approval submission started', [
                        'user_id' => $user->id,
                        'profile_id' => $profile->id,
                    ]);

                    $application = $profile->applications()->create([
                        'submitted_at' => now(),
                        'status' => 'pending',
                        'remarks' => 'Submitted from teacher profile review step for Admin and Superadmin approval.',
                    ]);

                    Log::info('Teacher profile approval submission completed', [
                        'user_id' => $user->id,
                        'profile_id' => $profile->id,
                        'application_id' => $application->id,
                    ]);

                    $profile->status = 'pending';
                    $profile->save();
                }
            });

            if ($shouldSubmitForApproval) {
                return redirect()->route('teacher.profile.edit')->with('success', 'Teacher profile submitted for approval successfully. It is now pending review by Admin and Superadmin.');
            }

            return redirect()->route('teacher.profile.edit')->with('success', 'Teacher profile saved successfully.');
        } catch (\Throwable $e) {
            if ($shouldSubmitForApproval) {
                Log::error('Teacher profile approval submission failed', [
                    'user_id' => $user->id,
                    'profile_id' => $profile->id,
                    'exception' => $e->getMessage(),
                ]);

                throw ValidationException::withMessages([
                    'submission' => [$e->getMessage() ?: 'Teacher profile submission failed. Please try again.'],
                ]);
            }

            throw $e;
        }
    }

    private function profilePayload(TeacherProfile $profile): array
    {
        return [
            'id' => $profile->id,
            'user' => $profile->user ? [
                'id' => $profile->user->id,
                'name' => $profile->user->name,
                'email' => $profile->user->email,
            ] : null,
            'profile_photo' => $profile->profile_photo,
            'profile_photo_url' => $this->storageFileUrl($profile->profile_photo),
            'gender' => $profile->gender,
            'date_of_birth' => $profile->date_of_birth?->toDateString(),
            'phone' => $profile->phone,
            'country' => $profile->country,
            'state' => $profile->state,
            'city' => $profile->city,
            'timezone' => $profile->timezone,
            'preferred_language' => $profile->preferred_language,
            'short_bio' => $profile->short_bio,
            'about_me' => $profile->about_me,
            'headline' => $profile->headline,
            'experience_years' => $profile->experience_years,
            'current_occupation' => $profile->current_occupation,
            'current_organization' => $profile->current_organization,
            'teaching_level' => $profile->teaching_level,
            'hourly_rate' => $profile->hourly_rate,
            'introduction_video' => $profile->introduction_video,
            'subjects' => $profile->subjects->map(fn($subject) => $subject->subject_name)->values()->all(),
            'languages' => $profile->languages->map(fn($language) => $language->language)->values()->all(),
            'educations' => $profile->educations->map(function ($education) {
                return [
                    'id' => $education->id,
                    'degree' => $education->degree,
                    'college' => $education->college,
                    'university' => $education->university,
                    'country' => $education->country,
                    'start_year' => $education->start_year,
                    'end_year' => $education->end_year,
                    'description' => $education->description,
                ];
            })->values()->all(),
            'experiences' => $profile->experiences->map(function ($experience) {
                return [
                    'id' => $experience->id,
                    'company' => $experience->company,
                    'designation' => $experience->designation,
                    'industry' => $experience->industry,
                    'start_date' => $experience->start_date?->toDateString(),
                    'end_date' => $experience->end_date?->toDateString(),
                    'currently_working' => $experience->currently_working,
                    'description' => $experience->description,
                ];
            })->values()->all(),
            'certificates' => $profile->certificates->map(function ($certificate) {
                return array_merge($certificate->toArray(), [
                    'certificate_file_url' => $this->storageFileUrl($certificate->certificate_file),
                ]);
            })->values()->all(),
            'documents' => $profile->documents->map(function ($document) {
                return array_merge($document->toArray(), [
                    'front_image_url' => $this->storageFileUrl($document->front_image),
                    'back_image_url' => $this->storageFileUrl($document->back_image),
                    'selfie_image_url' => $this->storageFileUrl($document->selfie_image),
                    'address_proof_url' => $this->storageFileUrl($document->address_proof),
                ]);
            })->values()->all(),
            'availabilities' => $profile->availabilities->map(function ($availability) {
                return [
                    'id' => $availability->id,
                    'day' => $availability->day,
                    'start_time' => $availability->start_time,
                    'end_time' => $availability->end_time,
                ];
            })->values()->all(),
            'bank_account' => $profile->bankAccount->first()?->toArray() ?? null,
            'social_links' => $profile->socialLinks->map(fn($socialLink) => $socialLink->toArray())->values()->all(),
            'profile_completion_percentage' => $profile->profile_completion_percentage,
            'status' => $profile->status,
            'approved_by' => $profile->approved_by,
            'approved_at' => $profile->approved_at?->toDateTimeString(),
        ];
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

        $disk = Storage::disk('s3');

        if (method_exists($disk, 'temporaryUrl')) {
            try {
                return $disk->temporaryUrl($path, now()->addMinutes(60));
            } catch (\Throwable $e) {
                // fall through to the base URL fallback below
            }
        }

        if (method_exists($disk, 'url')) {
            try {
                return $disk->url($path);
            } catch (\Throwable $e) {
                // fall through to the base URL fallback below
            }
        }

        $baseUrl = $this->storageBaseUrl();

        return $baseUrl ? rtrim($baseUrl, '/') . '/' . ltrim($path, '/') : null;
    }

    private function deleteStoredFile(?string $path): void
    {
        if (! $path) {
            return;
        }

        if (Storage::disk('s3')->exists($path)) {
            Storage::disk('s3')->delete($path);
            return;
        }

        if (Storage::disk('public')->exists($path)) {
            Storage::disk('public')->delete($path);
        }
    }

    private function calculateCompletion(TeacherProfile $profile): int
    {
        $score = 0;

        if ($profile->profile_photo || $profile->headline || $profile->short_bio || $profile->about_me) {
            $score += 10;
        }

        if ($profile->current_occupation || $profile->current_organization || $profile->teaching_level || $profile->hourly_rate) {
            $score += 20;
        }

        if ($profile->relationLoaded('educations') ? $profile->educations->isNotEmpty() : $profile->educations()->exists()) {
            $score += 10;
        }

        if ($profile->relationLoaded('experiences') ? $profile->experiences->isNotEmpty() : $profile->experiences()->exists()) {
            $score += 10;
        }

        if ($profile->relationLoaded('certificates') ? $profile->certificates->isNotEmpty() : $profile->certificates()->exists()) {
            $score += 15;
        }

        if ($profile->relationLoaded('documents') ? $profile->documents->isNotEmpty() : $profile->documents()->exists()) {
            $score += 15;
        }

        if ($profile->relationLoaded('availabilities') ? $profile->availabilities->isNotEmpty() : $profile->availabilities()->exists()) {
            $score += 5;
        }

        if ($profile->relationLoaded('bankAccount') ? $profile->bankAccount->isNotEmpty() : $profile->bankAccount()->exists()) {
            $score += 5;
        }

        if ($profile->relationLoaded('socialLinks') ? $profile->socialLinks->isNotEmpty() : $profile->socialLinks()->exists()) {
            $score += 5;
        }

        if (($profile->pending_applications_count ?? null) > 0 || $profile->status === 'approved') {
            $score += 5;
        }

        return min($score, 100);
    }
}
