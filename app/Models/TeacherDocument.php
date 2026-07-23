<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class TeacherDocument extends Model
{
    use HasFactory;

    protected $fillable = [
        'teacher_profile_id',
        'document_type',
        'document_number',
        'front_image',
        'back_image',
        'selfie_image',
        'address_proof',
        'verification_status',
    ];

    public function profile(): BelongsTo
    {
        return $this->belongsTo(TeacherProfile::class, 'teacher_profile_id');
    }
}
