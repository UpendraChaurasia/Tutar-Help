<script setup>
import { computed } from 'vue';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, useForm } from '@inertiajs/vue3';

const props = defineProps({
    application: Object,
    storageUrl: String,
});

const form = useForm({
    decision: '',
    remarks: props.application?.remarks || '',
});

const formatValue = (value, fallback = 'Not provided') => {
    if (value === null || value === undefined || value === '') return fallback;
    return value;
};

const formatList = (items) => {
    if (!Array.isArray(items) || !items.length) return 'Not provided';
    return items.join(', ');
};

const resolveFileUrl = (path) => {
    if (!path) return null;
    if (path.startsWith('http://') || path.startsWith('https://')) return path;
    const baseUrl = props.storageUrl ? props.storageUrl.replace(/\/$/, '') : '';
    return baseUrl ? `${baseUrl}/${path}` : path;
};

const submitDecision = (decision) => {
    form.decision = decision;
    form.post(route('teacher.applications.review', props.application.id), {
        preserveScroll: true,
    });
};
</script>

<template>
    <Head title="Teacher Application Review" />

    <AuthenticatedLayout>
        <template #header>
            <div class="flex items-center justify-between">
                <div>
                    <h2 class="text-xl font-semibold text-slate-900">Application Review</h2>
                    <p class="text-sm text-slate-600">Review the teacher profile and decide on the application.</p>
                </div>
            </div>
        </template>

        <div class="py-6">
            <div class="mx-auto max-w-7xl space-y-6 px-4 sm:px-6 lg:px-8">
                <div class="rounded-3xl border border-slate-200 bg-white p-6 shadow-sm">
                    <div class="flex flex-wrap items-center justify-between gap-3">
                        <div>
                            <h3 class="text-lg font-semibold text-slate-900">{{ application.teacher?.name || 'Teacher' }}</h3>
                            <p class="text-sm text-slate-600">{{ application.teacher?.email || 'No email' }}</p>
                        </div>
                        <span class="rounded-full bg-amber-100 px-3 py-1 text-xs font-semibold uppercase tracking-[0.16em] text-amber-700">
                            {{ application.status }}
                        </span>
                    </div>

                    <div class="mt-6 grid gap-4 md:grid-cols-2">
                        <div class="md:col-span-2 flex flex-wrap items-center gap-4 rounded-2xl border border-slate-200 bg-slate-50 p-4">
                            <img v-if="application.teacher?.profile_photo_url || application.teacher?.profile_photo" :src="resolveFileUrl(application.teacher?.profile_photo_url || application.teacher?.profile_photo)" alt="Profile photo" class="h-20 w-20 rounded-full object-cover border border-slate-200" />
                            <div class="h-20 w-20 rounded-full border border-dashed border-slate-300 bg-white" v-else></div>
                            <div>
                                <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Profile Photo</p>
                                <p class="mt-1 text-sm text-slate-700">{{ application.teacher?.profile_photo ? '' : 'No profile photo uploaded' }}</p>
                            </div>
                        </div>
                        <div class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                            <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Full Name</p>
                            <p class="mt-1 text-slate-700">{{ formatValue(application.teacher?.name) }}</p>
                        </div>
                        <div class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                            <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Email</p>
                            <p class="mt-1 text-slate-700">{{ formatValue(application.teacher?.email) }}</p>
                        </div>
                        <div class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                            <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Headline</p>
                            <p class="mt-1 text-slate-700">{{ formatValue(application.teacher?.headline) }}</p>
                        </div>
                        <div class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                            <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Phone</p>
                            <p class="mt-1 text-slate-700">{{ formatValue(application.teacher?.phone) }}</p>
                        </div>
                        <div class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                            <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Location</p>
                            <p class="mt-1 text-slate-700">{{ formatValue([application.teacher?.city, application.teacher?.state, application.teacher?.country].filter(Boolean).join(', ')) }}</p>
                        </div>
                        <div class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                            <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Current Occupation</p>
                            <p class="mt-1 text-slate-700">{{ formatValue(application.teacher?.current_occupation) }}</p>
                        </div>
                        <div class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                            <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Teaching Level</p>
                            <p class="mt-1 text-slate-700">{{ formatValue(application.teacher?.teaching_level) }}</p>
                        </div>
                        <div class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                            <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Experience Years</p>
                            <p class="mt-1 text-slate-700">{{ formatValue(application.teacher?.experience_years) }}</p>
                        </div>
                        <div class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                            <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Hourly Rate</p>
                            <p class="mt-1 text-slate-700">{{ formatValue(application.teacher?.hourly_rate) }}</p>
                        </div>
                        <div class="md:col-span-2 rounded-2xl border border-slate-200 bg-slate-50 p-4">
                            <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Short Bio</p>
                            <p class="mt-1 text-slate-700">{{ formatValue(application.teacher?.short_bio) }}</p>
                        </div>
                        <div class="md:col-span-2 rounded-2xl border border-slate-200 bg-slate-50 p-4">
                            <p class="text-xs uppercase tracking-[0.16em] text-slate-500">About Me</p>
                            <p class="mt-1 text-slate-700">{{ formatValue(application.teacher?.about_me) }}</p>
                        </div>
                    </div>
                </div>

                <div class="rounded-3xl border border-slate-200 bg-white p-6 shadow-sm">
                    <h3 class="text-lg font-semibold text-slate-900">Professional Summary</h3>
                    <div class="mt-4 grid gap-4 md:grid-cols-2">
                        <div class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                            <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Subjects</p>
                            <p class="mt-1 text-slate-700">{{ formatList(application.teacher?.subjects || []) }}</p>
                        </div>
                        <div class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                            <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Languages</p>
                            <p class="mt-1 text-slate-700">{{ formatList(application.teacher?.languages || []) }}</p>
                        </div>
                    </div>
                </div>

                <div class="rounded-3xl border border-slate-200 bg-white p-6 shadow-sm">
                    <h3 class="text-lg font-semibold text-slate-900">Education</h3>
                    <div v-if="application.teacher?.educations?.length" class="mt-4 space-y-3">
                        <div v-for="(item, index) in application.teacher.educations" :key="index" class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                            <p class="font-semibold text-slate-800">{{ item.degree || 'Degree' }}</p>
                            <p class="mt-1 text-sm text-slate-700">{{ item.college || 'College' }} • {{ item.university || 'University' }}</p>
                            <p class="mt-1 text-sm text-slate-600">{{ item.country || 'Country' }}</p>
                        </div>
                    </div>
                    <p v-else class="mt-4 text-sm text-slate-500">No education entries added.</p>
                </div>

                <div class="rounded-3xl border border-slate-200 bg-white p-6 shadow-sm">
                    <h3 class="text-lg font-semibold text-slate-900">Experience</h3>
                    <div v-if="application.teacher?.experiences?.length" class="mt-4 space-y-3">
                        <div v-for="(item, index) in application.teacher.experiences" :key="index" class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                            <p class="font-semibold text-slate-800">{{ item.designation || 'Role' }}</p>
                            <p class="mt-1 text-sm text-slate-700">{{ item.company || 'Company' }}</p>
                            <p class="mt-1 text-sm text-slate-600">{{ item.description || 'No description provided' }}</p>
                        </div>
                    </div>
                    <p v-else class="mt-4 text-sm text-slate-500">No experience entries added.</p>
                </div>

                <div class="rounded-3xl border border-slate-200 bg-white p-6 shadow-sm">
                    <h3 class="text-lg font-semibold text-slate-900">Certificates</h3>
                    <div v-if="application.teacher?.certificates?.length" class="mt-4 space-y-3">
                        <div v-for="(item, index) in application.teacher.certificates" :key="index" class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                            <p class="font-semibold text-slate-800">{{ item.certificate_name || 'Certificate' }}</p>
                            <p class="mt-1 text-sm text-slate-700">{{ item.issued_by || 'Not provided' }}</p>
                        </div>
                    </div>
                    <p v-else class="mt-4 text-sm text-slate-500">No certificates added.</p>
                </div>

                <div class="rounded-3xl border border-slate-200 bg-white p-6 shadow-sm">
                    <h3 class="text-lg font-semibold text-slate-900">Identity Verification</h3>
                    <div v-if="application.teacher?.documents?.length" class="mt-4 grid gap-3 md:grid-cols-2">
                        <div v-for="(item, index) in application.teacher.documents" :key="index" class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                            <p class="text-sm font-semibold text-slate-800">{{ item.document_type || 'Document' }} • {{ item.document_number || 'N/A' }}</p>
                            <div v-if="item.front_image || item.back_image || item.selfie_image || item.address_proof" class="mt-3 space-y-2">
                                <div v-for="(file, fileIndex) in [item.front_image, item.back_image, item.selfie_image, item.address_proof].filter(Boolean)" :key="fileIndex">
                                    <a :href="resolveFileUrl(file)" target="_blank" class="text-sm font-medium text-emerald-600 hover:text-emerald-700">View file {{ fileIndex + 1 }}</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <p v-else class="mt-4 text-sm text-slate-500">No identity documents uploaded.</p>
                </div>

                <div class="rounded-3xl border border-slate-200 bg-white p-6 shadow-sm">
                    <h3 class="text-lg font-semibold text-slate-900">Availability</h3>
                    <div v-if="application.teacher?.availabilities?.length" class="mt-4 space-y-3">
                        <div v-for="(item, index) in application.teacher.availabilities" :key="index" class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                            <p class="font-semibold text-slate-800">{{ item.day || 'Day' }}</p>
                            <p class="mt-1 text-sm text-slate-700">{{ item.start_time || '—' }} - {{ item.end_time || '—' }}</p>
                        </div>
                    </div>
                    <p v-else class="mt-4 text-sm text-slate-500">No availability added.</p>
                </div>

                <div class="rounded-3xl border border-slate-200 bg-white p-6 shadow-sm">
                    <h3 class="text-lg font-semibold text-slate-900">Bank Details</h3>
                    <div v-if="application.teacher?.bank" class="mt-4 grid gap-3 md:grid-cols-2">
                        <div class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                            <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Preferred Method</p>
                            <p class="mt-1 text-slate-700">{{ formatValue(application.teacher.bank.preferred_method) }}</p>
                        </div>
                        <div class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                            <p class="text-xs uppercase tracking-[0.16em] text-slate-500">Account Holder</p>
                            <p class="mt-1 text-slate-700">{{ formatValue(application.teacher.bank.account_holder) }}</p>
                        </div>
                    </div>
                    <p v-else class="mt-4 text-sm text-slate-500">No bank details provided.</p>
                </div>

                <div class="rounded-3xl border border-slate-200 bg-white p-6 shadow-sm">
                    <h3 class="text-lg font-semibold text-slate-900">Social Links</h3>
                    <div v-if="application.teacher?.social" class="mt-4 space-y-2">
                        <div v-for="(value, key) in application.teacher.social" :key="key" class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                            <p class="text-xs uppercase tracking-[0.16em] text-slate-500">{{ key }}</p>
                            <p class="mt-1 text-sm text-slate-700">{{ formatValue(value) }}</p>
                        </div>
                    </div>
                    <p v-else class="mt-4 text-sm text-slate-500">No social links added.</p>
                </div>

                <div class="rounded-3xl border border-slate-200 bg-white p-6 shadow-sm">
                    <h3 class="text-lg font-semibold text-slate-900">Review Notes</h3>
                    <textarea v-model="form.remarks" rows="4" class="mt-4 w-full rounded-2xl border border-slate-300 px-3 py-2 text-sm text-slate-700" placeholder="Add review remarks..."></textarea>

                    <div class="mt-4 flex flex-wrap gap-3">
                        <button type="button" class="rounded-md bg-emerald-600 px-4 py-2 text-sm font-semibold text-white hover:bg-emerald-700" @click="submitDecision('approved')">Approve</button>
                        <button type="button" class="rounded-md bg-rose-600 px-4 py-2 text-sm font-semibold text-white hover:bg-rose-700" @click="submitDecision('rejected')">Reject</button>
                        <button type="button" class="rounded-md bg-amber-600 px-4 py-2 text-sm font-semibold text-white hover:bg-amber-700" @click="submitDecision('held')">Hold</button>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
