-- Migração para Suporte a Metadados de Divisão (Split)

-- 1. Adicionar colunas de rastreio básico
ALTER TABLE orders 
ADD COLUMN IF NOT EXISTS is_split BOOLEAN DEFAULT FALSE,
ADD COLUMN IF NOT EXISTS split_parts INT DEFAULT 1,
ADD COLUMN IF NOT EXISTS original_price NUMERIC;

-- 2. Adicionar colunas de rastreio de participantes (Solicitação do Usuário)
-- Armazena quem pediu a divisão original
ALTER TABLE orders 
ADD COLUMN IF NOT EXISTS split_requester TEXT; 

-- Armazena o array de IDs de todos que estão dividindo esse item específico
-- Ex: ['uuid-user-1', 'uuid-user-2']
ALTER TABLE orders 
ADD COLUMN IF NOT EXISTS split_participants TEXT[];

-- Comentário explicativo:
-- Se is_split = TRUE:
--   price = Valor Fracionado (Pago por este usuário)
--   original_price = Valor Cheio do Produto
--   split_parts = Número de fatias (Ex: 2)
--   split_requester = ID de quem iniciou o popup
--   split_participants = Lista de todos os envolvidos na divisão
