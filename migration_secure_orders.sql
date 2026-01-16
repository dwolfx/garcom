-- 1. Add metadata column for flexibility (storing parts IDs)
ALTER TABLE orders ADD COLUMN IF NOT EXISTS metadata JSONB DEFAULT '{}';

-- 2. Create Function to Securely Calculate Price
CREATE OR REPLACE FUNCTION secure_composite_price()
RETURNS TRIGGER AS $$
DECLARE
    p1_price NUMERIC;
    p2_price NUMERIC;
    part_ids JSONB;
BEGIN
    -- Check if it is a Half-Half Order
    IF NEW.metadata @> '{"type": "half_half"}' THEN
        part_ids := NEW.metadata->'parts';
        
        -- Fetch Real Prices from DB (Trust No Client!)
        SELECT price INTO p1_price FROM products WHERE id = (part_ids->>0)::BIGINT;
        SELECT price INTO p2_price FROM products WHERE id = (part_ids->>1)::BIGINT;
        
        -- Apply Business Rule: GREATEST (Max Price)
        NEW.price := GREATEST(COALESCE(p1_price, 0), COALESCE(p2_price, 0));
        
        -- Logic: If any ID was invalid (price null), logging or fallback logic could go here.
        -- Current logic treats invalid ID as price 0.
        
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 3. Attach Trigger
DROP TRIGGER IF EXISTS trg_secure_composite_price ON orders;
CREATE TRIGGER trg_secure_composite_price
BEFORE INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION secure_composite_price();
