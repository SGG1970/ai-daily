@echo off
echo ========================================
echo   🤖 每日AI头条 - 本地服务启动
echo ========================================
echo.
cd /d "%~dp0"
start http://localhost:8080
python -m http.server 8080
pause
