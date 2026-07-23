<script setup>
const props = defineProps({
    form: Object,
    profile: Object,
    storageUrl: String,
});

const existingDocument = props.profile.documents?.[0] || {};

const previewUrl = (path) => {
    if (!path) return null;
    if (path.startsWith('http://') || path.startsWith('https://')) {
        return path;
    }
    const baseUrl = props.storageUrl ? props.storageUrl.replace(/\/$/, '') : '';
    return baseUrl ? `${baseUrl}/${path}` : path;
};

const handleFileUpload = (field, event) => {
    const file = event.target.files[0];
    if (file) {
        props.form[field] = file;
        props.form[`delete_${field}`] = false;
    }
};

const removeExistingFile = (field) => {
    props.form[`delete_${field}`] = true;
    props.form[field] = null;
};
</script>

<template>
    <div class="rounded-3xl bg-white p-6 shadow-sm">
        <div class="grid gap-4 md:grid-cols-2">
            <div>
                <label class="block text-sm font-medium text-slate-700">Document Type</label>
                <input type="text" v-model="props.form.document_type" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                <p v-if="props.form.errors.document_type" class="mt-2 text-sm text-red-600">{{ props.form.errors.document_type }}</p>
            </div>

            <div>
                <label class="block text-sm font-medium text-slate-700">Document Number</label>
                <input type="text" v-model="props.form.document_number" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                <p v-if="props.form.errors.document_number" class="mt-2 text-sm text-red-600">{{ props.form.errors.document_number }}</p>
            </div>
        </div>

        <div class="grid gap-4 md:grid-cols-2 mt-6">
            <div>
                <label class="block text-sm font-medium text-slate-700">Front Image</label>
                <input type="file" @change="(event) => handleFileUpload('front_image', event)" accept="image/*" class="mt-2 block w-full text-sm text-slate-500" />
                <p v-if="props.form.errors.front_image" class="mt-2 text-sm text-red-600">{{ props.form.errors.front_image }}</p>
                <div v-if="existingDocument.front_image && !props.form.delete_front_image" class="mt-3 rounded-lg border border-slate-200 bg-slate-50 p-3">
                    <p class="text-sm font-medium text-slate-700">Existing Front Image</p>
                    <a :href="previewUrl(existingDocument.front_image)" target="_blank" rel="noreferrer" class="text-sm text-indigo-600 hover:text-indigo-800">View uploaded file</a>
                    <button type="button" @click="removeExistingFile('front_image')" class="mt-2 inline-flex items-center rounded-md bg-red-50 px-3 py-1 text-xs font-semibold text-red-700 hover:bg-red-100">Delete uploaded file</button>
                </div>
                <div v-if="existingDocument.front_image && props.form.delete_front_image" class="mt-3 rounded-lg border border-slate-200 bg-slate-50 p-3">
                    <p class="text-sm text-red-600">Existing front image will be removed when you save.</p>
                </div>
            </div>
            <div>
                <label class="block text-sm font-medium text-slate-700">Back Image</label>
                <input type="file" @change="(event) => handleFileUpload('back_image', event)" accept="image/*" class="mt-2 block w-full text-sm text-slate-500" />
                <p v-if="props.form.errors.back_image" class="mt-2 text-sm text-red-600">{{ props.form.errors.back_image }}</p>
                <div v-if="existingDocument.back_image && !props.form.delete_back_image" class="mt-3 rounded-lg border border-slate-200 bg-slate-50 p-3">
                    <p class="text-sm font-medium text-slate-700">Existing Back Image</p>
                    <a :href="previewUrl(existingDocument.back_image)" target="_blank" rel="noreferrer" class="text-sm text-indigo-600 hover:text-indigo-800">View uploaded file</a>
                    <button type="button" @click="removeExistingFile('back_image')" class="mt-2 inline-flex items-center rounded-md bg-red-50 px-3 py-1 text-xs font-semibold text-red-700 hover:bg-red-100">Delete uploaded file</button>
                </div>
                <div v-if="existingDocument.back_image && props.form.delete_back_image" class="mt-3 rounded-lg border border-slate-200 bg-slate-50 p-3">
                    <p class="text-sm text-red-600">Existing back image will be removed when you save.</p>
                </div>
            </div>
            <div>
                <label class="block text-sm font-medium text-slate-700">Selfie Image</label>
                <input type="file" @change="(event) => handleFileUpload('selfie_image', event)" accept="image/*" class="mt-2 block w-full text-sm text-slate-500" />
                <p v-if="props.form.errors.selfie_image" class="mt-2 text-sm text-red-600">{{ props.form.errors.selfie_image }}</p>
                <div v-if="existingDocument.selfie_image && !props.form.delete_selfie_image" class="mt-3 rounded-lg border border-slate-200 bg-slate-50 p-3">
                    <p class="text-sm font-medium text-slate-700">Existing Selfie Image</p>
                    <a :href="previewUrl(existingDocument.selfie_image)" target="_blank" rel="noreferrer" class="text-sm text-indigo-600 hover:text-indigo-800">View uploaded file</a>
                    <button type="button" @click="removeExistingFile('selfie_image')" class="mt-2 inline-flex items-center rounded-md bg-red-50 px-3 py-1 text-xs font-semibold text-red-700 hover:bg-red-100">Delete uploaded file</button>
                </div>
                <div v-if="existingDocument.selfie_image && props.form.delete_selfie_image" class="mt-3 rounded-lg border border-slate-200 bg-slate-50 p-3">
                    <p class="text-sm text-red-600">Existing selfie image will be removed when you save.</p>
                </div>
            </div>
            <div>
                <label class="block text-sm font-medium text-slate-700">Address Proof</label>
                <input type="file" @change="(event) => handleFileUpload('address_proof', event)" accept="application/pdf,image/*" class="mt-2 block w-full text-sm text-slate-500" />
                <p v-if="props.form.errors.address_proof" class="mt-2 text-sm text-red-600">{{ props.form.errors.address_proof }}</p>
                <div v-if="existingDocument.address_proof && !props.form.delete_address_proof" class="mt-3 rounded-lg border border-slate-200 bg-slate-50 p-3">
                    <p class="text-sm font-medium text-slate-700">Existing Address Proof</p>
                    <a :href="previewUrl(existingDocument.address_proof)" target="_blank" rel="noreferrer" class="text-sm text-indigo-600 hover:text-indigo-800">View uploaded file</a>
                    <button type="button" @click="removeExistingFile('address_proof')" class="mt-2 inline-flex items-center rounded-md bg-red-50 px-3 py-1 text-xs font-semibold text-red-700 hover:bg-red-100">Delete uploaded file</button>
                </div>
                <div v-if="existingDocument.address_proof && props.form.delete_address_proof" class="mt-3 rounded-lg border border-slate-200 bg-slate-50 p-3">
                    <p class="text-sm text-red-600">Existing address proof will be removed when you save.</p>
                </div>
            </div>
        </div>
    </div>
</template>
