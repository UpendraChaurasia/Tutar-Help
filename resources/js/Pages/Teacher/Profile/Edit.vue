<script setup>
import { computed, ref, onMounted, watch } from 'vue';
import { Head, router, useForm } from '@inertiajs/vue3';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
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

const props = defineProps({ profile: Object, progress: Number, canSubmit: Boolean, lastSubmission: Object, storageUrl: String });
const step = ref(1);
const STEP_STORAGE_KEY = 'teacher_profile_step_v1';

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

const normalizeStringList = (items) => {
    if (!Array.isArray(items)) return [];
    return items
        .map((item) => {
            if (typeof item === 'string') return item;
            if (item && typeof item === 'object') {
                return item.subject_name || item.language || item.name || '';
            }
            return '';
        })
        .filter(Boolean);
};

const normalizeEducationList = (items) => {
    if (!Array.isArray(items)) return [];
    return items.map((education) => ({
        degree: education?.degree || '',
        college: education?.college || '',
        university: education?.university || '',
        country: education?.country || '',
        start_year: education?.start_year || '',
        end_year: education?.end_year || '',
        description: education?.description || '',
    }));
};

const normalizeExperienceList = (items) => {
    if (!Array.isArray(items)) return [];
    return items.map((experience) => ({
        company: experience?.company || '',
        designation: experience?.designation || '',
        industry: experience?.industry || '',
        start_date: normalizeDate(experience?.start_date),
        end_date: normalizeDate(experience?.end_date),
        currently_working: experience?.currently_working || false,
        description: experience?.description || '',
    }));
};

const normalizeCertificateList = (items) => {
    if (!Array.isArray(items)) return [];
    return items.map((certificate) => ({
        certificate_name: certificate?.certificate_name || '',
        issued_by: certificate?.issued_by || '',
        issue_date: normalizeDate(certificate?.issue_date),
        expiry_date: normalizeDate(certificate?.expiry_date),
        credential_id: certificate?.credential_id || '',
        credential_url: certificate?.credential_url || '',
        certificate_file: null,
        existing_file: certificate?.certificate_file || certificate?.certificate_file_url || null,
        delete_certificate_file: false,
    }));
};

const normalizeAvailabilityList = (items) => {
    if (!Array.isArray(items)) return [];
    return items.map((availability) => ({
        day: availability?.day || '',
        start_time: availability?.start_time || '',
        end_time: availability?.end_time || '',
    }));
};

const normalizeBankData = (profile) => {
    const bank = profile?.bank_account || profile?.bank || {};
    return {
        account_holder: bank.account_holder || '',
        bank_name: bank.bank_name || '',
        account_number: bank.account_number || '',
        ifsc: bank.ifsc || '',
        swift: bank.swift || '',
        iban: bank.iban || '',
        branch: bank.branch || '',
        paypal_email: bank.paypal_email || '',
        stripe_account: bank.stripe_account || '',
        preferred_method: bank.preferred_method || '',
    };
};

const normalizeSocialData = (profile) => {
    const socialLinks = Array.isArray(profile?.social_links) ? profile.social_links[0] || {} : (profile?.social_links || {});
    return {
        website: socialLinks.website || '',
        linkedin: socialLinks.linkedin || '',
        github: socialLinks.github || '',
        youtube: socialLinks.youtube || '',
        facebook: socialLinks.facebook || '',
        instagram: socialLinks.instagram || '',
        twitter: socialLinks.twitter || '',
        portfolio: socialLinks.portfolio || '',
    };
};

const getInitialFormState = (profile = props.profile) => ({
    profile_photo: null,
    gender: profile?.gender || '',
    date_of_birth: normalizeDate(profile?.date_of_birth),
    phone: profile?.phone || '',
    country: profile?.country || '',
    state: profile?.state || '',
    city: profile?.city || '',
    timezone: profile?.timezone || '',
    preferred_language: profile?.preferred_language || '',
    short_bio: profile?.short_bio || '',
    about_me: profile?.about_me || '',
    headline: profile?.headline || '',
    experience_years: profile?.experience_years || null,
    current_occupation: profile?.current_occupation || '',
    current_organization: profile?.current_organization || '',
    teaching_level: profile?.teaching_level || '',
    hourly_rate: profile?.hourly_rate || null,
    introduction_video: null,
    subjects: normalizeStringList(profile?.subjects),
    languages: normalizeStringList(profile?.languages),
    educations: normalizeEducationList(profile?.educations),
    experiences: normalizeExperienceList(profile?.experiences),
    certificates: normalizeCertificateList(profile?.certificates),
    step: step.value,
    document_type: profile?.documents?.[0]?.document_type || '',
    document_number: profile?.documents?.[0]?.document_number || '',
    front_image: null,
    back_image: null,
    selfie_image: null,
    address_proof: null,
    delete_front_image: false,
    delete_back_image: false,
    delete_selfie_image: false,
    delete_address_proof: false,
    availabilities: normalizeAvailabilityList(profile?.availabilities),
    bank: normalizeBankData(profile),
    social: normalizeSocialData(profile),
    submit_for_approval: false,
});

