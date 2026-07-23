<script setup>
import { computed } from 'vue';

const props = defineProps({
    form: Object,
    storageUrl: String,
});

const previewUrl = (path) => {
    if (!path) return null;
    if (path.startsWith('http://') || path.startsWith('https://')) {
        return path;
    }
    const baseUrl = props.storageUrl ? props.storageUrl.replace(/\/$/, '') : '';
    return baseUrl ? `${baseUrl}/${path}` : path;
};

const certificatesErrors = computed(() => {
    if (!props.form.errors) return [];
    return props.form.certificates.map((certificate, index) => ({
        certificate_name: props.form.errors[`certificates.${index}.certificate_name`] || null,
        issued_by: props.form.errors[`certificates.${index}.issued_by`] || null,
        issue_date: props.form.errors[`certificates.${index}.issue_date`] || null,
        expiry_date: props.form.errors[`certificates.${index}.expiry_date`] || null,
        credential_id: props.form.errors[`certificates.${index}.credential_id`] || null,
        credential_url: props.form.errors[`certificates.${index}.credential_url`] || null,
        certificate_file: props.form.errors[`certificates.${index}.certificate_file`] || null,
    }));
});

const addCertificate = () => {
    props.form.certificates.push({
        certificate_name: '',
        issued_by: '',
        issue_date: '',
        expiry_date: '',
        credential_id: '',
        credential_url: '',
        certificate_file: null,
        existing_file: null,
        delete_certificate_file: false,
    });
};

const removeCertificate = (index) => {
    props.form.certificates.splice(index, 1);
};

const handleCertificateFile = (index, event) => {
    const file = event.target.files[0];
    if (file) {
        props.form.certificates[index].certificate_file = file;
        props.form.certificates[index].delete_certificate_file = false;
    }
};

const removeCertificateFile = (index) => {
    props.form.certificates[index].delete_certificate_file = true;
    props.form.certificates[index].certificate_file = null;
};
</script>

<template>
    <div class="rounded-3xl bg-white p-6 shadow-sm">
        <div class="flex items-center justify-between">
            <div>
                <h3 class="text-lg font-semibold text-slate-900">Certificates</h3>
                <p class="text-sm text-slate-500">Upload your certificates and training documents.</p>
            </div>
            <button type="button" @click="addCertificate" class="rounded-md bg-emerald-600 px-4 py-2 text-sm font-semibold text-white hover:bg-emerald-700">
                Add Certificate
            </button>
        </div>

        <div class="mt-6 space-y-6">
            <template v-for="(certificate, index) in props.form.certificates" :key="index">
                <div class="rounded-3xl border border-slate-200 p-4">
                    <div class="flex items-center justify-between gap-4">
                        <p class="font-semibold text-slate-900">Certificate {{ index + 1 }}</p>
                        <button type="button" @click="removeCertificate(index)" class="text-sm font-semibold text-red-600 hover:text-red-800">Remove</button>
                    </div>

                    <div class="grid gap-4 md:grid-cols-2 mt-4">
                        <div>
                            <label class="block text-sm font-medium text-slate-700">Certificate Name</label>
                            <input type="text" v-model="certificate.certificate_name" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700">Issued By</label>
                            <input type="text" v-model="certificate.issued_by" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700">Issue Date</label>
                            <input type="date" v-model="certificate.issue_date" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700">Expiry Date</label>
                            <input type="date" v-model="certificate.expiry_date" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700">Credential ID</label>
                            <input type="text" v-model="certificate.credential_id" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700">Credential URL</label>
                            <input type="text" v-model="certificate.credential_url" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                            <p v-if="certificatesErrors[index]?.credential_url" class="mt-2 text-sm text-red-600">{{ certificatesErrors[index].credential_url }}</p>
                        </div>
                    </div>

                    <div class="mt-4">
                        <label class="block text-sm font-medium text-slate-700">Certificate File</label>
                        <input type="file" @change="(event) => handleCertificateFile(index, event)" accept="application/pdf,image/*" class="mt-2 block w-full text-sm text-slate-500" />
                        <p v-if="certificate.existing_file && !certificate.delete_certificate_file" class="mt-2 text-xs text-slate-500">
                            Existing file: <a :href="previewUrl(certificate.existing_file)" target="_blank" rel="noreferrer" class="text-indigo-600 hover:text-indigo-800">View uploaded file</a>
                        </p>
                        <button
                            v-if="certificate.existing_file && !certificate.delete_certificate_file"
                            type="button"
                            @click="removeCertificateFile(index)"
                            class="mt-2 inline-flex items-center rounded-md bg-red-50 px-3 py-1 text-xs font-semibold text-red-700 hover:bg-red-100"
                        >
                            Delete uploaded file
                        </button>
                        <p v-if="certificate.delete_certificate_file" class="mt-2 text-sm text-red-600">Existing certificate file will be removed when you save.</p>
                        <p v-if="certificatesErrors[index]?.certificate_file" class="mt-2 text-sm text-red-600">{{ certificatesErrors[index].certificate_file }}</p>
                    </div>
                </div>
            </template>

            <p v-if="props.form.errors.certificates" class="text-sm text-red-600">{{ props.form.errors.certificates }}</p>
        </div>
    </div>
</template>
