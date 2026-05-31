-- ============================================================================
--  003_types.sql — ALL ENUM TYPES (CONSOLIDATED)
--  Purpose : Single source of truth for every ENUM type in the system.
--            Organized by domain with clear documentation.
--  Depends : 002_extensions.sql
-- ============================================================================

-- ══════════════════════════════════════════════════════════════════════════════
-- IDENTITY & ACCESS
-- ══════════════════════════════════════════════════════════════════════════════

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'user_role') THEN
    CREATE TYPE public.user_role AS ENUM (
      -- University leadership
      'rector', 'dean', 'department_head', 'assistant_hod', 'academic_coordinator',
      -- Faculty
      'professor', 'lecturer', 'teaching_assistant',
      -- Staff
      'registrar_officer', 'academic_advisor', 'librarian',
      -- Students
      'freshman', 'regular_student', 'student', 'class_representative', 'alumni',
      -- Operations
      'dorm_supervisor', 'security_officer',
      -- External
      'guest', 'parent', 'recruiter'
    );
  END IF;
END $$;

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'session_device') THEN
    CREATE TYPE public.session_device AS ENUM ('mobile', 'desktop', 'tablet', 'unknown');
  END IF;
END $$;

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'audit_action') THEN
    CREATE TYPE public.audit_action AS ENUM (
      'create', 'update', 'delete', 'login', 'logout',
      'toggle_status', 'role_change', 'password_reset', 'view',
      'export', 'import', 'approve', 'reject'
    );
  END IF;
END $$;

-- ══════════════════════════════════════════════════════════════════════════════
-- CONTENT & COMMUNICATION
-- ══════════════════════════════════════════════════════════════════════════════

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'post_type') THEN
    CREATE TYPE public.post_type AS ENUM ('text', 'image', 'video', 'link', 'announcement');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'announcement_priority') THEN
    CREATE TYPE public.announcement_priority AS ENUM ('normal', 'important', 'urgent');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'forum_category') THEN
    CREATE TYPE public.forum_category AS ENUM ('general', 'academic', 'social', 'feedback');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'notification_type') THEN
    CREATE TYPE public.notification_type AS ENUM ('info', 'warning', 'success', 'error');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'file_type') THEN
    CREATE TYPE public.file_type AS ENUM ('pdf', 'docx', 'pptx', 'xlsx', 'image', 'video', 'other');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'message_status') THEN
    CREATE TYPE public.message_status AS ENUM ('sent', 'delivered', 'read', 'deleted');
  END IF;
END $$;

-- ══════════════════════════════════════════════════════════════════════════════
-- ACADEMIC WORKFLOW
-- ══════════════════════════════════════════════════════════════════════════════

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'enrollment_status') THEN
    CREATE TYPE public.enrollment_status AS ENUM ('pending', 'approved', 'rejected', 'withdrawn', 'cancelled');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'attendance_status') THEN
    CREATE TYPE public.attendance_status AS ENUM ('present', 'absent', 'late', 'excused');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'day_of_week') THEN
    CREATE TYPE public.day_of_week AS ENUM ('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday');
  END IF;
END $$;

-- ══════════════════════════════════════════════════════════════════════════════
-- EXAMINATIONS
-- ══════════════════════════════════════════════════════════════════════════════

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'exam_status') THEN
    CREATE TYPE public.exam_status AS ENUM ('draft', 'published', 'in_progress', 'completed', 'cancelled');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'question_type') THEN
    CREATE TYPE public.question_type AS ENUM ('mcq', 'true_false', 'short_answer', 'essay', 'file_upload');
  END IF;
END $$;

-- ══════════════════════════════════════════════════════════════════════════════
-- LIBRARY
-- ══════════════════════════════════════════════════════════════════════════════

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'library_item_type') THEN
    CREATE TYPE public.library_item_type AS ENUM ('book', 'journal', 'thesis', 'research_paper', 'e_resource', 'video');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'borrow_status') THEN
    CREATE TYPE public.borrow_status AS ENUM ('reserved', 'borrowed', 'returned', 'overdue', 'lost');
  END IF;
END $$;

