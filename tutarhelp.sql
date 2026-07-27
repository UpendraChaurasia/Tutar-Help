-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 27, 2026 at 09:39 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tutarhelp`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel-cache-david121@yopmail.com|127.0.0.1', 'i:2;', 1785105313),
('laravel-cache-david121@yopmail.com|127.0.0.1:timer', 'i:1785105313;', 1785105313),
('laravel-cache-spatie.permission.cache', 'a:3:{s:5:\"alias\";a:3:{s:1:\"a\";s:2:\"id\";s:1:\"b\";s:4:\"name\";s:1:\"c\";s:10:\"guard_name\";}s:11:\"permissions\";a:15:{i:0;a:3:{s:1:\"a\";i:1;s:1:\"b\";s:10:\"admin.view\";s:1:\"c\";s:3:\"web\";}i:1;a:3:{s:1:\"a\";i:2;s:1:\"b\";s:12:\"admin.create\";s:1:\"c\";s:3:\"web\";}i:2;a:3:{s:1:\"a\";i:3;s:1:\"b\";s:10:\"admin.edit\";s:1:\"c\";s:3:\"web\";}i:3;a:3:{s:1:\"a\";i:4;s:1:\"b\";s:12:\"admin.delete\";s:1:\"c\";s:3:\"web\";}i:4;a:3:{s:1:\"a\";i:5;s:1:\"b\";s:12:\"teacher.view\";s:1:\"c\";s:3:\"web\";}i:5;a:3:{s:1:\"a\";i:6;s:1:\"b\";s:14:\"teacher.create\";s:1:\"c\";s:3:\"web\";}i:6;a:3:{s:1:\"a\";i:7;s:1:\"b\";s:12:\"teacher.edit\";s:1:\"c\";s:3:\"web\";}i:7;a:3:{s:1:\"a\";i:8;s:1:\"b\";s:14:\"teacher.delete\";s:1:\"c\";s:3:\"web\";}i:8;a:3:{s:1:\"a\";i:9;s:1:\"b\";s:12:\"student.view\";s:1:\"c\";s:3:\"web\";}i:9;a:3:{s:1:\"a\";i:10;s:1:\"b\";s:14:\"student.create\";s:1:\"c\";s:3:\"web\";}i:10;a:3:{s:1:\"a\";i:11;s:1:\"b\";s:12:\"student.edit\";s:1:\"c\";s:3:\"web\";}i:11;a:3:{s:1:\"a\";i:12;s:1:\"b\";s:14:\"student.delete\";s:1:\"c\";s:3:\"web\";}i:12;a:3:{s:1:\"a\";i:13;s:1:\"b\";s:9:\"role.view\";s:1:\"c\";s:3:\"web\";}i:13;a:3:{s:1:\"a\";i:14;s:1:\"b\";s:11:\"role.manage\";s:1:\"c\";s:3:\"web\";}i:14;a:3:{s:1:\"a\";i:15;s:1:\"b\";s:12:\"profile.edit\";s:1:\"c\";s:3:\"web\";}}s:5:\"roles\";a:0:{}}', 1785191536),
('laravel-cache-test123@yopmail.com|127.0.0.1', 'i:1;', 1785105298),
('laravel-cache-test123@yopmail.com|127.0.0.1:timer', 'i:1785105298;', 1785105298);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_07_08_210627_create_permission_tables', 1),
(5, '2026_07_09_000001_add_specialization_to_users_table', 1),
(6, '2026_07_17_000001_create_teacher_profiles_table', 1),
(7, '2026_07_17_000002_create_teacher_subjects_table', 1),
(8, '2026_07_17_000003_create_teacher_languages_table', 1),
(9, '2026_07_17_000004_create_teacher_educations_table', 1),
(10, '2026_07_17_000005_create_teacher_experiences_table', 1),
(11, '2026_07_17_000006_create_teacher_certificates_table', 1),
(12, '2026_07_17_000007_create_teacher_documents_table', 1),
(13, '2026_07_17_000008_create_teacher_availabilities_table', 1),
(14, '2026_07_17_000009_create_teacher_bank_accounts_table', 1),
(15, '2026_07_17_000010_create_teacher_social_links_table', 1),
(16, '2026_07_17_000011_create_teacher_applications_table', 1),
(17, '2026_07_27_000001_add_phone_and_status_to_users_table', 1),
(18, '2026_07_27_000000_add_indexes_to_teacher_applications_table', 2),
(19, '2026_07_27_000001_add_created_at_index_to_users_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_permissions`
--

