@echo off
title 🤖 每日AI头条 - 本地服务
echo ========================================
echo   🤖 每日AI头条 - 正在启动
echo ========================================
echo.
echo  🌐 打开浏览器访问:
echo     http://localhost:8081
echo.
echo  局域网其他设备:
echo     http://192.168.31.189:8081
echo.
echo  按 Ctrl+C 停止服务
echo ========================================
python -m http.server 8081 -d "%~dp0"
pause
