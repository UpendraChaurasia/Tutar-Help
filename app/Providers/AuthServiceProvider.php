<?php

namespace App\Providers;

use App\Models\TeacherApplication;
use App\Models\TeacherProfile;
use App\Policies\TeacherApplicationPolicy;
use App\Policies\TeacherProfilePolicy;
use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;
use Illuminate\Support\Facades\Gate;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * The policy mappings for the application.
     *
     * @var array<class-string, class-string>
     */
    protected $policies = [
        TeacherProfile::class => TeacherProfilePolicy::class,
        TeacherApplication::class => TeacherApplicationPolicy::class,
    ];

    /**
     * Register any authentication / authorization services.
     */
    public function boot(): void
    {
        $this->registerPolicies();

        Gate::policy(TeacherProfile::class, TeacherProfilePolicy::class);
        Gate::policy(TeacherApplication::class, TeacherApplicationPolicy::class);
    }
}
