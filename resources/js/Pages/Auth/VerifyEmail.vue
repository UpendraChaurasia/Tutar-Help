<script setup>
import { computed } from 'vue';
import GuestLayout from '@/Layouts/GuestLayout.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';

const props = defineProps({
    status: {
        type: String,
    },
});

const form = useForm({});

const submit = () => {
    form.post(route('verification.send'));
};

const verificationLinkSent = computed(
    () => props.status === 'verification-link-sent',
);
</script>

<template>
    <GuestLayout>
        <Head title="Email Verification" />

        <div class="mb-6 text-center">
            <h1 class="text-2xl font-bold text-slate-900">Verify your email</h1>
            <p class="mt-2 text-sm text-slate-500">
                Thanks for signing up! Please verify your email by clicking the link we
                just sent you. Didn't get it? We'll gladly send another.
            </p>
        </div>

        <div v-if="verificationLinkSent" class="mb-4 rounded-md bg-green-50 px-3 py-2 text-sm font-medium text-green-600">
            A new verification link has been sent to your email address.
        </div>

        <form @submit.prevent="submit" class="flex items-center justify-between">
            <PrimaryButton :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
                Resend Verification Email
            </PrimaryButton>

            <Link
                :href="route('logout')"
                method="post"
                as="button"
                class="text-sm text-slate-600 underline hover:text-slate-900"
            >
                Log Out
            </Link>
        </form>
    </GuestLayout>
</template>