const form = useForm(getInitialFormState());

const syncFormFromProfile = (profile = props.profile) => {
    const nextState = getInitialFormState(profile);
    Object.keys(nextState).forEach((key) => {
        form[key] = nextState[key];
    });
    form.errors = {};
    form.step = step.value;
    form.submit_for_approval = false;
};

const isStepFilled = (id) => {
    const f = form;
    switch (id) {
        case 1:
            return Boolean(f.gender || f.date_of_birth || f.phone || f.timezone || f.country || f.state || f.city || f.preferred_language || f.profile_photo || props.profile?.profile_photo);
        case 2:
            return Boolean(f.headline || f.experience_years || f.current_occupation || (f.subjects && f.subjects.length) || (f.languages && f.languages.length));
        case 3:
            return Boolean(f.educations && f.educations.length);
        case 4:
            return Boolean(f.experiences && f.experiences.length);
        case 5:
            return Boolean(f.certificates && f.certificates.length);
        case 6:
            return Boolean(f.document_type || f.document_number || props.profile?.documents?.length);
        case 7:
            return Boolean(f.availabilities && f.availabilities.length);
        case 8: {
            const bankSource = props.profile?.bank_account || {};
            const hasFormBank = Boolean(f.bank && (f.bank.account_holder || f.bank.account_number || f.bank.paypal_email || f.bank.bank_name || f.bank.ifsc || f.bank.swift || f.bank.iban || f.bank.branch || f.bank.stripe_account || f.bank.preferred_method));
            const hasProfileBank = Boolean(bankSource.account_holder || bankSource.account_number || bankSource.paypal_email || bankSource.bank_name || bankSource.ifsc || bankSource.swift || bankSource.iban || bankSource.branch || bankSource.stripe_account || bankSource.preferred_method);
            return hasFormBank || hasProfileBank;
        }
        case 9:
            return Boolean(f.social && (f.social.website || f.social.linkedin || f.social.github || f.social.portfolio));
        case 10:
            return isStepFilled(1) && isStepFilled(2) && isStepFilled(3);
        default:
            return false;
    }
};

const completedSteps = computed(() => steps.map(s => isStepFilled(s.id)));


// Client-side validation helpers
const clearErrors = () => {
    // Clear previous client-side errors
    Object.keys(form.errors || {}).forEach((key) => {
        delete form.errors[key];
    });
};

const setError = (key, message) => {
    if (!form.errors) form.errors = {};
    form.errors[key] = message;
};

const isValidEmail = (email) => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
const isValidURL = (url) => {
    try {
        if (!url) return false;
        new URL(url);
        return true;
    } catch (e) {
        return false;
    }
};

const showSubmissionFeedback = (success, message) => {
    Swal.fire({
        icon: success ? 'success' : 'error',
        title: success ? 'Submission successful' : 'Submission failed',
        text: message,
        confirmButtonText: success ? 'Continue' : 'Try again',
        confirmButtonColor: '#f59e0b',
    });
};

const getSubmissionErrorMessage = (errors) => {
    const firstError = Array.isArray(errors?.submission)
        ? errors.submission[0]
        : (errors?.submission || errors?.message || errors?.error || 'Teacher profile submission failed. Please try again.');

    return typeof firstError === 'string' ? firstError : 'Teacher profile submission failed. Please try again.';
};

