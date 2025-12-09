@echo off
echo ==========================================
echo    INICIANDO ECOSSISTEMA CONSAGRADO
echo ==========================================
echo.
echo 1. Iniciando Backend (Porta 3000)...
start "API Server" cmd /k "cd api-server && npm run start"

echo 2. Iniciando B2B App (Porta 5173?)...
start "Chefia B2B" cmd /k "cd b2b-app && npm run dev"

echo 3. Iniciando B2C App...
start "Consagrado B2C" cmd /k "cd b2c-app && npm run dev"

echo 4. Iniciando Waiter App...
start "Garcom App" cmd /k "cd waiter-app && npm run dev"

echo 5. Iniciando Admin App...
start "Super Admin" cmd /k "cd admin-app && npm run dev"

echo.
echo ==========================================
echo    TUDO PRONTO! ACESSE NAS PORTAS INDICADAS
echo ==========================================
pause
