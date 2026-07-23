<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class TeacherProfile extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'profile_photo',
        'gender',
        'date_of_birth',
        'phone',
        'country',
        'state',
        'city',
        'timezone',
        'preferred_language',
        'short_bio',
        'about_me',
        'headline',
        'experience_years',
        'current_occupation',
        'current_organization',
        'teaching_level',
        'hourly_rate',
        'introduction_video',
        'profile_completion_percentage',
        'status',
        'approved_by',
        'approved_at',
        'rejection_reason',
    ];

    protected $casts = [
        'date_of_birth' => 'date',
        'approved_at' => 'datetime',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function subjects(): HasMany
    {
        return $this->hasMany(TeacherSubject::class);
    }

    public function languages(): HasMany
    {
        return $this->hasMany(TeacherLanguage::class);
    }

    public function educations(): HasMany
    {
        return $this->hasMany(TeacherEducation::class);
    }

    public function experiences(): HasMany
    {
        return $this->hasMany(TeacherExperience::class);
    }

    public function certificates(): HasMany
    {
        return $this->hasMany(TeacherCertificate::class);
    }

    public function documents(): HasMany
    {
        return $this->hasMany(TeacherDocument::class);
    }

    public function availabilities(): HasMany
    {
        return $this->hasMany(TeacherAvailability::class);
    }

    public function bankAccount(): HasMany
    {
        return $this->hasMany(TeacherBankAccount::class);
    }

    public function socialLinks(): HasMany
    {
        return $this->hasMany(TeacherSocialLink::class);
    }

    public function applications(): HasMany
    {
        return $this->hasMany(TeacherApplication::class);
    }
}
