-- COMPREHENSIVE FIX: Add ALL missing columns to 'orders' found in Javascript API
-- This resolves the "400 Bad Request" errors caused by Schema Mismatch.

-- 1. Identity Column (The App uses 'ordered_by', Schema had 'ordered_by_customer_id')
ALTER TABLE orders ADD COLUMN IF NOT EXISTS ordered_by UUID;

-- 2. Split Logic Columns (Used by split modal and API)
-- These were missing from the initial schema but are required by the Code.
ALTER TABLE orders ADD COLUMN IF NOT EXISTS is_split BOOLEAN DEFAULT FALSE;
ALTER TABLE orders ADD COLUMN IF NOT EXISTS split_parts INT DEFAULT 1;
ALTER TABLE orders ADD COLUMN IF NOT EXISTS original_price NUMERIC;
ALTER TABLE orders ADD COLUMN IF NOT EXISTS split_requester UUID;
ALTER TABLE orders ADD COLUMN IF NOT EXISTS split_participants JSONB;

-- 3. Data Migration (Best Effort)
-- If we have data in the specific 'customer' column, move it to the generic 'ordered_by' used by the App
DO $$
BEGIN
    IF EXISTS(SELECT 1 FROM information_schema.columns WHERE table_name='orders' AND column_name='ordered_by_customer_id') THEN
        UPDATE orders SET ordered_by = ordered_by_customer_id WHERE ordered_by IS NULL;
    END IF;
END $$;

-- 4. Security Policies (Re-apply to ensure new columns are covered/accessible)
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;

-- Clean slate for policies
DROP POLICY IF EXISTS "Auth users view orders" ON orders;
DROP POLICY IF EXISTS "Auth users create orders" ON orders;
DROP POLICY IF EXISTS "Users update own orders" ON orders;

-- Allow any authenticated user to VIEW orders (needed for "Comanda" and "Split" visibility)
CREATE POLICY "Auth users view orders" ON orders FOR SELECT TO authenticated USING (true);

-- Allow creating orders (includes filling these new columns)
CREATE POLICY "Auth users create orders" ON orders FOR INSERT TO authenticated WITH CHECK (true);

-- Allow updating own orders (for payments/edits)
CREATE POLICY "Users update own orders" ON orders FOR UPDATE USING (auth.uid() = ordered_by);

-- 5. Public Access for Catalog (Ensure Menu works)
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Public view products" ON products;
CREATE POLICY "Public view products" ON products FOR SELECT USING (true);
