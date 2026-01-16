-- Update Establishment 1 to have a custom Category Order
-- We move "Petiscos" (Appetizers) to the front, followed by "Pizzas" (if exists) and "Drinks".
UPDATE establishments
SET settings = jsonb_set(
    COALESCE(settings, '{}'),
    '{category_order}',
    '["Petiscos", "Pizzas", "Lanches", "Cervejas", "Drinks", "Pratos", "Sobremesas", "Sem Álcool"]'
)
WHERE id = 1;

-- Verify
SELECT settings FROM establishments WHERE id = 1;