-- ══════════════════════════════════════════════════════════════════════════════
-- FINANCIAL
-- ══════════════════════════════════════════════════════════════════════════════

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'payment_status') THEN
    CREATE TYPE public.payment_status AS ENUM ('pending', 'paid', 'overdue', 'refunded');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'payment_method') THEN
    CREATE TYPE public.payment_method AS ENUM ('cash', 'card', 'bank_transfer', 'paymob', 'stripe', 'wallet');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'payment_gateway_type') THEN
    CREATE TYPE public.payment_gateway_type AS ENUM ('paymob', 'stripe', 'cash', 'bank_transfer', 'wallet');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'scholarship_status') THEN
    CREATE TYPE public.scholarship_status AS ENUM ('open', 'applied', 'under_review', 'awarded', 'rejected', 'expired');
  END IF;
END $$;

-- ══════════════════════════════════════════════════════════════════════════════
-- SUPPORT & OPERATIONS
-- ══════════════════════════════════════════════════════════════════════════════

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'support_ticket_status') THEN
    CREATE TYPE public.support_ticket_status AS ENUM ('open', 'in_progress', 'resolved', 'closed');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'sync_status') THEN
    CREATE TYPE public.sync_status AS ENUM ('pending', 'synced', 'failed', 'skipped', 'retry');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'virtual_class_status') THEN
    CREATE TYPE public.virtual_class_status AS ENUM ('scheduled', 'live', 'ended', 'cancelled');
  END IF;
END $$;

-- ══════════════════════════════════════════════════════════════════════════════
-- NOTIFICATIONS (MULTI-CHANNEL)
-- ══════════════════════════════════════════════════════════════════════════════

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'notif_channel') THEN
    CREATE TYPE public.notif_channel AS ENUM ('in_app', 'email', 'sms', 'push');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'notif_delivery_status') THEN
    CREATE TYPE public.notif_delivery_status AS ENUM ('pending', 'sent', 'delivered', 'failed', 'bounced');
  END IF;
END $$;

-- ══════════════════════════════════════════════════════════════════════════════
-- AI & ANALYTICS
-- ══════════════════════════════════════════════════════════════════════════════

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'ai_model_type') THEN
    CREATE TYPE public.ai_model_type AS ENUM ('gpa_predictor', 'cheat_detector', 'course_recommender', 'dropout_risk', 'grade_forecast');
  END IF;
END $$;

-- ══════════════════════════════════════════════════════════════════════════════
-- SECURITY & ENCRYPTION
-- ══════════════════════════════════════════════════════════════════════════════

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'encryption_context') THEN
    CREATE TYPE public.encryption_context AS ENUM ('national_id', 'bank_account', 'medical', 'grade', 'financial');
  END IF;
END $$;

-- ════════════════════════════════════════════════════════════════════════════
-- ROLLBACK:
-- DROP TYPE IF EXISTS public.encryption_context CASCADE;
-- DROP TYPE IF EXISTS public.ai_model_type CASCADE;
-- DROP TYPE IF EXISTS public.notif_delivery_status CASCADE;
-- DROP TYPE IF EXISTS public.notif_channel CASCADE;
-- DROP TYPE IF EXISTS public.virtual_class_status CASCADE;
-- DROP TYPE IF EXISTS public.sync_status CASCADE;
-- DROP TYPE IF EXISTS public.support_ticket_status CASCADE;
-- DROP TYPE IF EXISTS public.scholarship_status CASCADE;
-- DROP TYPE IF EXISTS public.payment_gateway_type CASCADE;
-- DROP TYPE IF EXISTS public.payment_method CASCADE;
-- DROP TYPE IF EXISTS public.payment_status CASCADE;
-- DROP TYPE IF EXISTS public.borrow_status CASCADE;
-- DROP TYPE IF EXISTS public.library_item_type CASCADE;
-- DROP TYPE IF EXISTS public.question_type CASCADE;
-- DROP TYPE IF EXISTS public.exam_status CASCADE;
-- DROP TYPE IF EXISTS public.day_of_week CASCADE;
-- DROP TYPE IF EXISTS public.attendance_status CASCADE;
-- DROP TYPE IF EXISTS public.enrollment_status CASCADE;
-- DROP TYPE IF EXISTS public.message_status CASCADE;
-- DROP TYPE IF EXISTS public.file_type CASCADE;
-- DROP TYPE IF EXISTS public.notification_type CASCADE;
-- DROP TYPE IF EXISTS public.forum_category CASCADE;
-- DROP TYPE IF EXISTS public.announcement_priority CASCADE;
-- DROP TYPE IF EXISTS public.post_type CASCADE;
-- DROP TYPE IF EXISTS public.audit_action CASCADE;
-- DROP TYPE IF EXISTS public.session_device CASCADE;
-- DROP TYPE IF EXISTS public.user_role CASCADE;
-- ════════════════════════════════════════════════════════════════════════════
