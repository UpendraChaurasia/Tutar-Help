<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class TeacherExperience extends Model
{
    use HasFactory;

    protected $fillable = [
        'teacher_profile_id',
        'company',
        'designation',
        'industry',
        'start_date',
        'end_date',
        'currently_working',
        'description',
    ];

    protected $casts = [
        'currently_working' => 'boolean',
        'start_date' => 'date',
        'end_date' => 'date',
    ];

    public function profile(): BelongsTo
    {
        return $this->belongsTo(TeacherProfile::class, 'teacher_profile_id');
    }
}
