<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class TeacherCertificate extends Model
{
    use HasFactory;

    protected $fillable = [
        'teacher_profile_id',
        'certificate_name',
        'issued_by',
        'issue_date',
        'expiry_date',
        'credential_id',
        'credential_url',
        'certificate_file',
    ];

    protected $casts = [
        'issue_date' => 'date',
        'expiry_date' => 'date',
    ];

    public function profile(): BelongsTo
    {
        return $this->belongsTo(TeacherProfile::class, 'teacher_profile_id');
    }
}
