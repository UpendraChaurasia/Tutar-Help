<script setup>
import { defineProps, defineEmits } from 'vue';

const props = defineProps({
    steps: Array,
    activeStep: Number,
    progress: Number,
    form: Object,
    completedSteps: Array,
});

defineEmits(['change-step']);

const isStepCompleted = (id) => {
    if (Array.isArray(props.completedSteps) && typeof props.completedSteps[id - 1] !== 'undefined') {
        return Boolean(props.completedSteps[id - 1]);
    }
    const f = props.form || {};
    switch (id) {
        case 1:
            return Boolean(f.gender || f.date_of_birth || f.phone || f.timezone || f.country || f.state || f.city || f.preferred_language || f.profile_photo);
        case 2:
            return Boolean(f.headline || f.experience_years || f.current_occupation || (f.subjects && f.subjects.length) || (f.languages && f.languages.length));
        case 3:
            return Boolean(f.educations && f.educations.length);
        case 4:
            return Boolean(f.experiences && f.experiences.length);
        case 5:
            return Boolean(f.certificates && f.certificates.length);
        case 6:
            return Boolean(f.document_type || f.document_number);
        case 7:
            return Boolean(f.availabilities && f.availabilities.length);
        case 8:
            return Boolean(f.bank && (f.bank.account_holder || f.bank.account_number || f.bank.paypal_email || f.bank.bank_name || f.bank.ifsc || f.bank.swift || f.bank.iban || f.bank.branch || f.bank.stripe_account || f.bank.preferred_method));
        case 9:
            return Boolean(f.social && (f.social.website || f.social.linkedin || f.social.github || f.social.portfolio));
        case 10:
            // consider review complete if several core sections filled
            return isStepCompleted(1) && isStepCompleted(2) && isStepCompleted(3);
        default:
            return false;
    }
};

const canNavigateTo = (id) => {
    return id <= props.activeStep || isStepCompleted(id);
};
</script>

<template>
    <div class="rounded-3xl bg-white p-3 shadow-sm sm:p-4">
        <div class="grid grid-cols-2 gap-2 sm:grid-cols-3 lg:grid-cols-5">
            <button
                v-for="stepItem in steps"
                :key="stepItem.id"
                type="button"
                class="inline-flex items-center gap-1.5 rounded-full px-2.5 py-1.5 text-[11px] font-semibold leading-tight transition sm:text-xs"
                :class="[
                    stepItem.id === activeStep
                        ? 'bg-amber-500 text-white'
                        : isStepCompleted(stepItem.id)
                            ? 'bg-emerald-50 text-emerald-700 ring-1 ring-emerald-200 hover:bg-emerald-100'
                            : 'bg-slate-100 text-slate-600 hover:bg-slate-200',
                    !canNavigateTo(stepItem.id) ? 'cursor-not-allowed opacity-60 hover:bg-slate-100' : '',
                ]"
                :disabled="!canNavigateTo(stepItem.id)"
                @click="$emit('change-step', stepItem.id)"
            >
                <span
                    class="flex h-4 w-4 flex-shrink-0 items-center justify-center rounded-full text-[9px] font-bold"
                    :class="[
                        stepItem.id === activeStep
                            ? 'bg-black/15 text-white'
                            : isStepCompleted(stepItem.id)
                                ? 'bg-emerald-500 text-white'
                                : 'bg-slate-300 text-slate-600',
                    ]"
                >
                    <span v-if="isStepCompleted(stepItem.id)">✓</span>
                    <span v-else>{{ stepItem.id }}</span>
                </span>
                <span class="truncate">{{ stepItem.title }}</span>
            </button>
        </div>
    </div>
</template>
