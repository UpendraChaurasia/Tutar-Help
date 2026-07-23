<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('teacher_profiles', function (Blueprint $table): void {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->string('profile_photo')->nullable();
            $table->enum('gender', ['male', 'female', 'other'])->nullable();
            $table->date('date_of_birth')->nullable();
            $table->string('phone')->nullable();
            $table->string('country')->nullable();
            $table->string('state')->nullable();
            $table->string('city')->nullable();
            $table->string('timezone')->nullable();
            $table->string('preferred_language')->nullable();
            $table->string('short_bio', 500)->nullable();
            $table->text('about_me')->nullable();
            $table->string('headline')->nullable();
            $table->unsignedTinyInteger('experience_years')->nullable();
            $table->string('current_occupation')->nullable();
            $table->string('current_organization')->nullable();
            $table->string('teaching_level')->nullable();
            $table->decimal('hourly_rate', 10, 2)->nullable();
            $table->string('introduction_video')->nullable();
            $table->unsignedTinyInteger('profile_completion_percentage')->default(0);
            $table->enum('status', ['pending', 'under_review', 'approved', 'rejected'])->default('pending');
            $table->foreignId('approved_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamp('approved_at')->nullable();
            $table->text('rejection_reason')->nullable();
            $table->timestamps();

            $table->unique('user_id');
            $table->index('status');
            $table->index('approved_by');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('teacher_profiles');
    }
};
