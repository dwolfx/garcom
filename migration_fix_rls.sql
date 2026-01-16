-- Enable RLS on users table if not enabled
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Drop existing policies to avoid conflicts
DROP POLICY IF EXISTS "Users can update own profile" ON users;
DROP POLICY IF EXISTS "Users can view own profile" ON users;

-- Create policy to allow users to update their own row
CREATE POLICY "Users can update own profile"
ON users
FOR UPDATE
USING (auth.uid() = id);

-- Create policy to allow users to view their own profile (and public info if needed)
CREATE POLICY "Users can view own profile"
ON users
FOR SELECT
USING (auth.uid() = id);
