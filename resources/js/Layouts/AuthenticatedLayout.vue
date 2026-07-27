<script setup>
import { computed, ref, onMounted } from 'vue';
import { Link, usePage } from '@inertiajs/vue3';

const showingSidebar = ref(false);
const isDark = ref(false);
const page = usePage();

const user = computed(() => page.props.auth?.user || {});

const getRoleName = (roleItem) => {
    if (typeof roleItem === 'string') {
        return roleItem;
    }

    if (roleItem && typeof roleItem === 'object') {
        return roleItem.name || roleItem.title || roleItem.role || '';
    }

    return '';
};

const roleLabel = computed(() => {
    const roles = page.props.auth?.user?.roles || page.props.auth?.role_names || page.props.auth?.user?.role_names || [];
    const normalizedRoles = Array.isArray(roles) ? roles : [roles];
    const firstRole = normalizedRoles.map(getRoleName).find((roleName) => roleName);

    return firstRole || 'User';
});

const userRole = computed(() => {
    const roles = page.props.auth?.user?.roles || page.props.auth?.role_names || page.props.auth?.user?.role_names || [];
    const normalizedRoles = Array.isArray(roles) ? roles : [roles];
    const roleString = normalizedRoles.map(getRoleName).find((roleName) => roleName) || '';

    return roleString.toString().toLowerCase();
});

const adminMenuItems = [
    { key: 'dashboard', label: 'Dashboard', icon: 'home', route: 'dashboard' },
    {
        key: 'users',
        label: 'User Management',
        icon: 'people',
        hasSubmenu: true,
        items: [
            { key: 'admins', label: 'Admins', route: 'admins.index' },
            { key: 'teachers', label: 'Teachers', route: 'teachers.index' },
            { key: 'students', label: 'Students', route: 'students.index' },
            { key: 'roles', label: 'Roles & Permissions', route: 'roles.index' },
        ],
    },
    { key: 'teachers', label: 'Teacher Management', icon: 'chalkboard', hasSubmenu: true, items: [{ key: 'teacher-applications', label: 'Teacher Applications', route: 'teacher.applications.index' }, 'Approved Teachers', 'Rejected Teachers', 'Subjects / Categories'] },
    { key: 'courses', label: 'Course Management', icon: 'book', hasSubmenu: true, items: ['All Courses', 'Pending Approval', 'Published Courses', 'Draft Courses'] },
    { key: 'videos', label: 'Video Management', icon: 'film', hasSubmenu: true, items: ['Processing Queue', 'Video Library'] },
    { key: 'classes', label: 'Live Classes', icon: 'video', hasSubmenu: true, items: ['All Live Classes', 'Attendance'] },
    { key: 'payments', label: 'Payments', icon: 'creditCard', hasSubmenu: true, items: ['Transactions', 'Teacher Payout Requests', 'Completed Payouts', 'Refunds'] },
    { key: 'commission', label: 'Commission', icon: 'percent', hasSubmenu: true, items: ['Platform Fee', 'Pricing Rules'] },
    { key: 'orders', label: 'Orders', icon: 'shoppingCart', hasSubmenu: true, items: ['All Orders', 'Invoices'] },
    { key: 'reviews', label: 'Reviews', icon: 'star', hasSubmenu: true, items: ['Pending Reviews', 'Approved Reviews'] },
    { key: 'coupons', label: 'Coupons', icon: 'tag' },
    { key: 'reports', label: 'Reports', icon: 'chart', hasSubmenu: true, items: ['Revenue', 'Enrollments', 'Top Teachers', 'Top Courses'] },
    { key: 'notifications', label: 'Notifications', icon: 'bell' },
    { key: 'cms', label: 'CMS', icon: 'fileText', hasSubmenu: true, items: ['About', 'Privacy Policy', 'Terms', 'Cookie Policy'] },
    { key: 'settings', label: 'Settings', icon: 'gear', hasSubmenu: true, items: ['General', 'Email', 'Payment Gateway', 'Tax', 'Currency', 'Storage', 'Security'] },
];

