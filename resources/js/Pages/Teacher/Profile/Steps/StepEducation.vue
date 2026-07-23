<script setup>
import { computed } from 'vue';

const props = defineProps({
    form: Object,
});

const educationErrors = computed(() => {
    if (!props.form.errors) return {};
    return Object.fromEntries(Object.entries(props.form.errors).filter(([key]) => key.startsWith('educations.')));
});

const addEducation = () => {
    props.form.educations.push({
        degree: '',
        college: '',
        university: '',
        country: '',
        start_year: '',
        end_year: '',
        description: '',
    });
};

const removeEducation = (index) => {
    props.form.educations.splice(index, 1);
};
</script>

<template>
    <div class="rounded-3xl bg-white p-6 shadow-sm">
        <div class="flex items-center justify-between">
            <div>
                <h3 class="text-lg font-semibold text-slate-900">Education</h3>
                <p class="text-sm text-slate-500">Add your education history.</p>
            </div>
            <button type="button" @click="addEducation" class="rounded-md bg-emerald-600 px-4 py-2 text-sm font-semibold text-white hover:bg-emerald-700">
                Add Education
            </button>
        </div>

        <div class="mt-6 space-y-6">
            <template v-for="(education, index) in props.form.educations" :key="index">
                <div class="rounded-3xl border border-slate-200 p-4">
                    <div class="flex items-center justify-between gap-4">
                        <p class="font-semibold text-slate-900">Entry {{ index + 1 }}</p>
                        <button type="button" @click="removeEducation(index)" class="text-sm font-semibold text-red-600 hover:text-red-800">Remove</button>
                    </div>

                    <div class="grid gap-4 md:grid-cols-2 mt-4">
                        <div>
                            <label class="block text-sm font-medium text-slate-700">Degree</label>
                            <input type="text" v-model="education.degree" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700">College</label>
                            <input type="text" v-model="education.college" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700">University</label>
                            <input type="text" v-model="education.university" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700">Country</label>
                            <input type="text" v-model="education.country" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700">Start Year</label>
                            <input type="text" v-model="education.start_year" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700">End Year</label>
                            <input type="text" v-model="education.end_year" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                        </div>
                    </div>

                    <div class="mt-4">
                        <label class="block text-sm font-medium text-slate-700">Description</label>
                        <textarea v-model="education.description" rows="4" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"></textarea>
                    </div>
                </div>
            </template>

            <div class="space-y-2">
                <p v-if="props.form.errors.educations" class="text-sm text-red-600">{{ props.form.errors.educations }}</p>
                <template v-for="(message, key) in educationErrors" :key="key">
                    <p class="text-sm text-red-600">{{ message }}</p>
                </template>
            </div>
        </div>
    </div>
</template>