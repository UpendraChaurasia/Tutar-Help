<script setup>
const props = defineProps({
    form: Object,
});

const addExperience = () => {
    props.form.experiences.push({
        company: '',
        designation: '',
        industry: '',
        start_date: '',
        end_date: '',
        currently_working: false,
        description: '',
    });
};

const removeExperience = (index) => {
    props.form.experiences.splice(index, 1);
};
</script>

<template>
    <div class="rounded-3xl bg-white p-6 shadow-sm">
        <div class="flex items-center justify-between">
            <div>
                <h3 class="text-lg font-semibold text-slate-900">Experience</h3>
                <p class="text-sm text-slate-500">Add professional or teaching experience entries.</p>
            </div>
            <button type="button" @click="addExperience" class="rounded-md bg-emerald-600 px-4 py-2 text-sm font-semibold text-white hover:bg-emerald-700">
                Add Experience
            </button>
        </div>

        <div class="mt-6 space-y-6">
            <template v-for="(experience, index) in props.form.experiences" :key="index">
                <div class="rounded-3xl border border-slate-200 p-4">
                    <div class="flex items-center justify-between gap-4">
                        <p class="font-semibold text-slate-900">Entry {{ index + 1 }}</p>
                        <button type="button" @click="removeExperience(index)" class="text-sm font-semibold text-red-600 hover:text-red-800">Remove</button>
                    </div>

                    <div class="grid gap-4 md:grid-cols-2 mt-4">
                        <div>
                            <label class="block text-sm font-medium text-slate-700">Company</label>
                            <input type="text" v-model="experience.company" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700">Designation</label>
                            <input type="text" v-model="experience.designation" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700">Industry</label>
                            <input type="text" v-model="experience.industry" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700">Start Date</label>
                            <input type="date" v-model="experience.start_date" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700">End Date</label>
                            <input type="date" v-model="experience.end_date" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                        </div>
                        <div class="flex items-center gap-3 mt-5 md:mt-0">
                            <input type="checkbox" v-model="experience.currently_working" :id="`current-${index}`" class="h-4 w-4 rounded border-gray-300 text-indigo-600 focus:ring-indigo-500" />
                            <label :for="`current-${index}`" class="text-sm font-medium text-slate-700">Currently Working</label>
                        </div>
                    </div>

                    <div class="mt-4">
                        <label class="block text-sm font-medium text-slate-700">Description</label>
                        <textarea v-model="experience.description" rows="4" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"></textarea>
                    </div>
                </div>
            </template>

            <p v-if="props.form.errors.experiences" class="text-sm text-red-600">{{ props.form.errors.experiences }}</p>
        </div>
    </div>
</template>
