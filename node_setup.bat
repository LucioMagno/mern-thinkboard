@echo off
setlocal
cd /d "%~dp0"

where volta >nul 2>&1 || (echo [ERROR] Volta not found in PATH & exit /b 1)

if not exist package.json (
  call volta run npm init -y || exit /b 1
)

call volta pin node@24.13.0 || exit /b 1

if exist package-lock.json (
  call volta run npm ci || exit /b 1
) else (
  call volta run npm install || exit /b 1
)

echo.
echo Project ready at: %cd%
call volta run node -v
call volta run npm -v

rem Optional: open in VS Code automatically
code .
