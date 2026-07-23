<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { Head, useForm } from '@inertiajs/vue3';

defineProps({
    status: {
        type: String,
    },
});

const form = useForm({
    email: '',
});

const submit = () => {
    form.post(route('password.email'));
};
</script>

<template>
    <GuestLayout>
        <Head title="Forgot Password" />

        <div class="mb-6 text-center">
            <h1 class="text-2xl font-bold text-zinc-900 dark:text-white">Forgot password?</h1>
            <p class="mt-1 text-sm text-zinc-500 dark:text-zinc-400">
                No problem. Enter your email and we'll send you a reset link.
            </p>
        </div>

        <div v-if="status" class="mb-4 rounded-md bg-green-50 px-3 py-2 text-sm font-medium text-green-600">
            {{ status }}
        </div>

        <form @submit.prevent="submit" class="space-y-4">
            <div>
                <InputLabel for="email" value="Email" />
                <TextInput
                    id="email"
                    type="email"
                    class="mt-1 block w-full"
                    v-model="form.email"
                    required
                    autofocus
                    autocomplete="username"
                />
                <InputError class="mt-2" :message="form.errors.email" />
            </div>

            <PrimaryButton
                class="w-full justify-center bg-amber-500 py-2.5 text-zinc-900 hover:bg-amber-400 focus:ring-amber-500"
                :class="{ 'opacity-25': form.processing }"
                :disabled="form.processing"
            >
                Email Password Reset Link
            </PrimaryButton>
        </form>
    </GuestLayout>
</template>