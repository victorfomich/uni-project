-- Run once in Supabase SQL Editor (https://supabase.com/dashboard)

-- 1. Add photo column to students table
ALTER TABLE students ADD COLUMN IF NOT EXISTS photo_url TEXT;

-- 2. Create public storage bucket for student photos
INSERT INTO storage.buckets (id, name, public)
VALUES ('student-photos', 'student-photos', true)
ON CONFLICT (id) DO UPDATE SET public = true;

-- 3. Allow public read and upload (anon key)
CREATE POLICY "Public read student photos"
ON storage.objects FOR SELECT
USING (bucket_id = 'student-photos');

CREATE POLICY "Public upload student photos"
ON storage.objects FOR INSERT
WITH CHECK (bucket_id = 'student-photos');

CREATE POLICY "Public update student photos"
ON storage.objects FOR UPDATE
USING (bucket_id = 'student-photos');

CREATE POLICY "Public delete student photos"
ON storage.objects FOR DELETE
USING (bucket_id = 'student-photos');
