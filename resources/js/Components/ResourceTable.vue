<script setup>
const props = defineProps({
    pagination: Object,
    emptyMessage: {
        type: String,
        default: 'No records found.',
    },
});
</script>

<template>
    <div class="rounded-2xl border border-slate-200 bg-white p-4 shadow-sm dark:border-slate-800 dark:bg-slate-900">
        <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-slate-200 text-sm dark:divide-slate-700">
                <slot />
            </table>
        </div>

        <div v-if="pagination?.links?.length" class="mt-6 flex flex-wrap items-center justify-between gap-3">
            <div class="text-sm text-slate-500 dark:text-slate-400">Showing {{ pagination.from }} to {{ pagination.to }} of {{ pagination.total }}</div>
            <div class="flex flex-wrap gap-2">
                <slot name="pagination" />
            </div>
        </div>

        <div v-else-if="!pagination?.data || pagination.data.length === 0" class="py-10 text-center text-sm text-slate-500 dark:text-slate-400">
            {{ emptyMessage }}
        </div>
    </div>
</template>
