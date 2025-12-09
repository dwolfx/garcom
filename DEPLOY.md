# Guia de Deploy (Hospedagem Grátis) 🚀

A melhor opção gratuita e performática para React hoje é a **Vercel**.
Como temos 4 aplicativos, o ideal é criar 4 projetos separados na Vercel, todos gratuitos.

## Opção 1: Via GitHub (Recomendado)

1.  Crie um repositório no GitHub e suba os arquivos.
2.  Acesse [vercel.com](https://vercel.com) e crie uma conta (Login com GitHub).
3.  Clique em **"Add New Project"**.
4.  Selecione o repositório do `garcom`.
5.  A Vercel vai perguntar: "Root Directory" (Qual pasta quer rodar?).
    *   Você terá que importar o repositório **4 vezes**, uma para cada app.

### Configuração de cada Importação:

| Nome do Projeto (Sugestão) | Root Directory | Framework |
|----------------------------|----------------|-----------|
| `meu-bar-cliente` | `b2c-app` | Vite |
| `meu-bar-gestao` | `b2b-app` | Vite |
| `meu-bar-garcom` | `waiter-app` | Vite |
| `meu-bar-admin` | `admin-app` | Vite |

*A Vercel detecta automaticamente que é Vite e configura o comando de build.*

## Opção 2: Via Comandos (Manual)

Se não quiser usar GitHub, você pode rodar direto do seu computador:

1.  Instale a Vercel CLI: `npm i -g vercel`
2.  Entre na pasta de cada app e rode `vercel`:

```bash
cd b2c-app
vercel --prod
# Siga as instruções na tela (Yes, Yes, Yes...)
```

Repita para `b2b-app`, `waiter-app` e `admin-app`.

## 🕸️ URLs Finais
Você terá 4 links públicos e seguros (HTTPS), por exemplo:
*   `https://consagrado-cliente.vercel.app`
*   `https://consagrado-gestao.vercel.app`
*   ...

## ⚠️ Atenção
Como migramos para o **Supabase**, tudo vai funcionar magicamente! Não precisa configurar nada extra, pois a URL do banco já está fixa no código (`api.js`).
