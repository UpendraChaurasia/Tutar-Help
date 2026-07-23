<script setup>
import { computed } from 'vue';

const props = defineProps({
    form: Object,
});

const availabilityErrors = computed(() => {
    if (!props.form.errors) return [];
    return props.form.availabilities.map((availability, index) => ({
        day: props.form.errors[`availabilities.${index}.day`] || null,
        start_time: props.form.errors[`availabilities.${index}.start_time`] || null,
        end_time: props.form.errors[`availabilities.${index}.end_time`] || null,
    }));
});

const addAvailability = () => {
    props.form.availabilities.push({
        day: '',
        start_time: '',
        end_time: '',
    });
};

const removeAvailability = (index) => {
    props.form.availabilities.splice(index, 1);
};
</script>

<template>
    <div class="rounded-3xl bg-white p-6 shadow-sm">
        <div class="flex items-center justify-between">
            <div>
                <h3 class="text-lg font-semibold text-slate-900">Availability</h3>
                <p class="text-sm text-slate-500">Set your weekly availability for students.</p>
            </div>
            <button type="button" @click="addAvailability" class="rounded-md bg-emerald-600 px-4 py-2 text-sm font-semibold text-white hover:bg-emerald-700">
                Add Availability
            </button>
        </div>

        <div class="mt-6 space-y-6">
            <template v-for="(availability, index) in props.form.availabilities" :key="index">
                <div class="rounded-3xl border border-slate-200 p-4">
                    <div class="flex items-center justify-between gap-4">
                        <p class="font-semibold text-slate-900">Time slot {{ index + 1 }}</p>
                        <button type="button" @click="removeAvailability(index)" class="text-sm font-semibold text-red-600 hover:text-red-800">Remove</button>
                    </div>

                    <div class="grid gap-4 md:grid-cols-3 mt-4">
                        <div>
                            <label class="block text-sm font-medium text-slate-700">Day</label>
                            <select v-model="availability.day" class="mt-2 block w-full rounded-md border-gray-300 bg-white shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
                                <option value="">Select day</option>
                                <option value="monday">Monday</option>
                                <option value="tuesday">Tuesday</option>
                                <option value="wednesday">Wednesday</option>
                                <option value="thursday">Thursday</option>
                                <option value="friday">Friday</option>
                                <option value="saturday">Saturday</option>
                                <option value="sunday">Sunday</option>
                            </select>
                            <p v-if="availabilityErrors[index]?.day" class="mt-2 text-sm text-red-600">{{ availabilityErrors[index].day }}</p>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700">Start Time</label>
                            <input type="time" v-model="availability.start_time" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                            <p v-if="availabilityErrors[index]?.start_time" class="mt-2 text-sm text-red-600">{{ availabilityErrors[index].start_time }}</p>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700">End Time</label>
                            <input type="time" v-model="availability.end_time" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                            <p v-if="availabilityErrors[index]?.end_time" class="mt-2 text-sm text-red-600">{{ availabilityErrors[index].end_time }}</p>
                        </div>
                    </div>
                </div>
            </template>

            <p v-if="props.form.errors.availabilities" class="text-sm text-red-600">{{ props.form.errors.availabilities }}</p>
        </div>
    </div>
</template>
