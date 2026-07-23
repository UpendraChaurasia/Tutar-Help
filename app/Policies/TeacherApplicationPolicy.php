<?php

namespace App\Policies;

use App\Models\TeacherApplication;
use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class TeacherApplicationPolicy
{
    use HandlesAuthorization;

    public function view(User $user, TeacherApplication $application): bool
    {
        return $user->id === $application->profile->user_id || $user->hasAnyRole(['Admin', 'Superadmin']);
    }

    public function review(User $user): bool
    {
        return $user->hasAnyRole(['Admin', 'Superadmin']);
    }
}
