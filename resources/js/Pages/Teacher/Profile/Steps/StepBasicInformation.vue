{"explanation":"Replace basic information step with converted Vue component from provided HTML design"}
<script setup>
import { ref, watch, onUnmounted } from 'vue';

const props = defineProps({
    form: Object,
    profile: Object,
    storageUrl: String,
});

let objectUrl = null;
const getPreviewFromFile = (file) => {
    if (!file) return null;
    if (file instanceof File) {
        if (objectUrl) URL.revokeObjectURL(objectUrl);
        objectUrl = URL.createObjectURL(file);
        return objectUrl;
    }
    if (typeof file === 'string') {
        const str = file;
        if (str.startsWith('http') || str.startsWith('/')) return str;
        const baseUrl = props.storageUrl ? props.storageUrl.replace(/\/$/, '') : '';
        return baseUrl ? `${baseUrl}/${str}` : str;
    }
    return null;
};

const previewPhoto = ref(
    getPreviewFromFile(props.form.profile_photo) || (props.profile?.profile_photo_url ? props.profile.profile_photo_url : (props.profile?.profile_photo ? getPreviewFromFile(props.profile.profile_photo) : null))
);

watch(() => props.form.profile_photo, (file) => {
    previewPhoto.value = getPreviewFromFile(file) || (props.profile?.profile_photo_url ? props.profile.profile_photo_url : (props.profile?.profile_photo ? getPreviewFromFile(props.profile.profile_photo) : null));
});

watch(() => props.profile?.profile_photo, (val) => {
    if (!props.form.profile_photo) {
        previewPhoto.value = getPreviewFromFile(val) || null;
    }
});

const handlePhotoChange = (event) => {
    const file = event.target.files[0];
    props.form.profile_photo = file;

    if (file) {
        previewPhoto.value = getPreviewFromFile(file);
    }
};

onUnmounted(() => {
    if (objectUrl) URL.revokeObjectURL(objectUrl);
});
</script>

