<script setup>
import { Link } from '@inertiajs/vue3';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';

const props = defineProps({ student: Object });
</script>

<template>
    <AuthenticatedLayout>
        <div class="mx-auto max-w-3xl rounded-2xl border border-slate-200 bg-white p-6 shadow-sm dark:border-slate-800 dark:bg-slate-900">
            <div class="mb-6 flex items-center justify-between">
                <div>
                    <h1 class="text-2xl font-semibold text-slate-900 dark:text-white">Student Details</h1>
                    <p class="mt-1 text-sm text-slate-500 dark:text-slate-400">{{ student.name }}</p>
                </div>
                <Link :href="route('students.index')" class="rounded-lg border border-slate-300 px-4 py-2 text-sm font-medium text-slate-700 dark:border-slate-700 dark:text-slate-300">Back</Link>
            </div>

            <dl class="grid gap-4 md:grid-cols-2">
                <div class="rounded-lg border border-slate-200 p-4 dark:border-slate-800">
                    <dt class="text-sm font-medium text-slate-500 dark:text-slate-400">Name</dt>
                    <dd class="mt-1 text-sm text-slate-900 dark:text-white">{{ student.name }}</dd>
                </div>
                <div class="rounded-lg border border-slate-200 p-4 dark:border-slate-800">
                    <dt class="text-sm font-medium text-slate-500 dark:text-slate-400">Email</dt>
                    <dd class="mt-1 text-sm text-slate-900 dark:text-white">{{ student.email }}</dd>
                </div>
                <div class="rounded-lg border border-slate-200 p-4 dark:border-slate-800">
                    <dt class="text-sm font-medium text-slate-500 dark:text-slate-400">Phone</dt>
                    <dd class="mt-1 text-sm text-slate-900 dark:text-white">{{ student.phone || '—' }}</dd>
                </div>
                <div class="rounded-lg border border-slate-200 p-4 dark:border-slate-800">
                    <dt class="text-sm font-medium text-slate-500 dark:text-slate-400">Class</dt>
                    <dd class="mt-1 text-sm text-slate-900 dark:text-white">{{ student.specialization || '—' }}</dd>
                </div>
            </dl>
        </div>
    </AuthenticatedLayout>
</template>
