<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;

class PermissionSeeder extends Seeder
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
    }
}