const validateStep = (s) => {
    // validate fields for step `s`. Return true if valid.
    let valid = true;
    // remove only client-side errors first
    clearErrors();

    if (s === 1) {
        if (!form.gender) { setError('gender', 'Gender is required'); valid = false; }
        if (!form.date_of_birth) { setError('date_of_birth', 'Date of birth is required'); valid = false; }
        if (!form.phone) { setError('phone', 'Phone number is required'); valid = false; }
        if (!form.timezone) { setError('timezone', 'Timezone is required'); valid = false; }
        if (!form.country) { setError('country', 'Country is required'); valid = false; }
        if (!form.state) { setError('state', 'State is required'); valid = false; }
        if (!form.city) { setError('city', 'City is required'); valid = false; }
        if (!form.preferred_language) { setError('preferred_language', 'Preferred language is required'); valid = false; }
    }

    if (s === 2) {
        if (!form.headline) { setError('headline', 'Headline is required'); valid = false; }
        if (form.experience_years === null || form.experience_years === '') { setError('experience_years', 'Years of experience is required'); valid = false; }
        if (!form.current_occupation) { setError('current_occupation', 'Current occupation is required'); valid = false; }
        if (!form.teaching_level) { setError('teaching_level', 'Teaching level is required'); valid = false; }
        if (form.hourly_rate !== null && form.hourly_rate !== '' && Number(form.hourly_rate) < 0) { setError('hourly_rate', 'Hourly rate must be a positive number'); valid = false; }
        if (!form.subjects || !form.subjects.length) { setError('subjects', 'At least one subject is required'); valid = false; }
        if (!form.languages || !form.languages.length) { setError('languages', 'At least one language is required'); valid = false; }
        if (form.introduction_video && !isValidURL(form.introduction_video)) { setError('introduction_video', 'Introduction video must be a valid URL'); valid = false; }
    }

    if (s === 3) {
        if (!form.educations || !form.educations.length) {
            setError('educations', 'Add at least one education entry');
            valid = false;
        } else {
            form.educations.forEach((edu, idx) => {
                if (!edu.degree) { setError(`educations.${idx}.degree`, `Degree required for entry ${idx + 1}`); valid = false; }
                if (!edu.college) { setError(`educations.${idx}.college`, `College required for entry ${idx + 1}`); valid = false; }
                if (!edu.university) { setError(`educations.${idx}.university`, `University required for entry ${idx + 1}`); valid = false; }
                if (!edu.country) { setError(`educations.${idx}.country`, `Country required for entry ${idx + 1}`); valid = false; }
            });
        }
    }

    if (s === 4) {
        // experiences optional, but if provided validate basic fields
        if (form.experiences && form.experiences.length) {
            form.experiences.forEach((exp, idx) => {
                if (!exp.company) { setError('experiences', `Company required for entry ${idx + 1}`); valid = false; }
                if (!exp.designation) { setError('experiences', `Designation required for entry ${idx + 1}`); valid = false; }
            });
        }
    }

    if (s === 5) {
        if (form.certificates && form.certificates.length) {
            form.certificates.forEach((c, idx) => {
                if (!c.certificate_name) { setError('certificates', `Certificate name required for entry ${idx + 1}`); valid = false; }
            });
        }
    }

    if (s === 6) {
        const existingDocument = props.profile.documents?.[0] || {};
        const hasDocumentDetails = Boolean(
            form.document_type ||
            form.document_number ||
            form.front_image ||
            form.back_image ||
            form.selfie_image ||
            form.address_proof ||
            existingDocument.front_image ||
            existingDocument.back_image ||
            existingDocument.selfie_image ||
            existingDocument.address_proof
        );

        if (hasDocumentDetails) {
            if (!form.document_type) { setError('document_type', 'Document type is required'); valid = false; }
            if (!form.document_number) { setError('document_number', 'Document number is required'); valid = false; }
        }
    }

    if (s === 7) {
        if (!form.availabilities || !form.availabilities.length) { setError('availabilities', 'Add at least one availability slot'); valid = false; }
        else {
            form.availabilities.forEach((a, idx) => {
                if (!a.day) { setError('availabilities', `Day required for slot ${idx + 1}`); valid = false; }
                if (!a.start_time) { setError('availabilities', `Start time required for slot ${idx + 1}`); valid = false; }
                if (!a.end_time) { setError('availabilities', `End time required for slot ${idx + 1}`); valid = false; }
                if (a.start_time && a.end_time && a.end_time <= a.start_time) { setError('availabilities', `End time must be after start time for slot ${idx + 1}`); valid = false; }
            });
        }
    }

    if (s === 8) {
        // Bank details are optional. No validation is required for this step.
    }

    if (s === 9) {
        // validate social urls if present
        const social = form.social || {};
        ['website','linkedin','github','youtube','facebook','instagram','twitter','portfolio'].forEach((k) => {
            if (social[k] && !isValidURL(social[k])) { setError(`social.${k}`, `${k} must be a valid URL`); valid = false; }
        });
    }

    return valid;
};

