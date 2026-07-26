<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';

const props = defineProps({ role: Object });
</script>

<template>
    <AuthenticatedLayout>
        <div class="mx-auto max-w-3xl rounded-2xl border border-slate-200 bg-white p-6 shadow-sm dark:border-slate-800 dark:bg-slate-900">
            <div class="mb-6 flex items-center justify-between">
                <div>
                    <h1 class="text-2xl font-semibold text-slate-900 dark:text-white">Role Details</h1>
                    <p class="mt-1 text-sm text-slate-500 dark:text-slate-400">{{ role.name }}</p>
                </div>
                <a :href="route('roles.index')" class="rounded-lg border border-slate-300 px-4 py-2 text-sm font-medium text-slate-700 dark:border-slate-700 dark:text-slate-300">Back</a>
            </div>

            <div class="rounded-lg border border-slate-200 p-4 dark:border-slate-800">
                <h2 class="text-sm font-medium text-slate-500 dark:text-slate-400">Assigned Permissions</h2>
                <div class="mt-3 flex flex-wrap gap-2">
                    <span v-for="permission in role.permissions" :key="permission.id" class="rounded-full bg-amber-100 px-2.5 py-1 text-xs font-semibold text-amber-700 dark:bg-amber-950/40 dark:text-amber-300">
                        {{ permission.name }}
                    </span>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
