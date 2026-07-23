<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('teacher_certificates', function (Blueprint $table): void {
            $table->id();
            $table->foreignId('teacher_profile_id')->constrained('teacher_profiles')->cascadeOnDelete();
            $table->string('certificate_name');
            $table->string('issued_by')->nullable();
            $table->date('issue_date')->nullable();
            $table->date('expiry_date')->nullable();
            $table->string('credential_id')->nullable();
            $table->string('credential_url')->nullable();
            $table->string('certificate_file')->nullable();
            $table->timestamps();

            $table->index('teacher_profile_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('teacher_certificates');
    }
};
