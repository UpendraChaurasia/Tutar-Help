<script setup>
import { computed } from 'vue';

const props = defineProps({
    form: Object,
    profile: Object,
    canSubmit: Boolean,
    lastSubmission: Object,
    storageUrl: String,
});

const formatValue = (value, fallback = 'Not provided') => {
    if (value === null || value === undefined || value === '') return fallback;
    return value;
};

const formatList = (items) => {
    if (!Array.isArray(items) || !items.length) return 'Not provided';
    return items.map((item) => item?.label || item?.name || item || '').filter(Boolean).join(', ');
};

const educationSummary = computed(() => (props.form.educations || []).map((item) => `${item.degree || 'Degree'} • ${item.college || 'College'} • ${item.university || 'University'}`));
const experienceSummary = computed(() => (props.form.experiences || []).map((item) => `${item.designation || 'Role'} • ${item.company || 'Company'}`));
const certificateSummary = computed(() => (props.form.certificates || []).map((item) => item.certificate_name || 'Certificate'));
const availabilitySummary = computed(() => (props.form.availabilities || []).map((item) => `${item.day || 'Day'} ${item.start_time || ''}-${item.end_time || ''}`.trim()));
const socialSummary = computed(() => {
    const items = [];
    Object.entries(props.form.social || {}).forEach(([key, value]) => {
        if (value) items.push(`${key}: ${value}`);
    });
    return items;
});

const resolveFileUrl = (path) => {
    if (!path) return null;
    if (path.startsWith('http://') || path.startsWith('https://')) return path;
    const baseUrl = props.storageUrl ? props.storageUrl.replace(/\/$/, '') : '';
    return baseUrl ? `${baseUrl}/${path}` : path;
};

const reviewPhoto = computed(() => resolveFileUrl(props.profile?.profile_photo_url || props.profile?.profile_photo));

const emitSubmitApproval = () => {
    emit('submit-approval');
};

const emit = defineEmits(['submit-approval']);
</script>