const teacherMenuItems = [
    { key: 'dashboard', label: 'Dashboard', icon: 'home', route: 'dashboard' },
    {
        key: 'profile',
        label: 'My Profile',
        icon: 'user',
        hasSubmenu: true,
        items: [
            { key: 'update-profile', label: 'Update Profile', route: 'teacher.profile.edit' },
            { key: 'update-password', label: 'Update Password', route: 'profile.edit' },
        ],
    },
    { key: 'availability', label: 'Availability', icon: 'calendar' },
    { key: 'courses', label: 'My Courses', icon: 'book', hasSubmenu: true, items: [
        { key: 'teacher-all-courses', label: 'All Courses' },
        { key: 'teacher-create-course', label: 'Create Course' },
        { key: 'teacher-draft-courses', label: 'Draft Courses' },
    ] },
    { key: 'curriculum', label: 'Curriculum', icon: 'clipboard' },
    { key: 'videos', label: 'Videos', icon: 'film' },
    { key: 'liveClasses', label: 'Live Classes', icon: 'video' },
    { key: 'students', label: 'Students', icon: 'people' },
    { key: 'reviews', label: 'Reviews', icon: 'star' },
    { key: 'earnings', label: 'Earnings', icon: 'creditCard' },
    { key: 'payoutHistory', label: 'Payout History', icon: 'wallet' },
    { key: 'notifications', label: 'Notifications', icon: 'bell' },
    { key: 'settings', label: 'Settings', icon: 'gear' },
];

const studentMenuItems = [
    { key: 'dashboard', label: 'Dashboard', icon: 'home', route: 'dashboard' },
    { key: 'browseCourses', label: 'Browse Courses', icon: 'search' },
    { key: 'wishlist', label: 'Wishlist', icon: 'heart' },
    { key: 'cart', label: 'Cart', icon: 'shoppingCart' },
    { key: 'myCourses', label: 'My Courses', icon: 'book' },
    { key: 'certificates', label: 'Certificates', icon: 'award' },
    { key: 'transactions', label: 'Transactions', icon: 'creditCard' },
    { key: 'reviews', label: 'Reviews', icon: 'star' },
    { key: 'notifications', label: 'Notifications', icon: 'bell' },
    {
        key: 'profile',
        label: 'Profile',
        icon: 'user',
        hasSubmenu: true,
        items: [
            { key: 'update-profile', label: 'Update Profile' },
            { key: 'update-password', label: 'Update Password', route: 'profile.edit' },
        ],
    },
    { key: 'settings', label: 'Settings', icon: 'gear' },
];

const menuItems = computed(() => {
    if (userRole.value.includes('superadmin') || userRole.value.includes('admin')) {
        return adminMenuItems;
    }

    if (userRole.value.includes('teacher')) {
        return teacherMenuItems;
    }

    return studentMenuItems;
});

const getHref = (item) => item.route ? route(item.route) : item.href || '#';

const isItemActive = (item) => {
    if (item.route) {
        return route().current(item.route);
    }

    if (item.hasSubmenu && item.items) {
        return item.items.some((subitem) => subitem.route && route().current(subitem.route));
    }

    return false;
};

const activeParentKeys = computed(() =>
    menuItems.value
        .filter((item) => item.hasSubmenu && item.items?.some((subitem) => subitem.route && route().current(subitem.route)))
        .map((item) => item.key),
);

const isSubmenuOpen = (item) => expandedMenus.value.includes(item.key) || activeParentKeys.value.includes(item.key);

