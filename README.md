# Ecossistema Consagrado 🍺

Plataforma completa de gestão de bares e restaurantes, integrando clientes, garçons, gerentes e franqueadores.

## 🚀 Como Rodar o Projeto

Este projeto consiste em 5 partes que precisam rodar simultaneamente.

### Pré-requisitos
- Node.js instalado.

### Início Rápido (Windows)
Apenas dê um clique duplo no arquivo:
👉 `start-ecosystem.bat`

Isso abrirá 5 janelas de terminal, uma para cada serviço.

### Estrutura

| Serviço | Pasta | Porta | Descrição |
|---------|-------|-------|-----------|
| **Backend** | `/api-server` | `:3000` | API REST (json-server) que centraliza os dados. |
| **B2C App** | `/b2c-app` | `:517x` | App do Cliente (Cardápio, Comanda, Pagamento). |
| **B2B App** | `/b2b-app` | `:517x` | Painel do Gerente (Mesas, Pedidos, Mapa). |
| **Waiter** | `/waiter-app` | `:517x` | App do Garçom (Pedidos, Chamados). |
| **Admin** | `/admin-app` | `:517x` | Painel SaaS (Financeiro, Configurações). |

## 📱 Credenciais de Teste

**Painel Admin (SaaS)**
- Super Admin: `admin@consagrado.com` / `123`
- Dono de Bar: `owner@bardozé.com` / `123`

**B2B (Gerente)**
- Acesso livre (Simulação de Token Local) ou `gerente@bar.com`

**B2C (Cliente)**
- Login via Telefone (Simulado)

**Garçom**
- PIN: `1234`

## 🛠️ Tecnologias
- React (Vite)
- React Router DOM
- CSS Vanilla (Modules/Variables)
- Lucide React (Ícones)
- JSON Server (Backend Mock/Prototyping)
