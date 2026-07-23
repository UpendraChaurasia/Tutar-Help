<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('teacher_educations', function (Blueprint $table): void {
            $table->id();
            $table->foreignId('teacher_profile_id')->constrained('teacher_profiles')->cascadeOnDelete();
            $table->string('degree');
            $table->string('college');
            $table->string('university');
            $table->string('country');
            $table->year('start_year')->nullable();
            $table->year('end_year')->nullable();
            $table->text('description')->nullable();
            $table->timestamps();

            $table->index('teacher_profile_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('teacher_educations');
    }
};