const validateAll = () => {
    // run validation for all steps; returns true if all valid
    for (let s = 1; s <= steps.length; s++) {
        if (!validateStep(s)) return false;
    }
    return true;
};

const handleNext = () => {
    if (!validateStep(step.value)) {
        return;
    }

    form.submit_for_approval = false;
    form.step = step.value;
    form.post(route('teacher.profile.update'), {
        preserveScroll: true,
        onSuccess: () => {
            router.reload({
                only: ['profile', 'progress', 'canSubmit', 'lastSubmission', 'storageUrl'],
            });
            if (step.value < steps.length) {
                step.value += 1;
            }
        },
    });
};

const handleSubmitForApproval = () => {
    if (validateAll()) {
        submitForApproval();
    }
};

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

const saveStepIndex = () => {
    try {
        localStorage.setItem(STEP_STORAGE_KEY, String(step.value));
    } catch (e) {
        // ignore storage errors
    }
};

const restoreStepIndex = () => {
    try {
        const stored = localStorage.getItem(STEP_STORAGE_KEY);
        if (stored) {
            const parsed = Number(stored);
            if (!Number.isNaN(parsed)) {
                step.value = parsed;
            }
        }
    } catch (e) {
        // ignore parse errors
    }
};

onMounted(() => {
    restoreStepIndex();
});

watch(step, saveStepIndex);
watch(() => props.profile, () => syncFormFromProfile(props.profile), { deep: true, immediate: true });

const submitForApproval = () => {
    form.submit_for_approval = true;
    form.post(route('teacher.profile.update'), {
        preserveScroll: true,
        onSuccess: () => {
            showSubmissionFeedback(true, 'Your teacher profile was submitted for approval successfully.');
            router.reload({
                only: ['profile', 'progress', 'canSubmit', 'lastSubmission', 'storageUrl'],
            });
            try { localStorage.removeItem(STEP_STORAGE_KEY); } catch (e) {}
        },
        onError: (errors) => {
            showSubmissionFeedback(false, getSubmissionErrorMessage(errors));
        },
    });
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
            <form id="teacher-profile-form" @submit.prevent enctype="multipart/form-data">
                <div class="mx-auto max-w-5xl space-y-6 px-3 sm:px-4 lg:px-0">
                    <ProfileSidebar :steps="steps" :active-step="step" :progress="progress" :form="form" :completed-steps="completedSteps" @change-step="setStep" />

                    <div class="rounded-3xl bg-white p-4 shadow-sm sm:p-6">
                        <div class="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between sm:gap-4">
                            <div>
                                <h3 class="text-base font-semibold text-slate-900 sm:text-lg">Step {{ step }}: {{ steps[step - 1].title }}</h3>
                                <p class="text-xs text-slate-500 sm:text-sm">Progress: {{ progress }}%</p>
                            </div>
                            <div class="w-full rounded-full bg-slate-200 p-1 sm:w-1/2">
                                <div class="h-2 rounded-full bg-amber-500 transition-all" :style="{ width: `${progress}%` }"></div>
                            </div>
                        </div>
                    </div>

                    <div class="space-y-6">
                        <component :is="stepComponent" :form="form" :profile="props.profile" :can-submit="props.canSubmit" :last-submission="props.lastSubmission" :storage-url="props.storageUrl" @submit-approval="handleSubmitForApproval" />
                    </div>

                    <div class="flex flex-wrap items-center justify-between gap-3 rounded-3xl bg-white p-5 shadow-sm sm:flex-nowrap">
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
                                v-if="step !== steps.length"
                                type="button"
                                class="inline-flex items-center rounded-md bg-slate-600 px-4 py-2 text-sm font-semibold text-white transition hover:bg-slate-700"
                                @click="handleNext"
                            >
                                Save & Next
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </AuthenticatedLayout>
</template>
