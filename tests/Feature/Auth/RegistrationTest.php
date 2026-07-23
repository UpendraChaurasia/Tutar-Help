<?php

use App\Models\User;
use Illuminate\Support\Facades\Auth;

test('registration screen can be rendered', function () {
    $response = $this->get('/register');

    $response->assertStatus(200);
});

test('new users can register', function () {
    $response = $this->post('/register', [
        'name' => 'Test User',
        'email' => 'test@example.com',
        'password' => 'password',
        'password_confirmation' => 'password',
    ]);

    $this->assertAuthenticated();
    $response->assertRedirect(route('dashboard', absolute: false));
});

test('new student and teacher registrations receive the right role', function () {
    $studentResponse = $this->post('/register', [
        'name' => 'Student User',
        'email' => 'student@example.com',
        'password' => 'password',
        'password_confirmation' => 'password',
        'role' => 'student',
    ]);

    $studentResponse->assertRedirect(route('dashboard', absolute: false));
    $studentUser = User::where('email', 'student@example.com')->first();
    expect($studentUser)->not->toBeNull();
    expect($studentUser->hasRole('Student'))->toBeTrue();

    Auth::logout();

    $teacherResponse = $this->post('/register', [
        'name' => 'Teacher User',
        'email' => 'teacher@example.com',
        'password' => 'password',
        'password_confirmation' => 'password',
        'role' => 'teacher',
        'specialization' => 'Mathematics',
    ]);

    $teacherResponse->assertRedirect(route('dashboard', absolute: false));
    $teacherUser = User::where('email', 'teacher@example.com')->first();
    expect($teacherUser)->not->toBeNull();
    expect($teacherUser->hasRole('Teacher'))->toBeTrue();
    expect($teacherUser->specialization)->toBe('Mathematics');
});
