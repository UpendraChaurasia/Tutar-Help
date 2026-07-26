<script setup>
import InputError from '@/Components/InputError.vue';

const props = defineProps({
    label: String,
    for: String,
    error: String,
    help: String,
    required: Boolean,
});
</script>

<template>
    <div>
        <label v-if="label" :for="for" class="mb-2 block text-sm font-medium text-slate-700 dark:text-slate-300">
            {{ label }} <span v-if="required" class="text-rose-600">*</span>
        </label>

        <slot />

        <p v-if="help" class="mt-1 text-sm text-slate-500 dark:text-slate-400">{{ help }}</p>
        <InputError v-if="error" :message="error" class="mt-2" />
    </div>
</template>
