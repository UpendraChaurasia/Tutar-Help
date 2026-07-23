<?php

namespace App\Providers;

use Illuminate\Support\Facades\Vite;
use Illuminate\Support\Facades\Route;
use Illuminate\Routing\Router;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Vite::prefetch(concurrency: 3);
        // register middleware aliases for role/permission checks (Spatie)
        if (class_exists(Router::class)) {
            $router = $this->app->make(Router::class);
            $router->aliasMiddleware('role', \Spatie\Permission\Middleware\RoleMiddleware::class);
            $router->aliasMiddleware('permission', \Spatie\Permission\Middleware\PermissionMiddleware::class);
            $router->aliasMiddleware('role_or_permission', \Spatie\Permission\Middleware\RoleOrPermissionMiddleware::class);
        }
    }
}
