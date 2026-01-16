-- Migration: RESTORE 'users' Table, Add Fields (CPF, Passport, Country), and Fix Permissions

DO $$
BEGIN
    -- 1. If b2c_users exists but users does not, rename it
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'b2c_users') 
       AND NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'users') THEN
        ALTER TABLE public.b2c_users RENAME TO users;
    END IF;
END $$;

-- 2. Create users table if it still doesn't exist
CREATE TABLE IF NOT EXISTS public.users (
    id UUID PRIMARY KEY REFERENCES auth.users(id),
    name TEXT,
    email TEXT,
    phone TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- 3. Add necessary columns
ALTER TABLE public.users 
ADD COLUMN IF NOT EXISTS avatar TEXT,
ADD COLUMN IF NOT EXISTS role TEXT DEFAULT 'customer',
ADD COLUMN IF NOT EXISTS settings JSONB DEFAULT '{}',
ADD COLUMN IF NOT EXISTS country TEXT DEFAULT 'BR',  -- 'BR' or others
ADD COLUMN IF NOT EXISTS cpf TEXT,                   -- Used if country == 'BR'
ADD COLUMN IF NOT EXISTS passport TEXT;              -- Used if country != 'BR'

-- 4. FIX PERMISSIONS (RLS)
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Public profiles are viewable by everyone" ON public.users;
CREATE POLICY "Public profiles are viewable by everyone" 
ON public.users FOR SELECT 
USING (true);

DROP POLICY IF EXISTS "Users can update own profile" ON public.users;
CREATE POLICY "Users can update own profile" 
ON public.users FOR UPDATE 
USING (auth.uid() = id);

DROP POLICY IF EXISTS "Users can insert own profile" ON public.users;
CREATE POLICY "Users can insert own profile" 
ON public.users FOR INSERT 
WITH CHECK (auth.uid() = id);

-- 5. Reload PostgREST schema
NOTIFY pgrst, 'reload schema';
