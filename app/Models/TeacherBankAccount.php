<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class TeacherBankAccount extends Model
{
    use HasFactory;

    protected $fillable = [
        'teacher_profile_id',
        'account_holder',
        'bank_name',
        'account_number',
        'ifsc',
        'swift',
        'iban',
        'branch',
        'paypal_email',
        'stripe_account',
        'preferred_method',
    ];

    public function profile(): BelongsTo
    {
        return $this->belongsTo(TeacherProfile::class, 'teacher_profile_id');
    }
}
