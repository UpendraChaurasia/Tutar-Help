<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link } from '@inertiajs/vue3';
const props = defineProps({ auth: Object });
</script>

<template>
    <Head title="Student Dashboard" />
    <AuthenticatedLayout>
        <template #header>
            <h2 class="text-xl font-semibold leading-tight text-gray-800">Student</h2>
        </template>

        <div class="py-12">
            <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
                <div class="overflow-hidden bg-white shadow-sm sm:rounded-lg">
                    <div class="p-6 text-gray-900">
                        Welcome, {{ auth.user.name }}.
                        <div class="mt-4">
                            <p class="text-sm text-gray-600">Access your purchased courses and track progress.</p>
                            <div class="mt-3">
                                <Link class="text-indigo-600 underline" href="/student/courses">My Courses</Link>
                                <span class="mx-2">|</span>
                                <Link class="text-indigo-600 underline" href="/student/progress">Progress</Link>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
