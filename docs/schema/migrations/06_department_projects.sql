-- Create Department Projects Table
CREATE TABLE IF NOT EXISTS public.department_projects (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    department_id UUID NOT NULL REFERENCES public.departments(id) ON DELETE CASCADE,
    title_en TEXT NOT NULL,
    title_ar TEXT NOT NULL,
    description_en TEXT,
    description_ar TEXT,
    status TEXT NOT NULL DEFAULT 'active', -- active, completed, planned
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- RLS Policies
ALTER TABLE public.department_projects ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Projects are viewable by everyone."
    ON public.department_projects FOR SELECT
    USING (true);

CREATE POLICY "Users with academic leadership or admin roles can manage projects."
    ON public.department_projects FOR ALL
    USING (
        EXISTS (
            SELECT 1 FROM public.appointments a
            WHERE a.user_id = auth.uid()
            AND a.is_active = true
            AND (
                a.role = 'admin' OR 
                a.role = 'dean' OR 
                a.role = 'head_of_department'
            )
        )
    );

-- Trigger for updated_at (optional if using universal trigger)

-- Seed some mock projects for the departments
INSERT INTO public.department_projects (department_id, title_en, title_ar, description_en, description_ar, status)
SELECT 
    d.id, 
    'Project Alpha for ' || d.name, 
    'المشروع الأول ل' || d.name_ar,
    'This is a sample project aimed at improving the AI capabilities of the ' || d.name || ' department.',
    'هذا مشروع تجريبي يهدف إلى تحسين قدرات الذكاء الاصطناعي في ' || d.name_ar,
    'active'
FROM public.departments d
ON CONFLICT DO NOTHING;

INSERT INTO public.department_projects (department_id, title_en, title_ar, description_en, description_ar, status)
SELECT 
    d.id, 
    'Research Grant Beta', 
    'منحة بحثية تجريبية',
    'A funded research project to explore cutting-edge technologies relevant to ' || d.name,
    'مشروع بحث ممول لاستكشاف أحدث التقنيات ذات الصلة بـ ' || d.name_ar,
    'planned'
FROM public.departments d
ON CONFLICT DO NOTHING;
