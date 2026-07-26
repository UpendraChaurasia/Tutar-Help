<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class AdminUpdateRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'name' => ['required','string','max:255'],
            'email' => ['required','email','max:255','unique:users,email,' . $this->route('admin')?->id],
            'phone' => ['nullable','string','max:20'],
            'password' => ['nullable','string','min:8','confirmed'],
            'status' => ['required','in:active,inactive'],
        ];
    }
}
