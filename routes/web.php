<?php

use App\Http\Controllers\AdminController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\StudentController;
use App\Http\Controllers\TeacherController;
use App\Http\Controllers\TeacherApplicationController;
use App\Http\Controllers\TeacherProfileController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    // show login page at root for guests, or redirect authenticated users to their dashboard
    if (auth()->check()) {
        return redirect()->route('dashboard');
    }

    return redirect()->route('login');
});

Route::get('/dashboard', function () {
    $user = auth()->user();
    if (! $user) {
        return redirect()->route('login');
    }

    if ($user->hasRole('Superadmin') || $user->hasRole('Admin')) {
        return Inertia::render('Admin/Dashboard');
    }

    if ($user->hasRole('Teacher')) {
        return Inertia::render('Teacher/Dashboard');
    }

    return Inertia::render('Student/Dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware(['auth', 'role:Admin|Superadmin'])->group(function () {
    Route::get('/teacher-applications', [TeacherApplicationController::class, 'index'])->name('teacher.applications.index');
    Route::get('/teacher-applications/{application}', [TeacherApplicationController::class, 'show'])->name('teacher.applications.show');
    Route::post('/teacher-applications/{application}/review', [TeacherApplicationController::class, 'review'])->name('teacher.applications.review');
});

Route::middleware(['auth', 'role:Teacher'])->group(function () {
    Route::get('/profile/edit', [TeacherProfileController::class, 'edit'])->name('teacher.profile.edit');
    Route::post('/profile', [TeacherProfileController::class, 'update'])->name('teacher.profile.update');
});

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

Route::middleware(['auth', 'verified'])->group(function () {
    Route::resource('admins', AdminController::class);
    Route::resource('teachers', TeacherController::class);
    Route::resource('students', StudentController::class);
    Route::resource('roles', RoleController::class);
});

require __DIR__ . '/auth.php';

