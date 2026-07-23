<script setup>
import { computed, ref } from 'vue';
import { Head, useForm } from '@inertiajs/vue3';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import ProfileSidebar from '@/Pages/Teacher/Profile/Components/ProfileSidebar.vue';
import StepBasicInformation from '@/Pages/Teacher/Profile/Steps/StepBasicInformation.vue';
import StepProfessionalInformation from '@/Pages/Teacher/Profile/Steps/StepProfessionalInformation.vue';
import StepEducation from '@/Pages/Teacher/Profile/Steps/StepEducation.vue';
import StepExperience from '@/Pages/Teacher/Profile/Steps/StepExperience.vue';
import StepCertificates from '@/Pages/Teacher/Profile/Steps/StepCertificates.vue';
import StepIdentityVerification from '@/Pages/Teacher/Profile/Steps/StepIdentityVerification.vue';
import StepAvailability from '@/Pages/Teacher/Profile/Steps/StepAvailability.vue';
import StepBankDetails from '@/Pages/Teacher/Profile/Steps/StepBankDetails.vue';
import StepSocialLinks from '@/Pages/Teacher/Profile/Steps/StepSocialLinks.vue';
import StepReviewSubmit from '@/Pages/Teacher/Profile/Steps/StepReviewSubmit.vue';

const props = defineProps({ profile: Object, progress: Number, canSubmit: Boolean });
const step = ref(1);

const steps = [
    { id: 1, title: 'Basic Information' },
    { id: 2, title: 'Professional Information' },
    { id: 3, title: 'Education' },
    { id: 4, title: 'Experience' },
    { id: 5, title: 'Certificates' },
    { id: 6, title: 'Identity Verification' },
    { id: 7, title: 'Availability' },
    { id: 8, title: 'Bank Details' },
    { id: 9, title: 'Social Links' },
    { id: 10, title: 'Review & Submit' },
];

const stepComponent = computed(() => ({
    1: StepBasicInformation,
    2: StepProfessionalInformation,
    3: StepEducation,
    4: StepExperience,
    5: StepCertificates,
    6: StepIdentityVerification,
    7: StepAvailability,
    8: StepBankDetails,
    9: StepSocialLinks,
    10: StepReviewSubmit,
}[step.value]));

const normalizeDate = (value) => {
    if (!value) return '';
    return value.split('T')[0];
};

const form = useForm({
    profile_photo: null,
    gender: props.profile.gender || '',
    date_of_birth: normalizeDate(props.profile.date_of_birth),
    phone: props.profile.phone || '',
    country: props.profile.country || '',
    state: props.profile.state || '',
    city: props.profile.city || '',
    timezone: props.profile.timezone || '',
    preferred_language: props.profile.preferred_language || '',
    short_bio: props.profile.short_bio || '',
    about_me: props.profile.about_me || '',
    headline: props.profile.headline || '',
    experience_years: props.profile.experience_years || null,
    current_occupation: props.profile.current_occupation || '',
    current_organization: props.profile.current_organization || '',
    teaching_level: props.profile.teaching_level || '',
    hourly_rate: props.profile.hourly_rate || null,
    introduction_video: null,
    subjects: props.profile.subjects?.map(subject => subject.subject_name) || [],
    languages: props.profile.languages?.map(language => language.language) || [],
    educations: props.profile.educations?.map(education => ({
        degree: education.degree,
        college: education.college,
        university: education.university,
        country: education.country,
        start_year: education.start_year,
        end_year: education.end_year,
        description: education.description,
    })) || [],
    experiences: props.profile.experiences?.map(experience => ({
        company: experience.company,
        designation: experience.designation,
        industry: experience.industry,
        start_date: normalizeDate(experience.start_date),
        end_date: normalizeDate(experience.end_date),
        currently_working: experience.currently_working,
        description: experience.description,
    })) || [],
    certificates: props.profile.certificates?.map(certificate => ({
        certificate_name: certificate.certificate_name,
        issued_by: certificate.issued_by,
        issue_date: normalizeDate(certificate.issue_date),
        expiry_date: normalizeDate(certificate.expiry_date),
        credential_id: certificate.credential_id,
        credential_url: certificate.credential_url,
        certificate_file: null,
        existing_file: certificate.certificate_file,
    })) || [],
    document_type: props.profile.documents?.[0]?.document_type || '',
    document_number: props.profile.documents?.[0]?.document_number || '',
    front_image: null,
    back_image: null,
    selfie_image: null,
    address_proof: null,
    availabilities: props.profile.availabilities?.map(availability => ({
        day: availability.day,
        start_time: availability.start_time,
        end_time: availability.end_time,
    })) || [],
    bank: {
        account_holder: props.profile.bank_account?.account_holder || '',
        bank_name: props.profile.bank_account?.bank_name || '',
        account_number: props.profile.bank_account?.account_number || '',
        ifsc: props.profile.bank_account?.ifsc || '',
        swift: props.profile.bank_account?.swift || '',
        iban: props.profile.bank_account?.iban || '',
        branch: props.profile.bank_account?.branch || '',
        paypal_email: props.profile.bank_account?.paypal_email || '',
        stripe_account: props.profile.bank_account?.stripe_account || '',
        preferred_method: props.profile.bank_account?.preferred_method || '',
    },
    social: {
        website: props.profile.social_links?.[0]?.website || '',
        linkedin: props.profile.social_links?.[0]?.linkedin || '',
        github: props.profile.social_links?.[0]?.github || '',
        youtube: props.profile.social_links?.[0]?.youtube || '',
        facebook: props.profile.social_links?.[0]?.facebook || '',
        instagram: props.profile.social_links?.[0]?.instagram || '',
        twitter: props.profile.social_links?.[0]?.twitter || '',
        portfolio: props.profile.social_links?.[0]?.portfolio || '',
    },
    save_as_draft: false,
    submit_for_approval: false,
});

