<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class RoleSeeder extends Seeder
{
    public function run(): void
    {
        $permissions = [
            'admin.view',
            'admin.create',
            'admin.edit',
            'admin.delete',
            'teacher.view',
            'teacher.create',
            'teacher.edit',
            'teacher.delete',
            'student.view',
            'student.create',
            'student.edit',
            'student.delete',
            'role.view',
            'role.manage',
            'profile.edit',
        ];

        foreach ($permissions as $permission) {
            Permission::firstOrCreate(['name' => $permission]);
        }

        Role::firstOrCreate(['name' => 'Superadmin']);
        Role::firstOrCreate(['name' => 'Admin']);
        Role::firstOrCreate(['name' => 'Teacher']);
        Role::firstOrCreate(['name' => 'Student']);

        $super = User::firstOrCreate(
            ['email' => 'superadmin@example.com'],
            [
                'name' => 'Super Admin',
                'password' => Hash::make('password'),
                'email_verified_at' => now(),
                'phone' => null,
                'status' => 'active',
            ]
        );
        $super->assignRole('Superadmin');
        $super->givePermissionTo(Permission::all());

        $admin = User::firstOrCreate(
            ['email' => 'admin@example.com'],
            [
                'name' => 'Admin',
                'password' => Hash::make('password'),
                'email_verified_at' => now(),
                'phone' => null,
                'status' => 'active',
            ]
        );
        $admin->assignRole('Admin');
        $admin->givePermissionTo([
            'admin.view',
            'admin.create',
            'admin.edit',
            'admin.delete',
            'teacher.view',
            'teacher.create',
            'teacher.edit',
            'teacher.delete',
            'student.view',
            'student.create',
            'student.edit',
            'student.delete',
            'role.view',
        ]);
    }
}
