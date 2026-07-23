<script setup>
import { ref, onMounted } from 'vue';
import { Link } from '@inertiajs/vue3';

const isDark = ref(false);

onMounted(() => {
    isDark.value = localStorage.theme === 'dark'
        || (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches);
    document.documentElement.classList.toggle('dark', isDark.value);
});

const toggleDark = () => {
    isDark.value = !isDark.value;
    document.documentElement.classList.toggle('dark', isDark.value);
    localStorage.theme = isDark.value ? 'dark' : 'light';
};
</script>

<template>
    <div class="relative flex min-h-screen items-center justify-center bg-slate-100 px-4 py-10 dark:bg-slate-950">
        <button
            @click="toggleDark"
            class="absolute right-5 top-5 rounded-full border border-slate-300 bg-white p-2 text-slate-600 shadow-sm dark:border-slate-700 dark:bg-slate-800 dark:text-slate-300"
            aria-label="Toggle dark mode"
        >
            <svg v-if="isDark" xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 24 24" fill="currentColor"><path d="M12 4a1 1 0 011 1v1a1 1 0 11-2 0V5a1 1 0 011-1zm0 14a4 4 0 100-8 4 4 0 000 8zm8-6a1 1 0 110 2h-1a1 1 0 110-2h1zM5 12a1 1 0 01-1 1H3a1 1 0 110-2h1a1 1 0 011 1zm12.657-6.657a1 1 0 010 1.414l-.707.707a1 1 0 11-1.414-1.414l.707-.707a1 1 0 011.414 0zM7.464 16.95a1 1 0 010 1.414l-.707.707A1 1 0 015.343 17.66l.707-.707a1 1 0 011.414 0zm11.193 1.414a1 1 0 01-1.414 0l-.707-.707a1 1 0 111.414-1.414l.707.707a1 1 0 010 1.414zM6.757 6.757a1 1 0 01-1.414 0l-.707-.707A1 1 0 016.05 4.636l.707.707a1 1 0 010 1.414zM12 20a1 1 0 011 1v-1a1 1 0 10-2 0v1a1 1 0 011-1z"/></svg>
            <svg v-else xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 24 24" fill="currentColor"><path d="M21 12.79A9 9 0 1111.21 3a7 7 0 009.79 9.79z"/></svg>
        </button>

        <div class="grid w-full max-w-4xl overflow-hidden rounded-2xl bg-white shadow-2xl dark:bg-slate-900 dark:ring-1 dark:ring-slate-800 md:grid-cols-2">
            <!-- Brand panel -->
            <div class="hidden flex-col justify-between bg-slate-900 p-10 text-white md:flex">
                <Link href="/" class="text-lg font-bold tracking-tight">
                    <span class="text-amber-400">Tuition</span><span class="text-white">Hub</span>
                </Link>
                <div>
                    <p class="text-2xl font-semibold leading-snug">Learn smarter,<br />teach better.</p>
                    <p class="mt-3 text-sm text-slate-400">One platform for classes, schedules and progress.</p>
                </div>
                <p class="text-xs text-slate-500">&copy; {{ new Date().getFullYear() }} TuitionHub</p>
            </div>

            <!-- Form panel -->
            <div class="p-8 sm:p-10">
                <Link href="/" class="mb-6 flex text-lg font-bold tracking-tight md:hidden">
                    <span class="text-amber-500">Tuition</span><span class="text-slate-900 dark:text-white">Hub</span>
                </Link>
                <slot />
            </div>
        </div>
    </div>
</template>
