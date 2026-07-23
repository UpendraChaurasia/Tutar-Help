<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class TeacherEducation extends Model
{
    use HasFactory;
    protected $table = 'teacher_educations';
    protected $fillable = [
        'teacher_profile_id',
        'degree',
        'college',
        'university',
        'country',
        'start_year',
        'end_year',
        'description',
    ];

    protected $casts = [
        'start_year' => 'integer',
        'end_year' => 'integer',
    ];

    public function profile(): BelongsTo
    {
        return $this->belongsTo(TeacherProfile::class, 'teacher_profile_id');
    }
}
