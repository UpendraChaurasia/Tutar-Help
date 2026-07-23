<script setup>
const props = defineProps({
    form: Object,
});

const updateSubjects = (value) => {
    props.form.subjects = value.split(',').map((subject) => subject.trim()).filter(Boolean);
};

const updateLanguages = (value) => {
    props.form.languages = value.split(',').map((language) => language.trim()).filter(Boolean);
};
</script>

<template>
    <div class="rounded-3xl bg-white p-6 shadow-sm">
        <div class="grid gap-4 md:grid-cols-2">
            <div>
                <label class="block text-sm font-medium text-slate-700">Headline</label>
                <input type="text" v-model="props.form.headline" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                <p v-if="props.form.errors.headline" class="mt-2 text-sm text-red-600">{{ props.form.errors.headline }}</p>
            </div>

            <div>
                <label class="block text-sm font-medium text-slate-700">Years of Experience</label>
                <input type="number" min="0" v-model="props.form.experience_years" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                <p v-if="props.form.errors.experience_years" class="mt-2 text-sm text-red-600">{{ props.form.errors.experience_years }}</p>
            </div>

            <div>
                <label class="block text-sm font-medium text-slate-700">Current Occupation</label>
                <input type="text" v-model="props.form.current_occupation" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                <p v-if="props.form.errors.current_occupation" class="mt-2 text-sm text-red-600">{{ props.form.errors.current_occupation }}</p>
            </div>

            <div>
                <label class="block text-sm font-medium text-slate-700">Current Organization</label>
                <input type="text" v-model="props.form.current_organization" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                <p v-if="props.form.errors.current_organization" class="mt-2 text-sm text-red-600">{{ props.form.errors.current_organization }}</p>
            </div>

            <div>
                <label class="block text-sm font-medium text-slate-700">Teaching Level</label>
                <input type="text" v-model="props.form.teaching_level" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                <p v-if="props.form.errors.teaching_level" class="mt-2 text-sm text-red-600">{{ props.form.errors.teaching_level }}</p>
            </div>

            <div>
                <label class="block text-sm font-medium text-slate-700">Hourly Rate</label>
                <input type="number" min="0" step="0.01" v-model="props.form.hourly_rate" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                <p v-if="props.form.errors.hourly_rate" class="mt-2 text-sm text-red-600">{{ props.form.errors.hourly_rate }}</p>
            </div>
        </div>

        <div class="grid gap-4 md:grid-cols-2 mt-6">
            <div>
                <label class="block text-sm font-medium text-slate-700">Subjects</label>
                <input
                    type="text"
                    :value="props.form.subjects?.join(', ')"
                    @input="updateSubjects($event.target.value)"
                    class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
                    placeholder="Comma-separated subjects"
                />
                <p v-if="props.form.errors.subjects" class="mt-2 text-sm text-red-600">{{ props.form.errors.subjects }}</p>
            </div>

            <div>
                <label class="block text-sm font-medium text-slate-700">Languages</label>
                <input
                    type="text"
                    :value="props.form.languages?.join(', ')"
                    @input="updateLanguages($event.target.value)"
                    class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
                    placeholder="Comma-separated languages"
                />
                <p v-if="props.form.errors.languages" class="mt-2 text-sm text-red-600">{{ props.form.errors.languages }}</p>
            </div>
        </div>

        <div class="mt-6">
            <label class="block text-sm font-medium text-slate-700">Introduction Video URL</label>
            <input type="text" v-model="props.form.introduction_video" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
            <p v-if="props.form.errors.introduction_video" class="mt-2 text-sm text-red-600">{{ props.form.errors.introduction_video }}</p>
        </div>
    </div>
</template>
