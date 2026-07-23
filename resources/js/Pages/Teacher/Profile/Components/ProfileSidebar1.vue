<script setup>
import { defineProps, defineEmits } from 'vue';

const props = defineProps({
    steps: Array,
    activeStep: Number,
    progress: Number,
});

const emit = defineEmits(['change-step']);
</script>

<template>
    <div class="space-y-4 rounded-3xl bg-white p-5 shadow-sm">
        <div class="rounded-3xl border border-slate-200 bg-slate-50 p-4">
            <p class="text-sm font-semibold text-slate-900">Profile Progress</p>
            <p class="mt-2 text-3xl font-bold text-slate-900">{{ progress }}%</p>
        </div>

        <nav class="space-y-2">
            <template v-for="stepItem in steps" :key="stepItem.id">
                <button
                    type="button"
                    class="flex w-full items-center justify-between rounded-2xl px-4 py-3 text-left text-sm font-medium transition hover:bg-slate-50"
                    :class="stepItem.id === activeStep ? 'bg-amber-500 text-white' : 'bg-white text-slate-700'"
                    @click="$emit('change-step', stepItem.id)"
                >
                    <span>{{ stepItem.id }}. {{ stepItem.title }}</span>
                    <span class="text-xs">{{ stepItem.id === activeStep ? 'Current' : '' }}</span>
                </button>
            </template>
        </nav>
    </div>
</template>
