-- LIMPEZA (Cuidado: Apaga tudo para reconstruir o cenário de teste)
TRUNCATE orders, tables, products, users, establishments RESTART IDENTITY CASCADE;

-- 1. Estabelecimentos
INSERT INTO establishments (name, plan, status, revenue) VALUES
('Bar do Zé (Demo)', 'Pro', 'Active', 1250.00),
('Balada Neon', 'Enterprise', 'Active', 15800.00);

-- 2. Cardápio (Produtos)
INSERT INTO products (name, price, category, description, image) VALUES
-- Cervejas
('Heineken 600ml', 18.00, 'Cervejas', 'Garrafa 600ml gelada', '🍺'),
('Stella Artois', 16.00, 'Cervejas', 'Long neck 330ml', '🍺'),
('Original 600ml', 14.00, 'Cervejas', 'Garrafa 600ml', '🍺'),
('Balde Corona (6un)', 80.00, 'Cervejas', 'Com gelo e limão', '🧊'),

-- Drinks
('Caipirinha Limão', 25.00, 'Drinks', 'Cachaça artesanal, açúcar e gelo', '🍋'),
('Gin Tônica', 32.00, 'Drinks', 'Tanqueray, tônica e especiarias', '🍸'),
('Moscow Mule', 35.00, 'Drinks', 'Vodka, espuma de gengibre e limão', '🍺'),
('Whisky Sour', 30.00, 'Drinks', 'Bourbon e limão', '🥃'),

-- Comidas
('Batata Frita c/ Cheddar', 28.00, 'Petiscos', 'Batata crinkle com muito cheddar e bacon', '🍟'),
('Isca de Frango', 35.00, 'Petiscos', 'Acompanha molho tártaro', '🍗'),
('Dadinho de Tapioca', 24.00, 'Petiscos', 'Com geleia de pimenta', '🧀'),
('Hambúrguer da Casa', 38.00, 'Lanches', 'Blend 180g, queijo, salada e maionese', '🍔');

-- 3. Usuários
INSERT INTO users (name, email, password, role, establishment_id, pin) VALUES
('Super Admin', 'admin@consagrado.com', '123', 'super', NULL, NULL),
('Dono do Bar', 'owner@teste.com', '123', 'owner', 1, NULL),
('Garçom Teste', NULL, NULL, 'waiter', 1, '1234');

-- 4. Mesas (Cenário Realista)
INSERT INTO tables (number, status, call_waiter, establishment_id) VALUES
(1, 'occupied', FALSE, 1), -- Mesa com gente bebendo
(2, 'occupied', TRUE, 1),  -- Mesa chamando o garçom!
(3, 'available', FALSE, 1),
(4, 'available', FALSE, 1),
(5, 'occupied', FALSE, 1),
(6, 'available', FALSE, 1),
(7, 'available', FALSE, 1),
(8, 'available', FALSE, 1);

-- 5. Pedidos (Para popular os gráficos e as mesas ocupadas)
INSERT INTO orders (table_id, product_id, name, price, quantity, status, ordered_by) VALUES
-- Mesa 1 (Bebendo de boa)
(1, 1, 'Heineken 600ml', 36.00, 2, 'delivered', 'Garçom Teste'),
(1, 9, 'Batata Frita c/ Cheddar', 28.00, 1, 'delivered', 'Cliente App'),

-- Mesa 2 (Chamando Garçom + Pedido alto)
(2, 6, 'Gin Tônica', 64.00, 2, 'delivered', 'Cliente App'),
(2, 7, 'Moscow Mule', 35.00, 1, 'pending', 'Cliente App'),

-- Mesa 5 (Turma grande)
(5, 4, 'Balde Corona (6un)', 80.00, 1, 'delivered', 'Garçom Teste'),
(5, 4, 'Balde Corona (6un)', 80.00, 1, 'pending', 'Garçom Teste'),
(5, 10, 'Isca de Frango', 35.00, 1, 'delivered', 'Garçom Teste');