const getIcon = (iconName) => {
    const icons = {
        home: '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path stroke-linecap="round" stroke-linejoin="round" d="M3 10.5 12 3l9 7.5V21a1 1 0 0 1-1 1h-4v-6H8v6H4a1 1 0 0 1-1-1z" /></svg>',
        people: '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path stroke-linecap="round" stroke-linejoin="round" d="M12 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8Zm-7 8a7 7 0 1 1 14 0H5Z" /></svg>',
        chalkboard: '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path stroke-linecap="round" stroke-linejoin="round" d="M3 3h18a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2Z" /></svg>',
        book: '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path stroke-linecap="round" stroke-linejoin="round" d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20M4 4.5A2.5 2.5 0 0 1 6.5 7H20" /></svg>',
        film: '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path stroke-linecap="round" stroke-linejoin="round" d="M8 7H5a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2h-3M8 7V5a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2" /></svg>',
        video: '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path stroke-linecap="round" stroke-linejoin="round" d="m23 7-7 5 7 5V7Z" /><rect x="1" y="5" width="15" height="14" rx="2" ry="2" /></svg>',
        creditCard: '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="1" y="4" width="22" height="16" rx="2" ry="2" /><path stroke-linecap="round" stroke-linejoin="round" d="M1 10h22" /></svg>',
        percent: '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="8" cy="9" r="2" /><circle cx="16" cy="15" r="2" /><path stroke-linecap="round" stroke-linejoin="round" d="m6 17 12-12" /></svg>',
        shoppingCart: '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="9" cy="21" r="1" /><circle cx="20" cy="21" r="1" /><path stroke-linecap="round" stroke-linejoin="round" d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6" /></svg>',
        star: '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path stroke-linecap="round" stroke-linejoin="round" d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2Z" /></svg>',
        tag: '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path stroke-linecap="round" stroke-linejoin="round" d="M12 2H6a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V9" /><path stroke-linecap="round" stroke-linejoin="round" d="M9 9h.01M15 13h.01M9 15h.01M15 9h.01" /></svg>',
        chart: '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><polyline points="12 3 20 7.5 20 16.5 12 21 4 16.5 4 7.5 12 3" /><polyline points="12 12 20 7.5" /><polyline points="12 12 12 21" /><polyline points="12 12 4 7.5" /></svg>',
        bell: '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path stroke-linecap="round" stroke-linejoin="round" d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9Z" /><path stroke-linecap="round" stroke-linejoin="round" d="M13.73 21a2 2 0 0 1-3.46 0" /></svg>',
        fileText: '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path stroke-linecap="round" stroke-linejoin="round" d="M13 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V9Z" /><polyline points="13 2 13 9 20 9" /></svg>',
        gear: '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="3" /><path stroke-linecap="round" stroke-linejoin="round" d="M12 1v6m0 6v6M4.22 4.22l4.24 4.24m2.98 2.98l4.24 4.24M1 12h6m6 0h6M4.22 19.78l4.24-4.24m2.98-2.98l4.24-4.24M19.78 19.78l-4.24-4.24m-2.98-2.98l-4.24-4.24" /></svg>',
        logout: '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path stroke-linecap="round" stroke-linejoin="round" d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4" /><path stroke-linecap="round" stroke-linejoin="round" d="M10 17l5-5-5-5" /><path stroke-linecap="round" stroke-linejoin="round" d="M15 12H3" /></svg>',
        search: '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="11" cy="11" r="7" /><path d="M21 21l-4.35-4.35" /></svg>',
        heart: '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M20.8 4.6a5.5 5.5 0 0 0-7.78 0L12 5.6l-1.02-1A5.5 5.5 0 0 0 3.2 4.6 5.49 5.49 0 0 0 3.2 13.4L12 21l8.8-7.6a5.49 5.49 0 0 0 0-8.8Z" /></svg>',
        award: '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="8" r="3" /><path d="M5 8a7 7 0 0 1 14 0v7a4 4 0 0 1-4 4H9a4 4 0 0 1-4-4V8Z" /><path d="M12 11v7" /><path d="M8 19 12 16 16 19" /></svg>',
        calendar: '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="3" y="4" width="18" height="18" rx="2" ry="2" /><path d="M16 2v4M8 2v4M3 10h18" /></svg>',
        clipboard: '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2" /><rect x="8" y="2" width="8" height="4" rx="1" ry="1" /></svg>',
        wallet: '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M2 7h18a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2V7Z" /><path d="M16 11h2" /></svg>',
        user: '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" /><circle cx="12" cy="7" r="4" /></svg>',
    };
    return icons[iconName] || icons.home;
};

const expandedMenus = ref([]);

const toggleMenu = (key) => {
    expandedMenus.value = expandedMenus.value.includes(key)
        ? expandedMenus.value.filter((item) => item !== key)
        : [...expandedMenus.value, key];
};

