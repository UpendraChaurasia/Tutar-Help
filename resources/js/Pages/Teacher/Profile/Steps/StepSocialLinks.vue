<script setup>
const props = defineProps({
    form: Object,
});
</script>

<template>
    <div class="rounded-3xl bg-white p-6 shadow-sm">
        <div class="grid gap-4 md:grid-cols-2">
            <div>
                <label class="block text-sm font-medium text-slate-700">Website</label>
                <input type="text" v-model="props.form.social.website" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                <p v-if="props.form.errors['social.website']" class="mt-2 text-sm text-red-600">{{ props.form.errors['social.website'] }}</p>
            </div>
            <div>
                <label class="block text-sm font-medium text-slate-700">LinkedIn</label>
                <input type="text" v-model="props.form.social.linkedin" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                <p v-if="props.form.errors['social.linkedin']" class="mt-2 text-sm text-red-600">{{ props.form.errors['social.linkedin'] }}</p>
            </div>
            <div>
                <label class="block text-sm font-medium text-slate-700">GitHub</label>
                <input type="text" v-model="props.form.social.github" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                <p v-if="props.form.errors['social.github']" class="mt-2 text-sm text-red-600">{{ props.form.errors['social.github'] }}</p>
            </div>
            <div>
                <label class="block text-sm font-medium text-slate-700">YouTube</label>
                <input type="text" v-model="props.form.social.youtube" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                <p v-if="props.form.errors['social.youtube']" class="mt-2 text-sm text-red-600">{{ props.form.errors['social.youtube'] }}</p>
            </div>
            <div>
                <label class="block text-sm font-medium text-slate-700">Facebook</label>
                <input type="text" v-model="props.form.social.facebook" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                <p v-if="props.form.errors['social.facebook']" class="mt-2 text-sm text-red-600">{{ props.form.errors['social.facebook'] }}</p>
            </div>
            <div>
                <label class="block text-sm font-medium text-slate-700">Instagram</label>
                <input type="text" v-model="props.form.social.instagram" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                <p v-if="props.form.errors['social.instagram']" class="mt-2 text-sm text-red-600">{{ props.form.errors['social.instagram'] }}</p>
            </div>
            <div>
                <label class="block text-sm font-medium text-slate-700">Twitter</label>
                <input type="text" v-model="props.form.social.twitter" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                <p v-if="props.form.errors['social.twitter']" class="mt-2 text-sm text-red-600">{{ props.form.errors['social.twitter'] }}</p>
            </div>
            <div class="md:col-span-2">
                <label class="block text-sm font-medium text-slate-700">Portfolio</label>
                <input type="text" v-model="props.form.social.portfolio" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                <p v-if="props.form.errors['social.portfolio']" class="mt-2 text-sm text-red-600">{{ props.form.errors['social.portfolio'] }}</p>
            </div>
        </div>
    </div>
</template>
