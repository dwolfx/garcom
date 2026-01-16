-- SEED V2 - DADOS REAIS E MULTI-LOJA
TRUNCATE payments, orders, suppliers, tables, products, establishment_staff, establishments, b2b_users, b2c_users RESTART IDENTITY CASCADE;

-- 1. Usuários B2B (Staff & Owners)
INSERT INTO b2b_users (id, name, email, password_hash) VALUES
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Admin Imperio', 'admin@imperio.com', '123'), -- Dono
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b22', 'Garçom Luigi', NULL, NULL);                    -- Funcionário (sem email, só pin)

-- 2. Usuários B2C (Clientes Finais)
INSERT INTO b2c_users (id, name, email, phone) VALUES
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c33', 'Cliente Beta', 'user@beta.com', '11999999999'),
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d44', 'Amiga Beta', 'amiga@beta.com', '11988888888');

-- 3. Estabelecimentos (O Dono tem 2)
INSERT INTO establishments (id, name, owner_id, theme_color, theme_secondary_color, settings) VALUES
(1, 'Pizzaria Imperio', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', '#b91c1c', '#f59e0b', '{"tabs_order": ["Pizzas Tradicionais", "Pizzas Especiais", "Pizzas Doces", "Bebidas", "Pastéis"]}'),
(2, 'Hamburgueria do Admin', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', '#f59e0b', '#ef4444', '{"tabs_order": ["Lanches", "Beirutes", "Bebidas"]}');

-- 4. Vínculo de Staff (Luigi trabalha na Pizzaria)
INSERT INTO establishment_staff (establishment_id, user_id, role, access_pin) VALUES
(1, 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b22', 'waiter', '1234');

-- 5. Produtos (Cardápio Real Pizzaria Imperio)
INSERT INTO products (establishment_id, name, price, category, description, image) VALUES
-- Pizzas Tradicionais
(1, 'Mussarela', 40.00, 'Pizzas Tradicionais', 'Mussarela e tomate', 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500'),
(1, 'Calabresa', 40.00, 'Pizzas Tradicionais', 'Calabresa fatiada e cebola', 'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=500'),
(1, 'Portuguesa', 45.00, 'Pizzas Tradicionais', 'Presunto, ovos, cebola e mussarela', 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=500'),
(1, 'Marguerita', 42.00, 'Pizzas Tradicionais', 'Mussarela, manjericão e tomate', 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=500'),
(1, 'Frango com Catupiry', 45.00, 'Pizzas Tradicionais', 'Frango desfiado e catupiry original', 'https://images.unsplash.com/photo-1593560706886-1666f658393e?w=500'),
(1, 'Quatro Queijos', 48.00, 'Pizzas Tradicionais', 'Mussarela, provolone, catupiry e parmesão', 'https://images.unsplash.com/photo-1573821663912-569905455b1c?w=500'),
(1, 'Bacon', 45.00, 'Pizzas Tradicionais', 'Mussarela e bacon crocante', 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500'),
(1, 'Baiana', 42.00, 'Pizzas Tradicionais', 'Calabresa moída, ovos e pimenta', 'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=500'),

-- Pizzas Especiais / Novidades
(1, 'Costela Barbecue', 55.00, 'Pizzas Especiais', 'Costela desfiada, molho barbecue e mussarela', 'https://images.unsplash.com/photo-1544982503-9f984c14501a?w=500'),
(1, 'Doritos', 50.00, 'Pizzas Especiais', 'Mussarela, carne moída e Doritos', 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=500'),
(1, 'Philadelphia', 55.00, 'Pizzas Especiais', 'Peito de peru, cream cheese e bacon', 'https://images.unsplash.com/photo-1594007654729-407eedc4be65?w=500'),
(1, 'Camarão', 60.00, 'Pizzas Especiais', 'Camarão temperado, cebola e catupiry', 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=500'),

-- Pizzas Doces
(1, 'Banana com Canela', 35.00, 'Pizzas Doces', 'Banana, leite condensado e canela', 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=500'),
(1, 'Brigadeiro', 38.00, 'Pizzas Doces', 'Chocolate ao leite e granulado', 'https://images.unsplash.com/photo-1606313564200-e75d5e30476d?w=500'),
(1, 'Romeu e Julieta', 38.00, 'Pizzas Doces', 'Goiabada e mussarela', 'https://images.unsplash.com/photo-1593560706886-1666f658393e?w=500'),
(1, 'Prestígio', 40.00, 'Pizzas Doces', 'Chocolate e coco ralado', 'https://images.unsplash.com/photo-1606313564200-e75d5e30476d?w=500'),

-- Lanches e Beirutes
(2, 'X-Salada', 22.00, 'Lanches', 'Hambúrguer, queijo, alface, tomate e maionese', 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500'),
(2, 'X-Bacon', 26.00, 'Lanches', 'Hambúrguer, queijo, bacon e salada', 'https://images.unsplash.com/photo-1594212699903-ec8a3eca50f5?w=500'),
(2, 'X-Tudo', 32.00, 'Lanches', 'Hambúrguer, bacon, ovo, presunto, queijo e salada', 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500'),
(2, 'Beirute de Picanha', 45.00, 'Beirutes', 'Picanha fatiada, queijo, ovo e salada no pão sírio', 'https://images.unsplash.com/photo-1626082927389-d31c6d24a2dc?w=500'),

-- Bebidas
(1, 'Coca-Cola 2L', 16.00, 'Bebidas', 'Garrafa', 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=500'),
(1, 'Guaraná Antarctica 2L', 14.00, 'Bebidas', 'Garrafa', 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=500'),
(1, 'Suco Natural Laranja', 12.00, 'Bebidas', 'Jarra 500ml', 'https://images.unsplash.com/photo-1600271886742-f049cd451bba?w=500'),
(1, 'Cerveja Heineken 600ml', 18.00, 'Bebidas', 'Garrafa', 'https://images.unsplash.com/photo-1608270586620-248524c67de9?w=500'),

-- Pastéis
(1, 'Pastel de Carne', 10.00, 'Pastéis', 'Carne moída temperada', 'https://images.unsplash.com/photo-1541592103048-4e364e9e05ac?w=500'),
(1, 'Pastel de Queijo', 10.00, 'Pastéis', 'Muito queijo derretido', 'https://images.unsplash.com/photo-1541592103048-4e364e9e05ac?w=500'),
(1, 'Pastel de Pizza', 10.00, 'Pastéis', 'Presunto, queijo e orégano', 'https://images.unsplash.com/photo-1541592103048-4e364e9e05ac?w=500');

-- 6. Mesas (Pizzaria)
INSERT INTO tables (establishment_id, number, code, status) VALUES
(1, 1, 'IM0001', 'occupied'),
(1, 2, 'IM0002', 'available'),
(1, 3, 'IM0003', 'occupied'); -- Mesa ocupada

-- 7. Fornecedores (Pizzaria)
INSERT INTO suppliers (establishment_id, name, category, contact) VALUES
(1, 'Fornecedor de Queijo', 'Alimentos', 'Sr. Queijo');

-- 8. Pedidos (Cenário Misto)
INSERT INTO orders (establishment_id, table_id, product_id, name, price, status, ordered_by_staff_id, author_name) VALUES
-- Pedido feito pelo Garçom Luigi na Mesa 1
(1, 1, 1, 'Pizza Calabresa', 45.00, 'delivered', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b22', 'Garçom Luigi');

INSERT INTO orders (establishment_id, table_id, product_id, name, price, status, ordered_by_customer_id, author_name) VALUES
-- Pedido feito pelo Cliente Beta na Mesa 3
(1, 3, 2, 'Pizza 4 Queijos', 50.00, 'pending', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c33', 'Cliente Beta');