<template>
    <section class="rounded-[1.25rem] border border-slate-200 bg-white p-6 shadow-sm">
        <div class="mb-6 flex flex-col gap-3 text-center">
            <div class="mx-auto flex h-24 w-24 items-center justify-center rounded-full bg-slate-100 border-2" :style="{ borderColor: '#f5a623' }">
                <img v-if="previewPhoto" :src="previewPhoto" class="h-full w-full rounded-full object-cover" alt="Profile preview" />
                <span v-else class="text-3xl">👤</span>
            </div>
            <div>
                <label class="inline-flex cursor-pointer items-center gap-2 rounded-full border border-amber-200 bg-amber-50 px-4 py-2 text-sm font-semibold text-amber-700 transition hover:bg-amber-100">
                    Upload profile photo
                    <input type="file" @change="handlePhotoChange" accept=".jpg,.jpeg,.png,.webp" class="hidden" />
                </label>
            </div>
            <p class="text-sm text-slate-500">JPG, PNG or WEBP. Max 5MB.</p>
            <p v-if="props.form.errors.profile_photo" class="mt-1 text-sm text-red-600">{{ props.form.errors.profile_photo }}</p>
        </div>

        <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
            <div>
                <label class="block text-xs font-semibold uppercase tracking-[0.18em] text-slate-500">Gender</label>
                <select v-model="props.form.gender" class="mt-2 h-12 w-full rounded-2xl border border-slate-300 bg-slate-50 px-4 text-sm outline-none transition focus:border-indigo-500 focus:ring-2 focus:ring-indigo-100">
                    <option value="">Select gender</option>
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                    <option value="other">Other</option>
                    <option value="prefer_not">Prefer not to say</option>
                </select>
                <p v-if="props.form.errors.gender" class="mt-2 text-sm text-red-600">{{ props.form.errors.gender }}</p>
            </div>

            <div>
                <label class="block text-xs font-semibold uppercase tracking-[0.18em] text-slate-500">Date of birth</label>
                <input type="date" v-model="props.form.date_of_birth" class="mt-2 h-12 w-full rounded-2xl border border-slate-300 bg-slate-50 px-4 text-sm outline-none transition focus:border-indigo-500 focus:ring-2 focus:ring-indigo-100" />
                <p v-if="props.form.errors.date_of_birth" class="mt-2 text-sm text-red-600">{{ props.form.errors.date_of_birth }}</p>
            </div>

            <div>
                <label class="block text-xs font-semibold uppercase tracking-[0.18em] text-slate-500">Phone number</label>
                <input type="tel" v-model="props.form.phone" placeholder="+91 98765 43210" class="mt-2 h-12 w-full rounded-2xl border border-slate-300 bg-slate-50 px-4 text-sm outline-none transition focus:border-indigo-500 focus:ring-2 focus:ring-indigo-100" />
                <p v-if="props.form.errors.phone" class="mt-2 text-sm text-red-600">{{ props.form.errors.phone }}</p>
            </div>

            <div>
                <label class="block text-xs font-semibold uppercase tracking-[0.18em] text-slate-500">Timezone</label>
                <select v-model="props.form.timezone" class="mt-2 h-12 w-full rounded-2xl border border-slate-300 bg-slate-50 px-4 text-sm outline-none transition focus:border-indigo-500 focus:ring-2 focus:ring-indigo-100">
                    <option value="">Select timezone</option>
                    <option>Asia/Kolkata (IST)</option>
                    <option>America/New_York (EST)</option>
                    <option>Europe/London (GMT)</option>
                    <option>Asia/Dubai (GST)</option>
                    <option>Australia/Sydney (AEST)</option>
                </select>
                <p v-if="props.form.errors.timezone" class="mt-2 text-sm text-red-600">{{ props.form.errors.timezone }}</p>
            </div>

            <div>
                <label class="block text-xs font-semibold uppercase tracking-[0.18em] text-slate-500">Country</label>
                <input type="text" v-model="props.form.country" placeholder="India" class="mt-2 h-12 w-full rounded-2xl border border-slate-300 bg-slate-50 px-4 text-sm outline-none transition focus:border-indigo-500 focus:ring-2 focus:ring-indigo-100" />
                <p v-if="props.form.errors.country" class="mt-2 text-sm text-red-600">{{ props.form.errors.country }}</p>
            </div>

            <div>
                <label class="block text-xs font-semibold uppercase tracking-[0.18em] text-slate-500">State</label>
                <input type="text" v-model="props.form.state" placeholder="Rajasthan" class="mt-2 h-12 w-full rounded-2xl border border-slate-300 bg-slate-50 px-4 text-sm outline-none transition focus:border-indigo-500 focus:ring-2 focus:ring-indigo-100" />
                <p v-if="props.form.errors.state" class="mt-2 text-sm text-red-600">{{ props.form.errors.state }}</p>
            </div>

            <div>
                <label class="block text-xs font-semibold uppercase tracking-[0.18em] text-slate-500">City</label>
                <input type="text" v-model="props.form.city" placeholder="Jaipur" class="mt-2 h-12 w-full rounded-2xl border border-slate-300 bg-slate-50 px-4 text-sm outline-none transition focus:border-indigo-500 focus:ring-2 focus:ring-indigo-100" />
                <p v-if="props.form.errors.city" class="mt-2 text-sm text-red-600">{{ props.form.errors.city }}</p>
            </div>

            <div>
                <label class="block text-xs font-semibold uppercase tracking-[0.18em] text-slate-500">Preferred language</label>
                <input type="text" v-model="props.form.preferred_language" placeholder="English" class="mt-2 h-12 w-full rounded-2xl border border-slate-300 bg-slate-50 px-4 text-sm outline-none transition focus:border-indigo-500 focus:ring-2 focus:ring-indigo-100" />
                <p v-if="props.form.errors.preferred_language" class="mt-2 text-sm text-red-600">{{ props.form.errors.preferred_language }}</p>
            </div>
        </div>
    </section>
</template>
