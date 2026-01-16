-- FIX SCRIPT: Add missing 'ordered_by' column to orders table

-- 1. Add column if it doesn't exist
ALTER TABLE orders ADD COLUMN IF NOT EXISTS ordered_by UUID;

-- 2. (Optional) Copy data from old columns if they exist (Data Migration)
-- DO allows running block in Postgres, but simple UPDATE is safer for broad support
-- We try to preserve data if you had some orders under 'ordered_by_customer_id'
DO $$
BEGIN
    IF EXISTS(SELECT 1 FROM information_schema.columns WHERE table_name='orders' AND column_name='ordered_by_customer_id') THEN
        UPDATE orders SET ordered_by = ordered_by_customer_id WHERE ordered_by IS NULL;
    END IF;
END $$;

-- 3. Apply the SECURITY POLICIES (Now that column exists)
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;

-- Reset Policies for Orders
DROP POLICY IF EXISTS "Auth users view orders" ON orders;
DROP POLICY IF EXISTS "Auth users create orders" ON orders;
DROP POLICY IF EXISTS "Users update own orders" ON orders;

CREATE POLICY "Auth users view orders" ON orders FOR SELECT TO authenticated USING (true);
CREATE POLICY "Auth users create orders" ON orders FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Users update own orders" ON orders FOR UPDATE USING (auth.uid() = ordered_by);

-- Apply other table policies (Tables, Products) just in case
ALTER TABLE tables ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Public view tables" ON tables;
DROP POLICY IF EXISTS "Auth update tables" ON tables;
CREATE POLICY "Public view tables" ON tables FOR SELECT USING (true);
CREATE POLICY "Auth update tables" ON tables FOR UPDATE TO authenticated USING (true);

ALTER TABLE products ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Public view products" ON products;
CREATE POLICY "Public view products" ON products FOR SELECT USING (true);
