<?php

use App\Models\TeacherApplication;
use App\Models\TeacherProfile;
use App\Models\User;
use Spatie\Permission\Models\Role;

it('admin can view the teacher applications page', function () {
    $admin = User::factory()->create();
    $admin->assignRole(Role::firstOrCreate(['name' => 'Admin']));

    $teacher = User::factory()->create([
        'name' => 'Jane Teacher',
        'email' => 'jane.teacher@example.com',
    ]);

    $profile = TeacherProfile::create([
        'user_id' => $teacher->id,
        'headline' => 'Math and Science Tutor',
    ]);

    $profile->applications()->create([
        'submitted_at' => now(),
        'status' => 'pending',
        'remarks' => 'Awaiting review',
    ]);

    $response = $this->actingAs($admin)->get('/teacher-applications');

    $response->assertOk();
    $response->assertInertia(
        fn($page) => $page
            ->component('Admin/TeacherApplications/Index')
            ->has('applications', 1)
            ->where('applications.0.teacher.name', 'Jane Teacher')
    );
});

it('disables submission while a previous application is pending review', function () {
    $teacher = User::factory()->create([
        'name' => 'John Teacher',
        'email' => 'john.teacher@example.com',
    ]);
    $teacher->assignRole(Role::firstOrCreate(['name' => 'Teacher']));

    $profile = TeacherProfile::create([
        'user_id' => $teacher->id,
        'headline' => 'Math Tutor',
    ]);

    $profile->applications()->create([
        'submitted_at' => now(),
        'status' => 'pending',
        'remarks' => 'Awaiting review',
    ]);

    $response = $this->actingAs($teacher)->get(route('teacher.profile.edit'));

    $response->assertOk();
    $response->assertInertia(fn($page) => $page->where('canSubmit', false));
});

it('re-enables submission once the latest application has been reviewed', function () {
    $teacher = User::factory()->create([
        'name' => 'Kate Teacher',
        'email' => 'kate.teacher@example.com',
    ]);
    $teacher->assignRole(Role::firstOrCreate(['name' => 'Teacher']));

    $profile = TeacherProfile::create([
        'user_id' => $teacher->id,
        'headline' => 'Science Tutor',
    ]);

    $profile->applications()->create([
        'submitted_at' => now()->subDay(),
        'reviewed_at' => now(),
        'reviewed_by' => $teacher->id,
        'status' => 'approved',
        'remarks' => 'Approved',
    ]);

    $response = $this->actingAs($teacher)->get(route('teacher.profile.edit'));

    $response->assertOk();
    $response->assertInertia(fn($page) => $page->where('canSubmit', true));
});

it('allows admin to approve a pending teacher application', function () {
    $admin = User::factory()->create();
    $admin->assignRole(Role::firstOrCreate(['name' => 'Admin']));

    $teacher = User::factory()->create([
        'name' => 'Liam Teacher',
        'email' => 'liam.teacher@example.com',
    ]);
    $teacher->assignRole(Role::firstOrCreate(['name' => 'Teacher']));

    $profile = TeacherProfile::create([
        'user_id' => $teacher->id,
        'headline' => 'History Tutor',
    ]);

    $application = $profile->applications()->create([
        'submitted_at' => now(),
        'status' => 'pending',
        'remarks' => 'Awaiting review',
    ]);

    $response = $this->actingAs($admin)->post(route('teacher.applications.review', $application), [
        'decision' => 'approved',
        'remarks' => 'Looks good',
    ]);

    $response->assertRedirect(route('teacher.applications.index'));
    $application->refresh();
    expect($application->status)->toBe('approved');
    expect($application->reviewed_by)->toBe($admin->id);
    expect($application->remarks)->toBe('Looks good');
});
