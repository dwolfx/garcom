-- Migration: Add theme_background_color to establishments
-- Run this in your Supabase SQL Editor

ALTER TABLE public.establishments 
ADD COLUMN IF NOT EXISTS theme_background_color TEXT DEFAULT '#09090b';

-- Reload schema cache to make it visible to the API
NOTIFY pgrst, 'reload schema';
