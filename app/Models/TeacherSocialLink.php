<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class TeacherSocialLink extends Model
{
    use HasFactory;

    protected $fillable = [
        'teacher_profile_id',
        'website',
        'linkedin',
        'github',
        'youtube',
        'facebook',
        'instagram',
        'twitter',
        'portfolio',
    ];

    public function profile(): BelongsTo
    {
        return $this->belongsTo(TeacherProfile::class, 'teacher_profile_id');
    }
}
