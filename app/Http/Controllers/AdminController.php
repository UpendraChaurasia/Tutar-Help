<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Inertia\Inertia;

class AdminController extends Controller
{
    public function index(Request $request)
    {
        $query = User::role('Admin')->with('roles')->select(['id','name','email','phone','status','created_at']);

        if ($request->filled('search')) {
            $search = $request->input('search');
            $query->where(function ($q) use ($search) {
                $q->where('name','like',"%{$search}%")
                    ->orWhere('email','like',"%{$search}%")
                    ->orWhere('phone','like',"%{$search}%");
            });
        }

        if ($request->filled('sort')) {
            $sort = $request->input('sort');
            $direction = $request->input('direction', 'asc');
            $query->orderBy($sort, $direction);
        } else {
            $query->latest('created_at');
        }

        $admins = $query->paginate(10)->withQueryString();

        return Inertia::render('Admins/Index', [
            'admins' => $admins,
            'filters' => $request->only(['search','sort','direction']),
        ]);
    }

    public function create()
    {
        return Inertia::render('Admins/Create');
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => ['required','string','max:255'],
            'email' => ['required','email','max:255','unique:users,email'],
            'phone' => ['nullable','string','max:20'],
            'password' => ['required','string','min:8','confirmed'],
            'status' => ['required','in:active,inactive'],
        ]);

        $admin = User::create([
            'name' => $validated['name'],
            'email' => $validated['email'],
            'phone' => $validated['phone'] ?? null,
            'password' => Hash::make($validated['password']),
            'status' => $validated['status'],
        ]);

        $admin->assignRole('Admin');

        return redirect()->route('admins.index')->with('success', 'Admin created successfully.');
    }

    public function show(User $admin)
    {
        $admin->load('roles');

        return Inertia::render('Admins/Show', [
            'admin' => $admin,
        ]);
    }

    public function edit(User $admin)
    {
        $admin->load('roles');

        return Inertia::render('Admins/Edit', [
            'admin' => $admin,
        ]);
    }

    public function update(Request $request, User $admin)
    {
        $validated = $request->validate([
            'name' => ['required','string','max:255'],
            'email' => ['required','email','max:255','unique:users,email,' . $admin->id],
            'phone' => ['nullable','string','max:20'],
            'password' => ['nullable','string','min:8','confirmed'],
            'status' => ['required','in:active,inactive'],
        ]);

        $admin->fill([
            'name' => $validated['name'],
            'email' => $validated['email'],
            'phone' => $validated['phone'] ?? null,
            'status' => $validated['status'],
        ]);

        if (!empty($validated['password'])) {
            $admin->password = Hash::make($validated['password']);
        }

        $admin->save();

        return redirect()->route('admins.index')->with('success', 'Admin updated successfully.');
    }

    public function destroy(User $admin)
    {
        $admin->delete();

        return redirect()->route('admins.index')->with('success', 'Admin deleted successfully.');
    }
}
