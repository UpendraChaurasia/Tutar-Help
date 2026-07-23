<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';

const form = useForm({
    name: '',
    email: '',
    password: '',
    password_confirmation: '',
    role: 'student',
    specialization: '',
});

const submit = () => {
    form.post(route('register'), {
        onFinish: () => form.reset('password', 'password_confirmation'),
    });
};
</script>

<template>
    <GuestLayout>
        <Head title="Register" />

        <div class="mb-6 text-center">
            <h1 class="text-2xl font-bold text-zinc-900 dark:text-white">Create your account</h1>
            <p class="mt-1 text-sm text-zinc-500 dark:text-zinc-400">Join TuitionHub as a student or teacher</p>
        </div>

        <form @submit.prevent="submit" class="space-y-4">
            <div>
                <InputLabel for="name" value="Name" />
                <TextInput id="name" type="text" class="mt-1 block w-full" v-model="form.name" required autofocus autocomplete="name" />
                <InputError class="mt-2" :message="form.errors.name" />
            </div>

            <div>
                <InputLabel for="email" value="Email" />
                <TextInput id="email" type="email" class="mt-1 block w-full" v-model="form.email" required autocomplete="username" />
                <InputError class="mt-2" :message="form.errors.email" />
            </div>

            <div>
                <InputLabel for="role" value="Register As" />
                <select
                    id="role"
                    v-model="form.role"
                    class="mt-1 block w-full rounded-lg border-zinc-300 text-sm shadow-sm focus:border-amber-500 focus:ring-amber-500 dark:border-zinc-700 dark:bg-zinc-800 dark:text-white"
                >
                    <option value="student">Student</option>
                    <option value="teacher">Teacher</option>
                </select>
                <InputError class="mt-2" :message="form.errors.role" />
            </div>

            <div v-if="form.role === 'teacher'">
                <InputLabel for="specialization" value="Specialization" />
                <TextInput id="specialization" type="text" class="mt-1 block w-full" v-model="form.specialization" />
                <InputError class="mt-2" :message="form.errors.specialization" />
            </div>

            <div>
                <InputLabel for="password" value="Password" />
                <TextInput id="password" type="password" class="mt-1 block w-full" v-model="form.password" required autocomplete="new-password" />
                <InputError class="mt-2" :message="form.errors.password" />
            </div>

            <div>
                <InputLabel for="password_confirmation" value="Confirm Password" />
                <TextInput
                    id="password_confirmation"
                    type="password"
                    class="mt-1 block w-full"
                    v-model="form.password_confirmation"
                    required
                    autocomplete="new-password"
                />
                <InputError class="mt-2" :message="form.errors.password_confirmation" />
            </div>

            <PrimaryButton
                class="w-full justify-center bg-amber-500 py-2.5 text-zinc-900 hover:bg-amber-400 focus:ring-amber-500"
                :class="{ 'opacity-25': form.processing }"
                :disabled="form.processing"
            >
                Register
            </PrimaryButton>

            <p class="text-center text-sm text-zinc-500 dark:text-zinc-400">
                Already registered?
                <Link :href="route('login')" class="font-medium text-zinc-900 underline dark:text-white">Log in</Link>
            </p>
        </form>
    </GuestLayout>
</template>