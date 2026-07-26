<script setup>
import { useForm } from '@inertiajs/vue3';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import FormField from '@/Components/FormField.vue';

const props = defineProps({ admin: Object });

const form = useForm({
    name: props.admin.name,
    email: props.admin.email,
    phone: props.admin.phone || '',
    password: '',
    password_confirmation: '',
    status: props.admin.status || 'active',
});

const submit = () => {
    form.put(route('admins.update', props.admin.id));
};
</script>

<template>
    <AuthenticatedLayout>
        <div class="mx-auto max-w-3xl rounded-2xl border border-slate-200 bg-white p-6 shadow-sm dark:border-slate-800 dark:bg-slate-900">
            <div class="mb-6">
                <h1 class="text-2xl font-semibold text-slate-900 dark:text-white">Edit Admin</h1>
            </div>

            <form class="space-y-5" @submit.prevent="submit">
                <div class="grid gap-5 md:grid-cols-2">
                    <FormField label="Name" for="name" :error="form.errors.name" required>
                        <input id="name" v-model="form.name" type="text" class="w-full rounded-lg border border-slate-300 px-3 py-2 dark:border-slate-700 dark:bg-slate-950 dark:text-white" />
                    </FormField>

                    <FormField label="Email" for="email" :error="form.errors.email" required>
                        <input id="email" v-model="form.email" type="email" class="w-full rounded-lg border border-slate-300 px-3 py-2 dark:border-slate-700 dark:bg-slate-950 dark:text-white" />
                    </FormField>

                    <FormField label="Phone" for="phone" :error="form.errors.phone">
                        <input id="phone" v-model="form.phone" type="text" class="w-full rounded-lg border border-slate-300 px-3 py-2 dark:border-slate-700 dark:bg-slate-950 dark:text-white" />
                    </FormField>

                    <FormField label="Status" for="status" :error="form.errors.status" required>
                        <select id="status" v-model="form.status" class="w-full rounded-lg border border-slate-300 px-3 py-2 dark:border-slate-700 dark:bg-slate-950 dark:text-white">
                            <option value="active">Active</option>
                            <option value="inactive">Inactive</option>
                        </select>
                    </FormField>

                    <FormField label="New Password" for="password" :error="form.errors.password">
                        <input id="password" v-model="form.password" type="password" class="w-full rounded-lg border border-slate-300 px-3 py-2 dark:border-slate-700 dark:bg-slate-950 dark:text-white" />
                    </FormField>

                    <FormField label="Confirm Password" for="password_confirmation" :error="form.errors.password_confirmation">
                        <input id="password_confirmation" v-model="form.password_confirmation" type="password" class="w-full rounded-lg border border-slate-300 px-3 py-2 dark:border-slate-700 dark:bg-slate-950 dark:text-white" />
                    </FormField>
                </div>

                <div class="flex justify-end gap-3">
                    <button type="button" @click="$inertia.visit(route('admins.index'))" class="rounded-lg border border-slate-300 px-4 py-2 text-sm font-medium text-slate-700 dark:border-slate-700 dark:text-slate-300">Cancel</button>
                    <button type="submit" class="rounded-lg bg-amber-500 px-4 py-2 text-sm font-medium text-white hover:bg-amber-600">Update Admin</button>
                </div>
            </form>
        </div>
    </AuthenticatedLayout>
</template>
