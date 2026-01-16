-- Migration Fix for V2 Schema
-- Run this in your Supabase SQL Editor to patch the database

-- 1. Add theme_secondary_color to establishments
ALTER TABLE public.establishments 
ADD COLUMN IF NOT EXISTS theme_secondary_color TEXT DEFAULT '#f59e0b';

-- 2. Add code to tables
ALTER TABLE public.tables 
ADD COLUMN IF NOT EXISTS code TEXT;

-- 3. Add unique constraint for table codes
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'tables_establishment_id_code_key') THEN
        ALTER TABLE public.tables ADD CONSTRAINT tables_establishment_id_code_key UNIQUE (establishment_id, code);
    END IF;
END $$;

-- 4. Reload PostgREST schema cache (Crucial for the API to see new columns)
NOTIFY pgrst, 'reload schema';
