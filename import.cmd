@echo off
setlocal
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0import.ps1" %* -NoPause
if errorlevel 1 (
  echo.
  echo [ChatTranslate] Ocorreu um erro. A janela vai fechar em 15 segundos...
  timeout /t 15 /nobreak >nul
)
exit /b %errorlevel%
