<script setup>
import { useForm } from '@inertiajs/vue3';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import FormField from '@/Components/FormField.vue';

const props = defineProps({ role: Object, permissions: Array });

const form = useForm({
    name: props.role.name,
    permissions: props.role.permissions?.map((permission) => permission.id) || [],
});

const submit = () => {
    form.put(route('roles.update', props.role.id));
};
</script>

<template>
    <AuthenticatedLayout>
        <div class="mx-auto max-w-3xl rounded-2xl border border-slate-200 bg-white p-6 shadow-sm dark:border-slate-800 dark:bg-slate-900">
            <div class="mb-6">
                <h1 class="text-2xl font-semibold text-slate-900 dark:text-white">Edit Role</h1>
            </div>

            <form class="space-y-5" @submit.prevent="submit">
                <FormField label="Role Name" for="name" :error="form.errors.name" required>
                    <input id="name" v-model="form.name" type="text" class="w-full rounded-lg border border-slate-300 px-3 py-2 dark:border-slate-700 dark:bg-slate-950 dark:text-white" />
                </FormField>

                <FormField label="Permissions" for="permissions" :error="form.errors.permissions">
                    <div class="grid gap-3 rounded-lg border border-slate-200 p-4 dark:border-slate-700 md:grid-cols-2">
                        <label v-for="permission in permissions" :key="permission.id" class="flex items-center gap-2 rounded-lg border border-slate-200 p-2 text-sm text-slate-700 dark:border-slate-700 dark:text-slate-300">
                            <input type="checkbox" v-model="form.permissions" :value="permission.id" />
                            <span>{{ permission.name }}</span>
                        </label>
                    </div>
                </FormField>

                <div class="flex justify-end gap-3">
                    <button type="button" @click="$inertia.visit(route('roles.index'))" class="rounded-lg border border-slate-300 px-4 py-2 text-sm font-medium text-slate-700 dark:border-slate-700 dark:text-slate-300">Cancel</button>
                    <button type="submit" class="rounded-lg bg-amber-500 px-4 py-2 text-sm font-medium text-white hover:bg-amber-600">Update Role</button>
                </div>
            </form>
        </div>
    </AuthenticatedLayout>
</template>
