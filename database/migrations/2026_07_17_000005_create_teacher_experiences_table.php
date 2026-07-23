<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('teacher_experiences', function (Blueprint $table): void {
            $table->id();
            $table->foreignId('teacher_profile_id')->constrained('teacher_profiles')->cascadeOnDelete();
            $table->string('company');
            $table->string('designation');
            $table->string('industry')->nullable();
            $table->date('start_date')->nullable();
            $table->date('end_date')->nullable();
            $table->boolean('currently_working')->default(false);
            $table->text('description')->nullable();
            $table->timestamps();

            $table->index('teacher_profile_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('teacher_experiences');
    }
};
