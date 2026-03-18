-- حذف المخطط العام وجميع الجداول والبيانات التي بداخله
DROP SCHEMA public CASCADE;

-- إعادة إنشاء المخطط العام ليكون فارغاً وجاهزاً
CREATE SCHEMA public;

-- إعادة إعطاء الصلاحيات الأساسية للمخطط الجديد
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO anon;
GRANT ALL ON SCHEMA public TO authenticated;
GRANT ALL ON SCHEMA public TO service_role;