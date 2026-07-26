<script setup>
import { computed } from 'vue';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link } from '@inertiajs/vue3';

const props = defineProps({
    applications: Object,
});

const applications = computed(() => props.applications?.data || []);
const paginationLinks = computed(() => props.applications?.links || []);

const statusClasses = {
    pending: 'bg-amber-100 text-amber-700',
    approved: 'bg-emerald-100 text-emerald-700',
    rejected: 'bg-rose-100 text-rose-700',
    held: 'bg-slate-100 text-slate-700',
};
</script>

<template>
    <Head title="Teacher Applications" />

    <AuthenticatedLayout>
        <template #header>
            <div class="flex items-center justify-between">
                <div>
                    <h2 class="text-xl font-semibold text-slate-900">Teacher Applications</h2>
                    <p class="text-sm text-slate-600">Pending and reviewed teacher profile submissions.</p>
                </div>
            </div>
        </template>

        <div class="py-6">
            <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
                <div class="overflow-hidden rounded-3xl border border-slate-200 bg-white shadow-sm">
                    <div class="border-b border-slate-200 px-6 py-4">
                        <h3 class="text-lg font-semibold text-slate-900">Applications</h3>
                    </div>

                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-slate-200">
                            <thead class="bg-slate-50">
                                <tr>
                                    <th class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Teacher</th>
                                    <th class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Email</th>
                                    <th class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Status</th>
                                    <th class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Submitted</th>
                                    <th class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Reviewer</th>
                                    <th class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Remarks</th>
                                    <th class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-slate-200 bg-white">
                                <tr v-for="application in applications" :key="application.id">
                                    <td class="px-6 py-4 text-sm font-medium text-slate-900">{{ application.teacher?.name || 'N/A' }}</td>
                                    <td class="px-6 py-4 text-sm text-slate-600">{{ application.teacher?.email || 'N/A' }}</td>
                                    <td class="px-6 py-4 text-sm">
                                        <span class="rounded-full px-3 py-1 text-xs font-semibold uppercase tracking-[0.16em]" :class="statusClasses[application.status] || 'bg-slate-100 text-slate-700'">
                                            {{ application.status }}
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 text-sm text-slate-600">{{ application.submitted_at || '—' }}</td>
                                    <td class="px-6 py-4 text-sm text-slate-600">{{ application.reviewer?.name || 'Pending' }}</td>
                                    <td class="px-6 py-4 text-sm text-slate-600">{{ application.remarks || '—' }}</td>
                                    <td class="px-6 py-4 text-sm">
                                        <Link :href="route('teacher.applications.show', application.id)" class="font-semibold text-emerald-600 hover:text-emerald-700">
                                            View Application
                                        </Link>
                                    </td>
                                </tr>
                                <tr v-if="!applications.length">
                                    <td colspan="7" class="px-6 py-8 text-center text-sm text-slate-500">No teacher applications found.</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="border-t border-slate-200 px-6 py-4">
                        <div class="flex flex-wrap items-center justify-between gap-2">
                            <p class="text-sm text-slate-500">Page {{ props.applications?.current_page || 1 }} of {{ props.applications?.last_page || 1 }}</p>
                            <div class="flex flex-wrap items-center gap-2">
                                <Link
                                    v-for="link in paginationLinks"
                                    :key="link.label"
                                    :href="link.url || '#'"
                                    class="rounded-md border border-slate-300 px-3 py-2 text-sm font-medium text-slate-700 hover:bg-slate-100"
                                    :class="{ 'opacity-50 pointer-events-none': !link.url }"
                                    v-html="link.label"
                                ></Link>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