onMounted(() => {
    expandedMenus.value = activeParentKeys.value;
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
    <div class="min-h-screen bg-slate-50 text-slate-900 dark:bg-slate-950 dark:text-slate-100">
        <div class="flex min-h-screen">
            <aside class="hidden w-80 shrink-0 flex-col border-r border-slate-200 bg-white/95 backdrop-blur dark:border-slate-800 dark:bg-slate-900/95 lg:flex">
                <div class="border-b border-slate-200 px-6 py-6 dark:border-slate-800">
                    <Link :href="route('dashboard')" class="flex items-center gap-3">
                        <div class="flex h-10 w-10 items-center justify-center rounded-full bg-gradient-to-br from-amber-400 to-amber-600 font-bold text-white shadow-lg">
                            TH
                        </div>
                        <div>
                            <p class="text-base font-bold text-slate-900 dark:text-white">TutarHelp</p>
                        </div>
                    </Link>
                </div>

                <nav class="flex-1 space-y-1 overflow-y-auto px-4 py-6">
                    <p class="px-3 text-xs font-bold uppercase tracking-widest text-slate-500 dark:text-slate-400">MAIN</p>

                    <template v-for="item in menuItems" :key="item.key">
                        <Link
                            v-if="item.action === 'logout'"
                            :href="route('logout')"
                            method="post"
                            as="button"
                            class="flex w-full items-center gap-3 rounded-lg px-4 py-3 text-sm font-medium text-slate-700 transition-all duration-200 hover:bg-rose-50 hover:text-rose-600 dark:text-slate-300 dark:hover:bg-rose-500/10 dark:hover:text-rose-400"
                        >
                            <div v-html="getIcon(item.icon)" class="flex-shrink-0"></div>
                            <span>{{ item.label }}</span>
                        </Link>

                        <Link
                            v-else-if="item.route && !item.hasSubmenu"
                            :href="getHref(item)"
                            class="flex items-center gap-3 rounded-lg px-4 py-3 text-sm font-medium transition-all duration-200"
                            :class="isItemActive(item)
                                ? 'bg-amber-50 text-amber-600 dark:bg-amber-500/20 dark:text-amber-400'
                                : 'text-slate-700 hover:bg-slate-100 hover:text-slate-900 dark:text-slate-300 dark:hover:bg-slate-800 dark:hover:text-slate-50'"
                        >
                            <div v-html="getIcon(item.icon)" class="flex-shrink-0"></div>
                            <span>{{ item.label }}</span>
                        </Link>

                        <button
                            v-else-if="item.hasSubmenu"
                            type="button"
                            class="flex w-full items-center justify-between rounded-lg px-4 py-3 text-sm font-medium transition-all duration-200"
                            :class="isItemActive(item)
                                ? 'bg-amber-50 text-amber-600 dark:bg-amber-500/20 dark:text-amber-400'
                                : isSubmenuOpen(item)
                                    ? 'bg-slate-100 text-slate-900 dark:bg-slate-800 dark:text-slate-50'
                                    : 'text-slate-700 hover:bg-slate-100 hover:text-slate-900 dark:text-slate-300 dark:hover:bg-slate-800 dark:hover:text-slate-50'"
                            @click="toggleMenu(item.key)"
                        >
                            <div class="flex items-center gap-3">
                                <div v-html="getIcon(item.icon)" class="flex-shrink-0"></div>
                                <span>{{ item.label }}</span>
                            </div>
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 transition-transform duration-200" :class="isSubmenuOpen(item) ? 'rotate-180' : ''" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="6 9 12 15 18 9"></polyline></svg>
                        </button>

                        <div v-if="item.hasSubmenu && isSubmenuOpen(item)" class="ml-6 space-y-1 border-l border-slate-200 dark:border-slate-700">
                            <template v-for="subitem in item.items" :key="typeof subitem === 'string' ? subitem : subitem.key">
                                <Link
                                    v-if="subitem.route"
                                    :href="getHref(subitem)"
                                    class="block rounded-lg px-3 py-2 text-sm transition-colors"
                                    :class="route().current(subitem.route)
                                        ? 'bg-amber-50 text-amber-600 dark:bg-amber-500/20 dark:text-amber-400'
                                        : 'text-slate-600 hover:bg-slate-100 hover:text-slate-900 dark:text-slate-400 dark:hover:bg-slate-800 dark:hover:text-slate-200'"
                                >
                                    {{ subitem.label || subitem }}
                                </Link>
                                <div
                                    v-else
                                    class="rounded-lg px-3 py-2 text-sm text-slate-600 hover:bg-slate-100 hover:text-slate-900 dark:text-slate-400 dark:hover:bg-slate-800 dark:hover:text-slate-200 transition-colors"
                                >
                                    {{ subitem.label || subitem }}
                                </div>
                            </template>
                        </div>

                        <Link
                            v-else-if="!item.hasSubmenu && !item.route"
                            href="#"
                            class="flex items-center gap-3 rounded-lg px-4 py-3 text-sm font-medium text-slate-700 hover:bg-slate-100 hover:text-slate-900 dark:text-slate-300 dark:hover:bg-slate-800 dark:hover:text-slate-50 transition-all duration-200"
                        >
                            <div v-html="getIcon(item.icon)" class="flex-shrink-0"></div>
                            <span>{{ item.label }}</span>
                        </Link>
                    </template>
                </nav>

                <div class="border-t border-slate-200 px-4 py-6 dark:border-slate-800">
                    <div class="mb-4 flex items-center gap-3 rounded-lg bg-slate-50 p-3 dark:bg-slate-800">
                        <div class="flex h-10 w-10 items-center justify-center rounded-full bg-gradient-to-br from-blue-400 to-blue-600 font-bold text-white">
                            {{ user.name?.charAt(0) || 'U' }}
                        </div>
                        <div class="flex-1">
                            <p class="text-sm font-semibold text-slate-900 dark:text-white">{{ user.name }}</p>
                            <!-- <p class="text-xs text-slate-600 dark:text-slate-400">{{ roleLabel }}</p> -->
                        </div>
                    </div>

                    <Link
                        :href="route('logout')"
                        method="post"
                        as="button"
                        class="flex w-full items-center gap-3 rounded-lg px-4 py-3 text-sm font-medium text-slate-700 transition hover:bg-rose-50 hover:text-rose-600 dark:text-slate-300 dark:hover:bg-rose-500/10 dark:hover:text-rose-400"
                    >
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path stroke-linecap="round" stroke-linejoin="round" d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4M10 17l5-5-5-5M15 12H3" /></svg>
                        Sign out
                    </Link>
                </div>
            </aside>

            <div class="flex min-h-screen flex-1 flex-col">
                <header class="border-b border-slate-200 bg-white/90 px-4 py-3 backdrop-blur dark:border-slate-800 dark:bg-slate-900/90 lg:px-6">
                    <div class="flex items-center justify-between gap-3">
                        <div class="flex items-center gap-3">
                            <button
                                @click="showingSidebar = true"
                                class="inline-flex items-center justify-center rounded-xl border border-slate-200 p-2 text-slate-600 transition hover:bg-slate-100 dark:border-slate-700 dark:text-slate-300 dark:hover:bg-slate-800 lg:hidden"
                                aria-label="Open sidebar"
                            >
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path stroke-linecap="round" stroke-linejoin="round" d="M4 6h16M4 12h16M4 18h16" /></svg>
                            </button>

                            <div>
                                <p class="text-sm font-semibold text-slate-900 dark:text-white">Welcome back</p>
                                <p class="text-sm text-slate-500 dark:text-slate-400">Manage your learning space</p>
                            </div>
                        </div>

                        <div class="flex items-center gap-2">
                            <button
                                @click="toggleDark"
                                class="rounded-full border border-slate-300 p-2 text-slate-500 transition hover:text-slate-700 dark:border-slate-700 dark:text-slate-300"
                                aria-label="Toggle dark mode"
                            >
                                <svg v-if="isDark" xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 24 24" fill="currentColor"><path d="M12 4a1 1 0 011 1v1a1 1 0 11-2 0V5a1 1 0 011-1zm0 14a4 4 0 100-8 4 4 0 000 8zm8-6a1 1 0 110 2h-1a1 1 0 110-2h1zM5 12a1 1 0 01-1 1H3a1 1 0 110-2h1a1 1 0 011 1zm12.657-6.657a1 1 0 010 1.414l-.707.707a1 1 0 11-1.414-1.414l.707-.707a1 1 0 011.414 0zM7.464 16.95a1 1 0 010 1.414l-.707.707A1 1 0 015.343 17.66l.707-.707a1 1 0 011.414 0zm11.193 1.414a1 1 0 01-1.414 0l-.707-.707a1 1 0 111.414-1.414l.707.707a1 1 0 010 1.414zM6.757 6.757a1 1 0 01-1.414 0l-.707-.707A1 1 0 016.05 4.636l.707.707a1 1 0 010 1.414zM12 20a1 1 0 011 1v-1a1 1 0 10-2 0v1a1 1 0 011-1z"/></svg>
                                <svg v-else xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 24 24" fill="currentColor"><path d="M21 12.79A9 9 0 1111.21 3a7 7 0 009.79 9.79z"/></svg>
                            </button>

                            <Link
                                :href="route('profile.edit')"
                                class="hidden rounded-full border border-slate-200 px-3 py-2 text-sm font-medium text-slate-600 transition hover:bg-slate-100 dark:border-slate-700 dark:text-slate-300 dark:hover:bg-slate-800 sm:inline-flex"
                            >
                                Profile
                            </Link>
                        </div>
                    </div>
                </header>

                <main class="flex-1 p-4 sm:p-6 lg:p-8">
                    <slot />
                </main>
            </div>
        </div>

        <div
            v-if="showingSidebar"
            class="fixed inset-0 z-40 bg-slate-950/60 lg:hidden"
            @click="showingSidebar = false"
        />

        <aside
            v-if="showingSidebar"
            class="fixed inset-y-0 left-0 z-50 flex w-80 flex-col border-r border-slate-200 bg-white shadow-2xl dark:border-slate-800 dark:bg-slate-900 lg:hidden"
        >
            <div class="border-b border-slate-200 px-6 py-6 dark:border-slate-800">
                <Link :href="route('dashboard')" class="flex items-center gap-3" @click="showingSidebar = false">
                    <div class="flex h-10 w-10 items-center justify-center rounded-full bg-gradient-to-br from-amber-400 to-amber-600 font-bold text-white shadow-lg">
                        TH
                    </div>
                    <div>
                        <p class="text-base font-bold text-slate-900 dark:text-white">TutarHelp</p>
                    </div>
                </Link>
            </div>

            <nav class="flex-1 space-y-1 overflow-y-auto px-4 py-6">
                <p class="px-3 text-xs font-bold uppercase tracking-widest text-slate-500 dark:text-slate-400">MAIN</p>

                <template v-for="item in menuItems" :key="item.key">
                    <Link
                        v-if="item.action === 'logout'"
                        :href="route('logout')"
                        method="post"
                        as="button"
                        class="flex w-full items-center gap-3 rounded-lg px-4 py-3 text-sm font-medium transition-all duration-200 hover:bg-rose-50 hover:text-rose-600 dark:text-slate-300 dark:hover:bg-rose-500/10 dark:hover:text-rose-400"
                        @click="showingSidebar = false"
                    >
                        <div v-html="getIcon(item.icon)" class="flex-shrink-0"></div>
                        <span>{{ item.label }}</span>
                    </Link>

                    <Link
                        v-else-if="item.route && !item.hasSubmenu"
                        :href="getHref(item)"
                        class="flex items-center gap-3 rounded-lg px-4 py-3 text-sm font-medium transition-all duration-200"
                        :class="isItemActive(item)
                            ? 'bg-amber-50 text-amber-600 dark:bg-amber-500/20 dark:text-amber-400'
                            : 'text-slate-700 hover:bg-slate-100 hover:text-slate-900 dark:text-slate-300 dark:hover:bg-slate-800 dark:hover:text-slate-50'"
                        @click="showingSidebar = false"
                    >
                        <div v-html="getIcon(item.icon)" class="flex-shrink-0"></div>
                        <span>{{ item.label }}</span>
                    </Link>

                    <button
                        v-else-if="item.hasSubmenu"
                        type="button"
                        class="flex w-full items-center justify-between rounded-lg px-4 py-3 text-sm font-medium transition-all duration-200"
                        :class="isItemActive(item)
                            ? 'bg-amber-50 text-amber-600 dark:bg-amber-500/20 dark:text-amber-400'
                            : isSubmenuOpen(item)
                                ? 'bg-slate-100 text-slate-900 dark:bg-slate-800 dark:text-slate-50'
                                : 'text-slate-700 hover:bg-slate-100 hover:text-slate-900 dark:text-slate-300 dark:hover:bg-slate-800 dark:hover:text-slate-50'"
                        @click="toggleMenu(item.key)"
                    >
                        <div class="flex items-center gap-3">
                            <div v-html="getIcon(item.icon)" class="flex-shrink-0"></div>
                            <span>{{ item.label }}</span>
                        </div>
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 transition-transform duration-200" :class="isSubmenuOpen(item) ? 'rotate-180' : ''" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="6 9 12 15 18 9"></polyline></svg>
                    </button>

                    <div v-if="item.hasSubmenu && isSubmenuOpen(item)" class="ml-6 space-y-1 border-l border-slate-200 dark:border-slate-700">
                        <template v-for="subitem in item.items" :key="typeof subitem === 'string' ? subitem : subitem.key">
                            <Link
                                v-if="subitem.route"
                                :href="getHref(subitem)"
                                class="block rounded-lg px-3 py-2 text-sm transition-colors"
                                :class="route().current(subitem.route)
                                    ? 'bg-amber-50 text-amber-600 dark:bg-amber-500/20 dark:text-amber-400'
                                    : 'text-slate-600 hover:bg-slate-100 hover:text-slate-900 dark:text-slate-400 dark:hover:bg-slate-800 dark:hover:text-slate-200'"
                                @click="showingSidebar = false"
                            >
                                {{ subitem.label || subitem }}
                            </Link>
                            <div
                                v-else
                                class="rounded-lg px-3 py-2 text-sm text-slate-600 hover:bg-slate-100 hover:text-slate-900 dark:text-slate-400 dark:hover:bg-slate-800 dark:hover:text-slate-200 transition-colors"
                            >
                                {{ subitem.label || subitem }}
                            </div>
                        </template>
                    </div>

                    <Link
                        v-else-if="!item.hasSubmenu && !item.route"
                        href="#"
                        class="flex items-center gap-3 rounded-lg px-4 py-3 text-sm font-medium text-slate-700 hover:bg-slate-100 hover:text-slate-900 dark:text-slate-300 dark:hover:bg-slate-800 dark:hover:text-slate-50 transition-all duration-200"
                        @click="showingSidebar = false"
                    >
                        <div v-html="getIcon(item.icon)" class="flex-shrink-0"></div>
                        <span>{{ item.label }}</span>
                    </Link>
                </template>
            </nav>

            <div class="border-t border-slate-200 px-4 py-6 dark:border-slate-800">
                <div class="mb-4 flex items-center gap-3 rounded-lg bg-slate-50 p-3 dark:bg-slate-800">
                    <div class="flex h-10 w-10 items-center justify-center rounded-full bg-gradient-to-br from-blue-400 to-blue-600 font-bold text-white">
                        {{ user.name?.charAt(0) || 'U' }}
                    </div>
                    <div class="flex-1">
                        <p class="text-sm font-semibold text-slate-900 dark:text-white">{{ user.name }}</p>
                        <p class="text-xs text-slate-600 dark:text-slate-400">{{ roleLabel }}</p>
                    </div>
                </div>

                <Link
                    :href="route('logout')"
                    method="post"
                    as="button"
                    class="flex w-full items-center gap-3 rounded-lg px-4 py-3 text-sm font-medium text-slate-700 transition hover:bg-rose-50 hover:text-rose-600 dark:text-slate-300 dark:hover:bg-rose-500/10 dark:hover:text-rose-400"
                    @click="showingSidebar = false"
                >
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path stroke-linecap="round" stroke-linejoin="round" d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4M10 17l5-5-5-5M15 12H3" /></svg>
                    Sign out
                </Link>
            </div>
        </aside>
    </div>
</template>
