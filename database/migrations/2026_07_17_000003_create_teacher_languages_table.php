<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('teacher_languages', function (Blueprint $table): void {
            $table->id();
            $table->foreignId('teacher_profile_id')->constrained('teacher_profiles')->cascadeOnDelete();
            $table->string('language');
            $table->timestamps();

            $table->index('teacher_profile_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('teacher_languages');
    }
};
