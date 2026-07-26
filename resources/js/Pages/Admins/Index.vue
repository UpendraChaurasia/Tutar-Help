<script setup>
import { computed, ref } from 'vue';
import { Link, router } from '@inertiajs/vue3';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import ResourceTable from '@/Components/ResourceTable.vue';

const props = defineProps({
    admins: Object,
    filters: Object,
    flash: Object,
});

const search = ref(props.filters?.search || '');
const sortField = ref(props.filters?.sort || 'created_at');
const sortDirection = ref(props.filters?.direction || 'desc');

const applyFilters = () => {
    router.get(route('admins.index'), {
        search: search.value,
        sort: sortField.value,
        direction: sortDirection.value,
    }, { preserveState: true, replace: true });
};

const toggleSort = (field) => {
    if (sortField.value === field) {
        sortDirection.value = sortDirection.value === 'asc' ? 'desc' : 'asc';
    } else {
        sortField.value = field;
        sortDirection.value = 'asc';
    }
    applyFilters();
};

const deleteAdmin = (admin) => {
    if (confirm(`Delete ${admin.name}?`)) {
        router.delete(route('admins.destroy', admin.id));
    }
};

const statusClasses = (status) => status === 'active' ? 'bg-emerald-100 text-emerald-700' : 'bg-amber-100 text-amber-700';
</script>

<template>
    <AuthenticatedLayout>
        <div class="space-y-6">
            <div class="flex flex-col gap-4 rounded-2xl border border-slate-200 bg-white p-6 shadow-sm dark:border-slate-800 dark:bg-slate-900 lg:flex-row lg:items-center lg:justify-between">
                <div>
                    <h1 class="text-2xl font-semibold text-slate-900 dark:text-white">Admins</h1>
                    <p class="mt-1 text-sm text-slate-500 dark:text-slate-400">Manage platform administrators.</p>
                </div>
                <Link :href="route('admins.create')" class="inline-flex items-center justify-center rounded-lg bg-amber-500 px-4 py-2 text-sm font-medium text-white transition hover:bg-amber-600">
                    Add Admin
                </Link>
            </div>

            <div v-if="flash?.success" class="rounded-lg border border-emerald-200 bg-emerald-50 px-4 py-3 text-sm text-emerald-700 dark:border-emerald-800 dark:bg-emerald-950/40 dark:text-emerald-300">
                {{ flash.success }}
            </div>

            <div class="rounded-2xl border border-slate-200 bg-white p-4 shadow-sm dark:border-slate-800 dark:bg-slate-900">
                <div class="flex flex-col gap-3 md:flex-row md:items-center md:justify-between">
                    <input v-model="search" type="text" placeholder="Search by name, email or phone" class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none dark:border-slate-700 dark:bg-slate-950 dark:text-white md:max-w-sm" @keyup.enter="applyFilters" />
                    <button @click="applyFilters" class="rounded-lg bg-slate-800 px-4 py-2 text-sm font-medium text-white hover:bg-slate-700 dark:bg-slate-700 dark:hover:bg-slate-600">Search</button>
                </div>

                <ResourceTable :pagination="admins" emptyMessage="No admins found.">
                    <thead>
                        <tr class="text-left text-slate-600 dark:text-slate-400">
                            <th class="px-4 py-3 font-medium"><button class="flex items-center gap-1" @click="toggleSort('name')">Name</button></th>
                            <th class="px-4 py-3 font-medium"><button class="flex items-center gap-1" @click="toggleSort('email')">Email</button></th>
                            <th class="px-4 py-3 font-medium">Phone</th>
                            <th class="px-4 py-3 font-medium"><button class="flex items-center gap-1" @click="toggleSort('status')">Status</button></th>
                            <th class="px-4 py-3 font-medium"><button class="flex items-center gap-1" @click="toggleSort('created_at')">Created Date</button></th>
                            <th class="px-4 py-3 font-medium">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-200 dark:divide-slate-700">
                        <tr v-for="admin in admins.data" :key="admin.id" class="hover:bg-slate-50 dark:hover:bg-slate-800/50">
                            <td class="px-4 py-3 font-medium text-slate-900 dark:text-white">{{ admin.name }}</td>
                            <td class="px-4 py-3 text-slate-600 dark:text-slate-400">{{ admin.email }}</td>
                            <td class="px-4 py-3 text-slate-600 dark:text-slate-400">{{ admin.phone || '—' }}</td>
                            <td class="px-4 py-3"><span class="rounded-full px-2.5 py-1 text-xs font-semibold" :class="statusClasses(admin.status)">{{ admin.status }}</span></td>
                            <td class="px-4 py-3 text-slate-600 dark:text-slate-400">{{ new Date(admin.created_at).toLocaleDateString() }}</td>
                            <td class="px-4 py-3">
                                <div class="flex flex-wrap gap-2">
                                    <Link :href="route('admins.show', admin.id)" class="rounded-md border border-slate-300 px-2.5 py-1 text-xs font-medium text-slate-700 hover:bg-slate-100 dark:border-slate-700 dark:text-slate-300">View</Link>
                                    <Link :href="route('admins.edit', admin.id)" class="rounded-md border border-amber-300 px-2.5 py-1 text-xs font-medium text-amber-700 hover:bg-amber-50 dark:border-amber-700 dark:text-amber-400">Edit</Link>
                                    <button @click="deleteAdmin(admin)" class="rounded-md border border-rose-300 px-2.5 py-1 text-xs font-medium text-rose-700 hover:bg-rose-50 dark:border-rose-700 dark:text-rose-400">Delete</button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                    <template #pagination>
                        <Link v-for="link in admins.links" :key="link.label" :href="link.url || '#'" class="rounded-md border border-slate-300 px-3 py-2 text-sm font-medium text-slate-700 hover:bg-slate-100 dark:border-slate-700 dark:text-slate-300" v-html="link.label"></Link>
                    </template>
                </ResourceTable>
            </div>
        </div>
    </AuthenticatedLayout>
</template>