-- LIMPEZA (Cuidado: Apaga tudo para reconstruir o cenário de teste)
TRUNCATE orders, tables, products, users, establishments, suppliers, payments RESTART IDENTITY CASCADE;

-- 1. Estabelecimentos
INSERT INTO establishments (name, plan, status, revenue, theme_color) VALUES
('Pizzaria Imperio', 'Enterprise', 'Active', 3500.00, '#ef4444');

-- 2. Cardápio (Pizzaria)
INSERT INTO products (name, price, category, description, image) VALUES
-- Pizzas
('Pizza Calabresa', 45.00, 'Pizzas', 'Calabresa fatiada, cebola e azeitonas', '🍕'),
('Pizza Marguerita', 42.00, 'Pizzas', 'Molho, mussarela, tomate e manjericão', '🍕'),
('Pizza Portuguesa', 48.00, 'Pizzas', 'Presunto, ovos, cebola, ervilha e mussarela', '🍕'),
('Pizza Quatro Queijos', 50.00, 'Pizzas', 'Mussarela, provolone, parmesão e gorgonzola', '🍕'),

-- Bebidas
('Coca-Cola 2L', 14.00, 'Bebidas', 'Garrafa 2 Litros', '🥤'),
('Guaraná Antarctica 2L', 12.00, 'Bebidas', 'Garrafa 2 Litros', '🥤'),
('Suco de Laranja', 15.00, 'Bebidas', 'Jarra 1 Litro', '🍊'),
('Cerveja Heineken 600ml', 18.00, 'Bebidas', 'Garrafa 600ml', '🍺');

-- 3. Usuários (Com IDs UUID explícitos)
INSERT INTO users (id, name, email, password, role, establishment_id, pin) VALUES
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Admin Imperio', 'admin@imperio.com', '123', 'owner', 1, NULL),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b22', 'Garçom Luigi', NULL, NULL, 'waiter', 1, '1234'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c33', 'Cliente App', 'cliente@example.com', '123', 'client', 1, NULL);

-- 4. Mesas
INSERT INTO tables (number, status, call_waiter, establishment_id) VALUES
(1, 'occupied', FALSE, 1),
(2, 'available', FALSE, 1),
(3, 'occupied', TRUE, 1),
(4, 'available', FALSE, 1),
(5, 'occupied', FALSE, 1),
(6, 'available', FALSE, 1);

-- 5. Fornecedores (Novos Dados)
INSERT INTO suppliers (name, category, contact, phone, email, establishment_id) VALUES
('Atacadão das Farinhas', 'Alimentos', 'Roberto', '(11) 99999-1234', 'vendas@farinhas.com', 1),
('Laticínios da Serra', 'Alimentos', 'Mariana', '(11) 98888-5678', 'mariana@laticinios.com', 1),
('Distribuidora Bebidas Center', 'Bebidas', 'Carlos', '(11) 97777-9999', 'pedidos@centerbebidas.com', 1);

-- 6. Pedidos Atuais (Usando UUIDs reais!)
INSERT INTO orders (table_id, product_id, name, price, quantity, status, ordered_by) VALUES
-- Mesa 1 (Atendido pelo Luigi)
(1, 1, 'Pizza Calabresa', 45.00, 1, 'delivered', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b22'),
(1, 5, 'Coca-Cola 2L', 14.00, 1, 'delivered', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b22'),

-- Mesa 3 (Cliente pediu pelo App)
(3, 4, 'Pizza Quatro Queijos', 50.00, 1, 'pending', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c33');

-- 7. Histórico de Vendas (Mock para Saída de Caixa)
INSERT INTO payments (table_id, amount, method, establishment_id, created_at) VALUES
(1, 89.00, 'PIX', 1, NOW() - INTERVAL '2 hours'),
(2, 120.50, 'Cartão', 1, NOW() - INTERVAL '3 hours'),
(5, 45.00, 'Dinheiro', 1, NOW() - INTERVAL '4 hours');

