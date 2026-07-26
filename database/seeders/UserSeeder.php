<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        $specializations = ['Mathematics', 'English', 'Science', 'History', 'Physics', 'Art'];

        User::factory()
            ->count(4)
            ->state(fn () => [
                'phone' => fake()->phoneNumber(),
                'specialization' => fake()->randomElement($specializations),
                'status' => 'active',
            ])
            ->create()
            ->each(fn (User $user) => $user->assignRole('Teacher'));

        User::factory()
            ->count(8)
            ->state(fn () => [
                'phone' => fake()->phoneNumber(),
                'status' => fake()->randomElement(['active', 'inactive']),
            ])
            ->create()
            ->each(fn (User $user) => $user->assignRole('Student'));
    }
}