<template>
    <div class="rounded-3xl bg-white p-6 shadow-sm">
        <div class="space-y-6">
            <div class="flex flex-col gap-3 lg:flex-row lg:items-end lg:justify-between">
                <div>
                    <h3 class="text-lg font-semibold text-slate-900">Review & Submit</h3>
                    <p class="text-sm text-slate-500">Verify your profile before sending it for approval.</p>
                </div>
                <div class="rounded-2xl border border-emerald-200 bg-emerald-50 px-4 py-3 text-sm text-emerald-700">
                    Your submission will be reviewed by Admin and Superadmin.
                </div>
            </div>

            <div class="flex flex-col gap-4 rounded-2xl border border-slate-200 bg-slate-50 p-4 md:flex-row md:items-center">
                <img v-if="reviewPhoto" :src="reviewPhoto" alt="Profile photo" class="h-24 w-24 rounded-full border border-slate-200 object-cover" />
                <div class="h-24 w-24 rounded-full border border-dashed border-slate-300 bg-white" v-else></div>
                <div>
                    <p class="text-sm font-semibold text-slate-700">Profile Image</p>
                    <p class="mt-1 text-sm text-slate-600">{{ reviewPhoto ? 'Your uploaded profile image is visible here.' : 'No profile image uploaded yet.' }}</p>
                </div>
            </div>

            <div class="grid gap-4 md:grid-cols-2">
                <div class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                    <p class="text-sm font-semibold text-slate-700">Full Name</p>
                    <p class="mt-1 text-slate-600">{{ formatValue(profile?.user?.name) }}</p>
                </div>
                <div class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                    <p class="text-sm font-semibold text-slate-700">Email</p>
                    <p class="mt-1 text-slate-600">{{ formatValue(profile?.user?.email) }}</p>
                </div>
                <div class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                    <p class="text-sm font-semibold text-slate-700">Headline</p>
                    <p class="mt-1 text-slate-600">{{ formatValue(props.form.headline) }}</p>
                </div>
                <div class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                    <p class="text-sm font-semibold text-slate-700">Subjects</p>
                    <p class="mt-1 text-slate-600">{{ formatList(props.form.subjects?.map((subject) => ({ label: subject }))) }}</p>
                </div>
                <div class="md:col-span-2 rounded-2xl border border-slate-200 bg-slate-50 p-4">
                    <p class="text-sm font-semibold text-slate-700">Short Bio</p>
                    <p class="mt-1 text-slate-600">{{ formatValue(props.form.short_bio) }}</p>
                </div>
            </div>

            <div class="space-y-4">
                <div class="rounded-2xl border border-slate-200 p-4">
                    <h4 class="font-semibold text-slate-900">Professional Information</h4>
                    <div class="mt-3 grid gap-3 md:grid-cols-2">
                        <div>
                            <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Current Occupation</p>
                            <p class="mt-1 text-slate-600">{{ formatValue(props.form.current_occupation) }}</p>
                        </div>
                        <div>
                            <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Teaching Level</p>
                            <p class="mt-1 text-slate-600">{{ formatValue(props.form.teaching_level) }}</p>
                        </div>
                        <div>
                            <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Experience Years</p>
                            <p class="mt-1 text-slate-600">{{ formatValue(props.form.experience_years) }}</p>
                        </div>
                        <div>
                            <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Hourly Rate</p>
                            <p class="mt-1 text-slate-600">{{ formatValue(props.form.hourly_rate) }}</p>
                        </div>
                    </div>
                </div>

                <div class="rounded-2xl border border-slate-200 p-4">
                    <h4 class="font-semibold text-slate-900">Education</h4>
                    <ul v-if="educationSummary.length" class="mt-3 space-y-2 text-sm text-slate-600">
                        <li v-for="(item, index) in educationSummary" :key="index" class="rounded-lg bg-slate-50 px-3 py-2">{{ item }}</li>
                    </ul>
                    <p v-else class="mt-3 text-sm text-slate-500">No education entries added.</p>
                </div>

                <div class="rounded-2xl border border-slate-200 p-4">
                    <h4 class="font-semibold text-slate-900">Experience</h4>
                    <ul v-if="experienceSummary.length" class="mt-3 space-y-2 text-sm text-slate-600">
                        <li v-for="(item, index) in experienceSummary" :key="index" class="rounded-lg bg-slate-50 px-3 py-2">{{ item }}</li>
                    </ul>
                    <p v-else class="mt-3 text-sm text-slate-500">No experience entries added.</p>
                </div>

                <div class="rounded-2xl border border-slate-200 p-4">
                    <h4 class="font-semibold text-slate-900">Certificates</h4>
                    <ul v-if="certificateSummary.length" class="mt-3 space-y-2 text-sm text-slate-600">
                        <li v-for="(item, index) in certificateSummary" :key="index" class="rounded-lg bg-slate-50 px-3 py-2">{{ item }}</li>
                    </ul>
                    <p v-else class="mt-3 text-sm text-slate-500">No certificates added.</p>
                </div>

                <div class="rounded-2xl border border-slate-200 p-4">
                    <h4 class="font-semibold text-slate-900">Identity Verification</h4>
                    <div class="mt-3 grid gap-3 md:grid-cols-2">
                        <div>
                            <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Document Type</p>
                            <p class="mt-1 text-slate-600">{{ formatValue(props.form.document_type) }}</p>
                        </div>
                        <div>
                            <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Document Number</p>
                            <p class="mt-1 text-slate-600">{{ formatValue(props.form.document_number) }}</p>
                        </div>
                    </div>
                </div>

                <div class="rounded-2xl border border-slate-200 p-4">
                    <h4 class="font-semibold text-slate-900">Availability</h4>
                    <ul v-if="availabilitySummary.length" class="mt-3 space-y-2 text-sm text-slate-600">
                        <li v-for="(item, index) in availabilitySummary" :key="index" class="rounded-lg bg-slate-50 px-3 py-2">{{ item }}</li>
                    </ul>
                    <p v-else class="mt-3 text-sm text-slate-500">No availability slots added.</p>
                </div>

                <div class="rounded-2xl border border-slate-200 p-4">
                    <h4 class="font-semibold text-slate-900">Bank Details</h4>
                    <div class="mt-3 grid gap-3 md:grid-cols-2">
                        <div>
                            <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Preferred Method</p>
                            <p class="mt-1 text-slate-600">{{ formatValue(props.form.bank?.preferred_method) }}</p>
                        </div>
                        <div>
                            <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Account Holder</p>
                            <p class="mt-1 text-slate-600">{{ formatValue(props.form.bank?.account_holder) }}</p>
                        </div>
                    </div>
                </div>

                <div class="rounded-2xl border border-slate-200 p-4">
                    <h4 class="font-semibold text-slate-900">Social Links</h4>
                    <ul v-if="socialSummary.length" class="mt-3 space-y-2 text-sm text-slate-600">
                        <li v-for="(item, index) in socialSummary" :key="index" class="rounded-lg bg-slate-50 px-3 py-2">{{ item }}</li>
                    </ul>
                    <p v-else class="mt-3 text-sm text-slate-500">No social links added.</p>
                </div>
            </div>

            <div class="grid gap-3 rounded-3xl border border-slate-200 bg-white p-4 text-sm text-slate-700">
                <div class="flex flex-wrap items-center justify-between gap-3">
                    <div class="font-semibold text-slate-900">Approval Status</div>
                    <span class="rounded-full bg-amber-100 px-3 py-1 text-xs font-semibold uppercase tracking-[0.16em] text-amber-700">
                        {{ props.lastSubmission?.status ? props.lastSubmission.status : 'Pending submission' }}
                    </span>
                </div>
                <div class="grid gap-2 sm:grid-cols-3">
                    <div>
                        <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Last submitted</p>
                        <p class="mt-1 text-slate-600">{{ props.lastSubmission?.submitted_at || 'Not submitted yet' }}</p>
                    </div>
                    <div>
                        <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Current state</p>
                        <p class="mt-1 text-slate-600">{{ props.lastSubmission?.status ? props.lastSubmission.status : 'Not submitted' }}</p>
                    </div>
                    <div v-if="props.lastSubmission?.reviewed_by_name">
                        <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Reviewed by</p>
                        <p class="mt-1 text-slate-600">{{ props.lastSubmission.reviewed_by_name }}</p>
                    </div>
                </div>
            </div>

            <div class="flex flex-wrap gap-3">
                <button
                    type="button"
                    class="cursor-pointer rounded-md bg-emerald-600 px-4 py-2 text-sm font-semibold text-white hover:bg-emerald-700 disabled:cursor-not-allowed disabled:bg-slate-400"
                    :disabled="!props.canSubmit"
                    @click="emitSubmitApproval"
                >
                    {{ props.canSubmit ? 'Submit for Approval' : 'Already submitted' }}
                </button>
                <p v-if="props.canSubmit" class="self-center text-sm text-slate-500">The review step will validate your profile before submitting it for approval.</p>
                <p v-else class="self-center text-sm text-slate-500">Your profile is already under review. Please wait for verification from Admin or Superadmin.</p>
            </div>
        </div>
    </div>
</template>
