-- Unify products to Establishment ID 1 (Pizzaria Imperio)
UPDATE products 
SET establishment_id = 1 
WHERE establishment_id = 2;

-- Check (User can run this query to verify)
-- SELECT * FROM products WHERE establishment_id = 1;
