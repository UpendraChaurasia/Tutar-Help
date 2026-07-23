<script setup>
const props = defineProps({
    form: Object,
});
</script>

<template>
    <div class="rounded-3xl bg-white p-6 shadow-sm">
        <div class="grid gap-4 md:grid-cols-2">
            <div>
                <label class="block text-sm font-medium text-slate-700">Account Holder Name</label>
                <input type="text" v-model="props.form.bank.account_holder" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                <p v-if="props.form.errors['bank.account_holder']" class="mt-2 text-sm text-red-600">{{ props.form.errors['bank.account_holder'] }}</p>
            </div>
            <div>
                <label class="block text-sm font-medium text-slate-700">Bank Name</label>
                <input type="text" v-model="props.form.bank.bank_name" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                <p v-if="props.form.errors['bank.bank_name']" class="mt-2 text-sm text-red-600">{{ props.form.errors['bank.bank_name'] }}</p>
            </div>
            <div>
                <label class="block text-sm font-medium text-slate-700">Account Number</label>
                <input type="text" v-model="props.form.bank.account_number" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                <p v-if="props.form.errors['bank.account_number']" class="mt-2 text-sm text-red-600">{{ props.form.errors['bank.account_number'] }}</p>
            </div>
            <div>
                <label class="block text-sm font-medium text-slate-700">IFSC</label>
                <input type="text" v-model="props.form.bank.ifsc" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                <p v-if="props.form.errors['bank.ifsc']" class="mt-2 text-sm text-red-600">{{ props.form.errors['bank.ifsc'] }}</p>
            </div>
            <div>
                <label class="block text-sm font-medium text-slate-700">SWIFT</label>
                <input type="text" v-model="props.form.bank.swift" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                <p v-if="props.form.errors['bank.swift']" class="mt-2 text-sm text-red-600">{{ props.form.errors['bank.swift'] }}</p>
            </div>
            <div>
                <label class="block text-sm font-medium text-slate-700">IBAN</label>
                <input type="text" v-model="props.form.bank.iban" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                <p v-if="props.form.errors['bank.iban']" class="mt-2 text-sm text-red-600">{{ props.form.errors['bank.iban'] }}</p>
            </div>
            <div>
                <label class="block text-sm font-medium text-slate-700">Branch</label>
                <input type="text" v-model="props.form.bank.branch" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                <p v-if="props.form.errors['bank.branch']" class="mt-2 text-sm text-red-600">{{ props.form.errors['bank.branch'] }}</p>
            </div>
            <div>
                <label class="block text-sm font-medium text-slate-700">PayPal Email</label>
                <input type="email" v-model="props.form.bank.paypal_email" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                <p v-if="props.form.errors['bank.paypal_email']" class="mt-2 text-sm text-red-600">{{ props.form.errors['bank.paypal_email'] }}</p>
            </div>
            <div>
                <label class="block text-sm font-medium text-slate-700">Stripe Account</label>
                <input type="text" v-model="props.form.bank.stripe_account" class="mt-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" />
                <p v-if="props.form.errors['bank.stripe_account']" class="mt-2 text-sm text-red-600">{{ props.form.errors['bank.stripe_account'] }}</p>
            </div>
            <div class="md:col-span-2">
                <label class="block text-sm font-medium text-slate-700">Preferred Payment Method</label>
                <select v-model="props.form.bank.preferred_method" class="mt-2 block w-full rounded-md border-gray-300 bg-white shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
                    <option value="">Select payment method</option>
                    <option value="bank">Bank</option>
                    <option value="paypal">PayPal</option>
                    <option value="stripe">Stripe</option>
                </select>
                <p v-if="props.form.errors['bank.preferred_method']" class="mt-2 text-sm text-red-600">{{ props.form.errors['bank.preferred_method'] }}</p>
            </div>
        </div>
    </div>
</template>