const nextStep = () => {
    if (step.value < steps.length) {
        step.value += 1;
    }
};

const previousStep = () => {
    if (step.value > 1) {
        step.value -= 1;
    }
};

const setStep = selected => {
    step.value = selected;
};

const saveDraft = () => {
    form.save_as_draft = true;
    form.submit_for_approval = false;
    form.post(route('teacher.profile.update'));
};

const submitForApproval = () => {
    form.save_as_draft = false;
    form.submit_for_approval = true;
    form.post(route('teacher.profile.update'));
};
</script>

<template>
    <Head title="Teacher Profile" />

    <AuthenticatedLayout>
        <template #header>
            <div class="flex flex-col gap-2">
                <h2 class="text-xl font-semibold leading-tight text-gray-800">Teacher Profile</h2>
                <p class="text-sm text-gray-600">Complete your teacher profile in multiple steps.</p>
            </div>
        </template>

        <div class="py-6">
            <form id="teacher-profile-form" @submit.prevent="saveDraft" enctype="multipart/form-data">
                <div class="mx-auto grid max-w-7xl gap-6 lg:grid-cols-[280px_1fr]">
                    <ProfileSidebar :steps="steps" :active-step="step" :progress="progress" @change-step="setStep" />

                    <div>
                        <div class="mb-6 rounded-3xl bg-white p-5 shadow-sm sm:p-6">
                            <div class="flex items-center justify-between gap-4">
                                <div>
                                    <h3 class="text-lg font-semibold text-slate-900">Step {{ step }}: {{ steps[step - 1].title }}</h3>
                                    <p class="text-sm text-slate-500">Progress: {{ progress }}%</p>
                                </div>
                                <div class="w-1/2 rounded-full bg-slate-200 p-1">
                                    <div class="h-2 rounded-full bg-amber-500" :style="{ width: `${progress}%` }"></div>
                                </div>
                            </div>
                        </div>

                        <div class="space-y-6">
                            <component :is="stepComponent" :form="form" :profile="props.profile" :can-submit="props.canSubmit" @submit-approval="submitForApproval" />
                        </div>

                        <div class="mt-8 flex flex-wrap items-center justify-between gap-3 rounded-3xl bg-white p-5 shadow-sm sm:flex-nowrap">
                            <button
                                type="button"
                                class="inline-flex items-center rounded-md border border-slate-300 bg-white px-4 py-2 text-sm font-semibold text-slate-700 transition hover:bg-slate-50"
                                @click="previousStep"
                                :disabled="step === 1"
                            >
                                Previous
                            </button>

                            <div class="flex flex-wrap gap-3">
                                <button
                                    type="button"
                                    class="inline-flex items-center rounded-md bg-slate-600 px-4 py-2 text-sm font-semibold text-white transition hover:bg-slate-700"
                                    @click="nextStep"
                                    :disabled="step === steps.length"
                                >
                                    Save & Next
                                </button>
                                <button
                                    type="submit"
                                    class="inline-flex items-center rounded-md bg-amber-500 px-4 py-2 text-sm font-semibold text-white transition hover:bg-amber-600"
                                >
                                    Save as Draft
                                </button>
                                <button
                                    v-if="step === steps.length"
                                    type="button"
                                    class="inline-flex items-center rounded-md bg-emerald-600 px-4 py-2 text-sm font-semibold text-white transition hover:bg-emerald-700"
                                    @click="submitForApproval"
                                    :disabled="!canSubmit"
                                >
                                    Submit for Approval
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </AuthenticatedLayout>
</template>
