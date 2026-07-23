<?php

namespace App\Policies;

use App\Models\TeacherProfile;
use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class TeacherProfilePolicy
{
    use HandlesAuthorization;

    public function view(User $user, TeacherProfile $profile): bool
    {
        return $user->id === $profile->user_id || $user->hasAnyRole(['Admin', 'Superadmin']);
    }

    public function update(User $user, TeacherProfile $profile): bool
    {
        return $user->id === $profile->user_id;
    }

    public function approve(User $user): bool
    {
        return $user->hasAnyRole(['Admin', 'Superadmin']);
    }

    public function submit(User $user): bool
    {
        return $user->hasRole('Teacher');
    }
}
