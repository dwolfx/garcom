-- Adicionar colunas de RH na tabela users
ALTER TABLE users 
ADD COLUMN IF NOT EXISTS phone TEXT,
ADD COLUMN IF NOT EXISTS cpf TEXT,
ADD COLUMN IF NOT EXISTS birth_date DATE,

-- Dados Bancários
ADD COLUMN IF NOT EXISTS pix_key TEXT,
ADD COLUMN IF NOT EXISTS bank_info TEXT, -- Banco, Agência, Conta

-- Contato de Emergência
ADD COLUMN IF NOT EXISTS emergency_contact_name TEXT,
ADD COLUMN IF NOT EXISTS emergency_contact_phone TEXT,

-- Turno e Trabalho
ADD COLUMN IF NOT EXISTS shift_description TEXT, -- Ex: "Noite", "Fim de Semana"
ADD COLUMN IF NOT EXISTS work_days TEXT, -- Ex: "Sex, Sab, Dom"
ADD COLUMN IF NOT EXISTS shift_start TIME, -- 18:00
ADD COLUMN IF NOT EXISTS shift_end TIME, -- 02:00
ADD COLUMN IF NOT EXISTS is_working_now BOOLEAN DEFAULT FALSE;

-- Atualizar dados existentes (Mock)
UPDATE users 
SET 
    phone = '11999998888',
    shift_description = 'Noturno',
    work_days = 'Qua, Qui, Sex, Sab, Dom',
    shift_start = '18:00',
    shift_end = '02:00',
    is_working_now = TRUE
WHERE role = 'waiter';