INSERT INTO `model_has_permissions` (`permission_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(1, 'App\\Models\\User', 2),
(2, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 2),
(3, 'App\\Models\\User', 1),
(3, 'App\\Models\\User', 2),
(4, 'App\\Models\\User', 1),
(4, 'App\\Models\\User', 2),
(5, 'App\\Models\\User', 1),
(5, 'App\\Models\\User', 2),
(6, 'App\\Models\\User', 1),
(6, 'App\\Models\\User', 2),
(7, 'App\\Models\\User', 1),
(7, 'App\\Models\\User', 2),
(8, 'App\\Models\\User', 1),
(8, 'App\\Models\\User', 2),
(9, 'App\\Models\\User', 1),
(9, 'App\\Models\\User', 2),
(10, 'App\\Models\\User', 1),
(10, 'App\\Models\\User', 2),
(11, 'App\\Models\\User', 1),
(11, 'App\\Models\\User', 2),
(12, 'App\\Models\\User', 1),
(12, 'App\\Models\\User', 2),
(13, 'App\\Models\\User', 1),
(13, 'App\\Models\\User', 2),
(14, 'App\\Models\\User', 1),
(15, 'App\\Models\\User', 1);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 2),
(3, 'App\\Models\\User', 3),
(3, 'App\\Models\\User', 4),
(3, 'App\\Models\\User', 5),
(3, 'App\\Models\\User', 6),
(4, 'App\\Models\\User', 7),
(4, 'App\\Models\\User', 8),
(4, 'App\\Models\\User', 9),
(4, 'App\\Models\\User', 10),
(4, 'App\\Models\\User', 11),
(4, 'App\\Models\\User', 12),
(4, 'App\\Models\\User', 13),
(4, 'App\\Models\\User', 14);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'admin.view', 'web', '2026-07-26 17:02:13', '2026-07-26 17:02:13'),
(2, 'admin.create', 'web', '2026-07-26 17:02:13', '2026-07-26 17:02:13'),
(3, 'admin.edit', 'web', '2026-07-26 17:02:13', '2026-07-26 17:02:13'),
(4, 'admin.delete', 'web', '2026-07-26 17:02:13', '2026-07-26 17:02:13'),
(5, 'teacher.view', 'web', '2026-07-26 17:02:13', '2026-07-26 17:02:13'),
(6, 'teacher.create', 'web', '2026-07-26 17:02:13', '2026-07-26 17:02:13'),
(7, 'teacher.edit', 'web', '2026-07-26 17:02:13', '2026-07-26 17:02:13'),
(8, 'teacher.delete', 'web', '2026-07-26 17:02:13', '2026-07-26 17:02:13'),
(9, 'student.view', 'web', '2026-07-26 17:02:13', '2026-07-26 17:02:13'),
(10, 'student.create', 'web', '2026-07-26 17:02:13', '2026-07-26 17:02:13'),
(11, 'student.edit', 'web', '2026-07-26 17:02:13', '2026-07-26 17:02:13'),
(12, 'student.delete', 'web', '2026-07-26 17:02:14', '2026-07-26 17:02:14'),
(13, 'role.view', 'web', '2026-07-26 17:02:14', '2026-07-26 17:02:14'),
(14, 'role.manage', 'web', '2026-07-26 17:02:14', '2026-07-26 17:02:14'),
(15, 'profile.edit', 'web', '2026-07-26 17:02:14', '2026-07-26 17:02:14');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'Superadmin', 'web', '2026-07-26 17:02:14', '2026-07-26 17:02:14'),
(2, 'Admin', 'web', '2026-07-26 17:02:14', '2026-07-26 17:02:14'),
(3, 'Teacher', 'web', '2026-07-26 17:02:14', '2026-07-26 17:02:14'),
(4, 'Student', 'web', '2026-07-26 17:02:14', '2026-07-26 17:02:14');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('FslBTe3HQ1E9X3UcxdsvuB0krJnM5PZKYcKp9fCv', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNTRXNE5HQk5aZUo4RHFGVTBRTTF4ZGYycjN0cmk2SjlMaDRLWWZmRiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9yb2xlcyI7czo1OiJyb3V0ZSI7czoxMToicm9sZXMuaW5kZXgiO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1785107680),
('PAnhSVQ0R3NlMkFPmXtrCfwIQYAQzqaqDc3VdAOR', 6, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiMWZEYlZjNDRLM3lKdkFtaUhJcTJjZVlIRXplQld5QkRKTFF3MHJKRCI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjM5OiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvdGVhY2hlci9kYXNoYm9hcmQiO3M6NToicm91dGUiO3M6MTc6InRlYWNoZXIuZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6Njt9', 1785107576),
('WvYUZUPI9plyeBqlEUSaMbtL8fT7sqd6pCpwghL5', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiU0VmWnREMUhsY0RzSWo1THRxb3JqN2dQcTNBZ0o4ZWJtQUh4b2RGRSI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjI3OiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvbG9naW4iO3M6NToicm91dGUiO3M6NToibG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1785136086);

-- --------------------------------------------------------

--
-- Table structure for table `teacher_applications`
--

CREATE TABLE `teacher_applications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `teacher_profile_id` bigint(20) UNSIGNED NOT NULL,
  `submitted_at` timestamp NULL DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `reviewed_by` bigint(20) UNSIGNED DEFAULT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `teacher_availabilities`
--

CREATE TABLE `teacher_availabilities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `teacher_profile_id` bigint(20) UNSIGNED NOT NULL,
  `day` enum('monday','tuesday','wednesday','thursday','friday','saturday','sunday') NOT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `teacher_availabilities`
--

INSERT INTO `teacher_availabilities` (`id`, `teacher_profile_id`, `day`, `start_time`, `end_time`, `created_at`, `updated_at`) VALUES
(1, 1, 'monday', '04:40:00', '04:42:00', '2026-07-26 17:40:25', '2026-07-26 17:40:25');

-- --------------------------------------------------------

--
-- Table structure for table `teacher_bank_accounts`
--

CREATE TABLE `teacher_bank_accounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `teacher_profile_id` bigint(20) UNSIGNED NOT NULL,
  `account_holder` varchar(255) DEFAULT NULL,
  `bank_name` varchar(255) DEFAULT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `ifsc` varchar(255) DEFAULT NULL,
  `swift` varchar(255) DEFAULT NULL,
  `iban` varchar(255) DEFAULT NULL,
  `branch` varchar(255) DEFAULT NULL,
  `paypal_email` varchar(255) DEFAULT NULL,
  `stripe_account` varchar(255) DEFAULT NULL,
  `preferred_method` enum('bank','paypal','stripe') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `teacher_bank_accounts`
--

INSERT INTO `teacher_bank_accounts` (`id`, `teacher_profile_id`, `account_holder`, `bank_name`, `account_number`, `ifsc`, `swift`, `iban`, `branch`, `paypal_email`, `stripe_account`, `preferred_method`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-26 17:36:54', '2026-07-26 17:36:54');

-- --------------------------------------------------------

--
-- Table structure for table `teacher_certificates`
--

CREATE TABLE `teacher_certificates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `teacher_profile_id` bigint(20) UNSIGNED NOT NULL,
  `certificate_name` varchar(255) NOT NULL,
  `issued_by` varchar(255) DEFAULT NULL,
  `issue_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `credential_id` varchar(255) DEFAULT NULL,
  `credential_url` varchar(255) DEFAULT NULL,
  `certificate_file` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `teacher_certificates`
--

INSERT INTO `teacher_certificates` (`id`, `teacher_profile_id`, `certificate_name`, `issued_by`, `issue_date`, `expiry_date`, `credential_id`, `credential_url`, `certificate_file`, `created_at`, `updated_at`) VALUES
(3, 1, 'Test', 'Testing', '2026-02-03', '2026-06-10', 'testing', 'test.com', NULL, '2026-07-26 17:40:25', '2026-07-26 17:40:25');

-- --------------------------------------------------------

--
-- Table structure for table `teacher_documents`
--

CREATE TABLE `teacher_documents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `teacher_profile_id` bigint(20) UNSIGNED NOT NULL,
  `document_type` varchar(255) NOT NULL,
  `document_number` varchar(255) DEFAULT NULL,
  `front_image` varchar(255) DEFAULT NULL,
  `back_image` varchar(255) DEFAULT NULL,
  `selfie_image` varchar(255) DEFAULT NULL,
  `address_proof` varchar(255) DEFAULT NULL,
  `verification_status` enum('pending','verified','rejected') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `teacher_documents`
--

INSERT INTO `teacher_documents` (`id`, `teacher_profile_id`, `document_type`, `document_number`, `front_image`, `back_image`, `selfie_image`, `address_proof`, `verification_status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Test', 'test', NULL, NULL, NULL, NULL, 'pending', '2026-07-26 17:40:06', '2026-07-26 17:40:06');

-- --------------------------------------------------------

--
-- Table structure for table `teacher_educations`
--

CREATE TABLE `teacher_educations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `teacher_profile_id` bigint(20) UNSIGNED NOT NULL,
  `degree` varchar(255) NOT NULL,
  `college` varchar(255) NOT NULL,
  `university` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `start_year` year(4) DEFAULT NULL,
  `end_year` year(4) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `teacher_educations`
--

INSERT INTO `teacher_educations` (`id`, `teacher_profile_id`, `degree`, `college`, `university`, `country`, `start_year`, `end_year`, `description`, `created_at`, `updated_at`) VALUES
(5, 1, 'BCA', 'DU', 'DU', 'India', '1990', '1993', 'Testing by team', '2026-07-26 17:40:25', '2026-07-26 17:40:25');

-- --------------------------------------------------------

--
-- Table structure for table `teacher_experiences`
--

CREATE TABLE `teacher_experiences` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `teacher_profile_id` bigint(20) UNSIGNED NOT NULL,
  `company` varchar(255) NOT NULL,
  `designation` varchar(255) NOT NULL,
  `industry` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `currently_working` tinyint(1) NOT NULL DEFAULT 0,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `teacher_experiences`
--

INSERT INTO `teacher_experiences` (`id`, `teacher_profile_id`, `company`, `designation`, `industry`, `start_date`, `end_date`, `currently_working`, `description`, `created_at`, `updated_at`) VALUES
(4, 1, 'Testing', 'Testing', 'Testing', '2026-03-03', '2026-07-16', 0, 'Testing by team', '2026-07-26 17:40:25', '2026-07-26 17:40:25');

-- --------------------------------------------------------

--
-- Table structure for table `teacher_languages`
--

CREATE TABLE `teacher_languages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `teacher_profile_id` bigint(20) UNSIGNED NOT NULL,
  `language` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `teacher_languages`
--

INSERT INTO `teacher_languages` (`id`, `teacher_profile_id`, `language`, `created_at`, `updated_at`) VALUES
(6, 1, 'English', '2026-07-26 17:40:25', '2026-07-26 17:40:25');

-- --------------------------------------------------------

--
-- Table structure for table `teacher_profiles`
--

CREATE TABLE `teacher_profiles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `profile_photo` varchar(255) DEFAULT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `timezone` varchar(255) DEFAULT NULL,
  `preferred_language` varchar(255) DEFAULT NULL,
  `short_bio` varchar(500) DEFAULT NULL,
  `about_me` text DEFAULT NULL,
  `headline` varchar(255) DEFAULT NULL,
  `experience_years` tinyint(3) UNSIGNED DEFAULT NULL,
  `current_occupation` varchar(255) DEFAULT NULL,
  `current_organization` varchar(255) DEFAULT NULL,
  `teaching_level` varchar(255) DEFAULT NULL,
  `hourly_rate` decimal(10,2) DEFAULT NULL,
  `introduction_video` varchar(255) DEFAULT NULL,
  `profile_completion_percentage` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `status` enum('pending','under_review','approved','rejected') NOT NULL DEFAULT 'pending',
  `approved_by` bigint(20) UNSIGNED DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `rejection_reason` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `teacher_profiles`
--

INSERT INTO `teacher_profiles` (`id`, `user_id`, `profile_photo`, `gender`, `date_of_birth`, `phone`, `country`, `state`, `city`, `timezone`, `preferred_language`, `short_bio`, `about_me`, `headline`, `experience_years`, `current_occupation`, `current_organization`, `teaching_level`, `hourly_rate`, `introduction_video`, `profile_completion_percentage`, `status`, `approved_by`, `approved_at`, `rejection_reason`, `created_at`, `updated_at`) VALUES
(1, 6, NULL, 'male', '2026-06-10', '9898989898', 'India', 'Delhi', 'Delhi', 'Asia/Kolkata (IST)', 'English', NULL, NULL, 'Testing', 3, 'Testing', 'Testing', 'Testing', 500.00, NULL, 90, 'pending', NULL, NULL, NULL, '2026-07-26 17:34:30', '2026-07-26 17:40:25');

-- --------------------------------------------------------

--
-- Table structure for table `teacher_social_links`
--

CREATE TABLE `teacher_social_links` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `teacher_profile_id` bigint(20) UNSIGNED NOT NULL,
  `website` varchar(255) DEFAULT NULL,
  `linkedin` varchar(255) DEFAULT NULL,
  `github` varchar(255) DEFAULT NULL,
  `youtube` varchar(255) DEFAULT NULL,
  `facebook` varchar(255) DEFAULT NULL,
  `instagram` varchar(255) DEFAULT NULL,
  `twitter` varchar(255) DEFAULT NULL,
  `portfolio` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `teacher_social_links`
--

INSERT INTO `teacher_social_links` (`id`, `teacher_profile_id`, `website`, `linkedin`, `github`, `youtube`, `facebook`, `instagram`, `twitter`, `portfolio`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-26 17:36:54', '2026-07-26 17:36:54');

-- --------------------------------------------------------

--
-- Table structure for table `teacher_subjects`
--

CREATE TABLE `teacher_subjects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `teacher_profile_id` bigint(20) UNSIGNED NOT NULL,
  `subject_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `teacher_subjects`
--

INSERT INTO `teacher_subjects` (`id`, `teacher_profile_id`, `subject_name`, `created_at`, `updated_at`) VALUES
(6, 1, 'English', '2026-07-26 17:40:25', '2026-07-26 17:40:25');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `specialization` varchar(255) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `phone`, `status`, `specialization`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Super Admin', 'superadmin@example.com', '2026-07-26 17:02:15', '$2y$12$Lj6JI/4sZ07x95QB3NPn9OioZQ0ktGLNdHeodkJdmLEzo5zD.psTy', NULL, 'active', NULL, NULL, '2026-07-26 17:02:15', '2026-07-26 17:02:15'),
(2, 'Admin', 'admin@example.com', '2026-07-26 17:02:16', '$2y$12$DEv0O0emUvC8OjWxo62pWed7ubqAifmLy4.VfsmjpCvOOwMUq4SkG', NULL, 'active', NULL, NULL, '2026-07-26 17:02:16', '2026-07-26 17:02:16'),
(3, 'Dr. Kadin Schmidt DDS', 'roderick.walter@example.net', '2026-07-26 17:02:17', '$2y$12$0TLIDy0OoZIvg6w4KKQ9I.jN4Mfq6zpk1vmCdJeTR9U0TUzjkc4N2', '740.744.6935', 'active', 'Science', 'hVzG5tGvWH', '2026-07-26 17:02:17', '2026-07-26 17:02:17'),
(4, 'Mrs. Rosalee Kulas', 'cara70@example.com', '2026-07-26 17:02:17', '$2y$12$0TLIDy0OoZIvg6w4KKQ9I.jN4Mfq6zpk1vmCdJeTR9U0TUzjkc4N2', '(281) 497-8266', 'active', 'English', 'r3tAQ7jr6J', '2026-07-26 17:02:18', '2026-07-26 17:02:18'),
(5, 'Zachary Hand', 'tabitha86@example.com', '2026-07-26 17:02:17', '$2y$12$0TLIDy0OoZIvg6w4KKQ9I.jN4Mfq6zpk1vmCdJeTR9U0TUzjkc4N2', '+1.689.479.6473', 'active', 'Science', 'S6nimXWPDL', '2026-07-26 17:02:18', '2026-07-26 17:02:18'),
(6, 'Dillon Wisozk Jr.', 'stracke.jody@example.com', '2026-07-26 17:02:17', '$2y$12$0TLIDy0OoZIvg6w4KKQ9I.jN4Mfq6zpk1vmCdJeTR9U0TUzjkc4N2', '(601) 380-8431', 'active', 'Mathematics', 'uR1u1vOEEn', '2026-07-26 17:02:18', '2026-07-26 17:02:18'),
(7, 'Delilah Lowe I', 'randall.rippin@example.org', '2026-07-26 17:02:18', '$2y$12$0TLIDy0OoZIvg6w4KKQ9I.jN4Mfq6zpk1vmCdJeTR9U0TUzjkc4N2', '470-335-1330', 'inactive', NULL, '7ZGKMJ4Sih', '2026-07-26 17:02:18', '2026-07-26 17:02:18'),
(8, 'Prof. Tanner Simonis', 'gerald.gutmann@example.org', '2026-07-26 17:02:18', '$2y$12$0TLIDy0OoZIvg6w4KKQ9I.jN4Mfq6zpk1vmCdJeTR9U0TUzjkc4N2', '+1-480-529-5942', 'inactive', NULL, 'XRRSen0kMy', '2026-07-26 17:02:18', '2026-07-26 17:02:18'),
(9, 'Nina Goldner', 'ufritsch@example.org', '2026-07-26 17:02:18', '$2y$12$0TLIDy0OoZIvg6w4KKQ9I.jN4Mfq6zpk1vmCdJeTR9U0TUzjkc4N2', '+17858669144', 'inactive', NULL, 'YnrKYpRuJJ', '2026-07-26 17:02:18', '2026-07-26 17:02:18'),
(10, 'Julius Roberts', 'jayson38@example.net', '2026-07-26 17:02:18', '$2y$12$0TLIDy0OoZIvg6w4KKQ9I.jN4Mfq6zpk1vmCdJeTR9U0TUzjkc4N2', '(307) 624-9815', 'inactive', NULL, 'eFc9Yc3qKq', '2026-07-26 17:02:18', '2026-07-26 17:02:18'),
(11, 'Domenic Lueilwitz', 'deborah85@example.net', '2026-07-26 17:02:18', '$2y$12$0TLIDy0OoZIvg6w4KKQ9I.jN4Mfq6zpk1vmCdJeTR9U0TUzjkc4N2', '+1.986.805.8144', 'inactive', NULL, 'PLd5YN76aG', '2026-07-26 17:02:18', '2026-07-26 17:02:18'),
(12, 'Freeda Okuneva', 'angie.friesen@example.org', '2026-07-26 17:02:18', '$2y$12$0TLIDy0OoZIvg6w4KKQ9I.jN4Mfq6zpk1vmCdJeTR9U0TUzjkc4N2', '+1 (336) 454-2452', 'active', NULL, 'liILvuJwdt', '2026-07-26 17:02:18', '2026-07-26 17:02:18'),
(13, 'Dr. Priscilla Wilderman V', 'josiane20@example.org', '2026-07-26 17:02:18', '$2y$12$0TLIDy0OoZIvg6w4KKQ9I.jN4Mfq6zpk1vmCdJeTR9U0TUzjkc4N2', '+1-251-430-3511', 'active', NULL, '6v5VugrdfX', '2026-07-26 17:02:19', '2026-07-26 17:02:19'),
(14, 'Claudie Kreiger', 'kulas.alena@example.org', '2026-07-26 17:02:18', '$2y$12$0TLIDy0OoZIvg6w4KKQ9I.jN4Mfq6zpk1vmCdJeTR9U0TUzjkc4N2', '1-484-797-2910', 'inactive', NULL, 'A8qodToYSg', '2026-07-26 17:02:19', '2026-07-26 17:02:19'),
(15, 'Test User', 'test@example.com', '2026-07-26 17:02:20', '$2y$12$mL8k2/PzsKvmEGbbjR9ZrOQkz3JuJc0igMwwLOwcFGpnsOL.J1eAm', NULL, 'active', NULL, NULL, '2026-07-26 17:02:20', '2026-07-26 17:02:20');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `teacher_applications`
--
ALTER TABLE `teacher_applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacher_applications_reviewed_by_foreign` (`reviewed_by`),
  ADD KEY `teacher_applications_teacher_profile_id_index` (`teacher_profile_id`),
  ADD KEY `teacher_applications_status_index` (`status`),
  ADD KEY `teacher_applications_submitted_at_index` (`submitted_at`),
  ADD KEY `teacher_applications_status_submitted_at_index` (`status`,`submitted_at`);

--
-- Indexes for table `teacher_availabilities`
--
ALTER TABLE `teacher_availabilities`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `teacher_availabilities_teacher_profile_id_day_unique` (`teacher_profile_id`,`day`);

--
-- Indexes for table `teacher_bank_accounts`
--
ALTER TABLE `teacher_bank_accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacher_bank_accounts_teacher_profile_id_index` (`teacher_profile_id`);

--
-- Indexes for table `teacher_certificates`
--
ALTER TABLE `teacher_certificates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacher_certificates_teacher_profile_id_index` (`teacher_profile_id`);

--
-- Indexes for table `teacher_documents`
--
ALTER TABLE `teacher_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacher_documents_teacher_profile_id_index` (`teacher_profile_id`),
  ADD KEY `teacher_documents_verification_status_index` (`verification_status`);

--
-- Indexes for table `teacher_educations`
--
ALTER TABLE `teacher_educations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacher_educations_teacher_profile_id_index` (`teacher_profile_id`);

--
-- Indexes for table `teacher_experiences`
--
ALTER TABLE `teacher_experiences`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacher_experiences_teacher_profile_id_index` (`teacher_profile_id`);

--
-- Indexes for table `teacher_languages`
--
ALTER TABLE `teacher_languages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacher_languages_teacher_profile_id_index` (`teacher_profile_id`);

--
-- Indexes for table `teacher_profiles`
--
ALTER TABLE `teacher_profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `teacher_profiles_user_id_unique` (`user_id`),
  ADD KEY `teacher_profiles_status_index` (`status`),
  ADD KEY `teacher_profiles_approved_by_index` (`approved_by`);

--
-- Indexes for table `teacher_social_links`
--
ALTER TABLE `teacher_social_links`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacher_social_links_teacher_profile_id_index` (`teacher_profile_id`);

--
-- Indexes for table `teacher_subjects`
--
ALTER TABLE `teacher_subjects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacher_subjects_teacher_profile_id_index` (`teacher_profile_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_created_at_index` (`created_at`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `teacher_applications`
--
ALTER TABLE `teacher_applications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `teacher_availabilities`
--
ALTER TABLE `teacher_availabilities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `teacher_bank_accounts`
--
ALTER TABLE `teacher_bank_accounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `teacher_certificates`
--
ALTER TABLE `teacher_certificates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `teacher_documents`
--
ALTER TABLE `teacher_documents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `teacher_educations`
--
ALTER TABLE `teacher_educations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `teacher_experiences`
--
ALTER TABLE `teacher_experiences`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `teacher_languages`
--
ALTER TABLE `teacher_languages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `teacher_profiles`
--
ALTER TABLE `teacher_profiles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `teacher_social_links`
--
ALTER TABLE `teacher_social_links`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `teacher_subjects`
--
ALTER TABLE `teacher_subjects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `teacher_applications`
--
ALTER TABLE `teacher_applications`
  ADD CONSTRAINT `teacher_applications_reviewed_by_foreign` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `teacher_applications_teacher_profile_id_foreign` FOREIGN KEY (`teacher_profile_id`) REFERENCES `teacher_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `teacher_availabilities`
--
ALTER TABLE `teacher_availabilities`
  ADD CONSTRAINT `teacher_availabilities_teacher_profile_id_foreign` FOREIGN KEY (`teacher_profile_id`) REFERENCES `teacher_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `teacher_bank_accounts`
--
ALTER TABLE `teacher_bank_accounts`
  ADD CONSTRAINT `teacher_bank_accounts_teacher_profile_id_foreign` FOREIGN KEY (`teacher_profile_id`) REFERENCES `teacher_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `teacher_certificates`
--
ALTER TABLE `teacher_certificates`
  ADD CONSTRAINT `teacher_certificates_teacher_profile_id_foreign` FOREIGN KEY (`teacher_profile_id`) REFERENCES `teacher_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `teacher_documents`
--
ALTER TABLE `teacher_documents`
  ADD CONSTRAINT `teacher_documents_teacher_profile_id_foreign` FOREIGN KEY (`teacher_profile_id`) REFERENCES `teacher_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `teacher_educations`
--
ALTER TABLE `teacher_educations`
  ADD CONSTRAINT `teacher_educations_teacher_profile_id_foreign` FOREIGN KEY (`teacher_profile_id`) REFERENCES `teacher_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `teacher_experiences`
--
ALTER TABLE `teacher_experiences`
  ADD CONSTRAINT `teacher_experiences_teacher_profile_id_foreign` FOREIGN KEY (`teacher_profile_id`) REFERENCES `teacher_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `teacher_languages`
--
ALTER TABLE `teacher_languages`
  ADD CONSTRAINT `teacher_languages_teacher_profile_id_foreign` FOREIGN KEY (`teacher_profile_id`) REFERENCES `teacher_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `teacher_profiles`
--
ALTER TABLE `teacher_profiles`
  ADD CONSTRAINT `teacher_profiles_approved_by_foreign` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `teacher_profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `teacher_social_links`
--
ALTER TABLE `teacher_social_links`
  ADD CONSTRAINT `teacher_social_links_teacher_profile_id_foreign` FOREIGN KEY (`teacher_profile_id`) REFERENCES `teacher_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `teacher_subjects`
--
ALTER TABLE `teacher_subjects`
  ADD CONSTRAINT `teacher_subjects_teacher_profile_id_foreign` FOREIGN KEY (`teacher_profile_id`) REFERENCES `teacher_profiles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
