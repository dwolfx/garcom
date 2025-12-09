@echo off
echo ==========================================
echo    GERANDO VERSAO DE PRODUCAO (BUILD)
echo ==========================================
echo.

echo 1. Build B2C App...
cd b2c-app
call npm run build
cd ..

echo.
echo 2. Build B2B App...
cd b2b-app
call npm run build
cd ..

echo.
echo 3. Build Waiter App...
cd waiter-app
call npm run build
cd ..

echo.
echo 4. Build Admin App...
cd admin-app
call npm run build
cd ..

echo.
echo ==========================================
echo    BUILDS CONCLUIDOS COM SUCESSO!
echo    Os arquivos estao nas pastas 'dist'
echo ==========================================
pause
