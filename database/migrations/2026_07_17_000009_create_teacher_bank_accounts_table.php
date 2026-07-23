<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('teacher_bank_accounts', function (Blueprint $table): void {
            $table->id();
            $table->foreignId('teacher_profile_id')->constrained('teacher_profiles')->cascadeOnDelete();
            $table->string('account_holder')->nullable();
            $table->string('bank_name')->nullable();
            $table->string('account_number')->nullable();
            $table->string('ifsc')->nullable();
            $table->string('swift')->nullable();
            $table->string('iban')->nullable();
            $table->string('branch')->nullable();
            $table->string('paypal_email')->nullable();
            $table->string('stripe_account')->nullable();
            $table->enum('preferred_method', ['bank', 'paypal', 'stripe'])->nullable();
            $table->timestamps();

            $table->index('teacher_profile_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('teacher_bank_accounts');
    }
};
