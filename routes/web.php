<?php

use App\Http\Controllers\ProfileController;
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

    if ($user->hasRole('Superadmin')) {
        return redirect()->route('superadmin.dashboard');
    }

    if ($user->hasRole('Admin')) {
        return redirect()->route('admin.dashboard');
    }

    if ($user->hasRole('Teacher')) {
        return redirect()->route('teacher.dashboard');
    }

    // default to student dashboard
    return redirect()->route('student.dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

// Role-protected dashboards
Route::middleware(['auth', 'role:Superadmin'])->prefix('superadmin')->name('superadmin.')->group(function () {
    Route::get('/dashboard', function () {
        return Inertia::render('Superadmin/Dashboard');
    })->name('dashboard');
});

Route::middleware(['auth', 'role:Admin'])->prefix('admin')->name('admin.')->group(function () {
    Route::get('/dashboard', function () {
        return Inertia::render('Admin/Dashboard');
    })->name('dashboard');
});

Route::middleware(['auth', 'role:Admin|Superadmin'])->group(function () {
    Route::get('/teacher-applications', [TeacherApplicationController::class, 'index'])->name('teacher.applications.index');
    Route::get('/teacher-applications/{application}', [TeacherApplicationController::class, 'show'])->name('teacher.applications.show');
    Route::post('/teacher-applications/{application}/review', [TeacherApplicationController::class, 'review'])->name('teacher.applications.review');
});

Route::middleware(['auth', 'role:Teacher'])->prefix('teacher')->name('teacher.')->group(function () {
    Route::get('/dashboard', function () {
        return Inertia::render('Teacher/Dashboard');
    })->name('dashboard');

    Route::get('/profile/edit', [TeacherProfileController::class, 'edit'])->name('profile.edit');
    Route::post('/profile', [TeacherProfileController::class, 'update'])->name('profile.update');
});

Route::middleware(['auth', 'role:Student'])->prefix('student')->name('student.')->group(function () {
    Route::get('/dashboard', function () {
        return Inertia::render('Student/Dashboard');
    })->name('dashboard');
});

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__ . '/auth.php';
