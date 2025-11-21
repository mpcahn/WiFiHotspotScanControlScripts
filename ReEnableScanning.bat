@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
title Re-Enable Wi-Fi Scanning and Open Hotspot Settings

:: ===== Admin check =====
>nul 2>&1 net session
if %errorlevel% neq 0 (
  echo This script requires Administrator privileges.
  echo Right-click it and choose "Run as administrator".
  pause
  exit /b 1
)

echo [1/3] Detecting your Wi-Fi interface name...
set "IFACE="
for /f "tokens=1,* delims=:" %%A in ('netsh wlan show interfaces ^| findstr /R /C:"^\s*Name"') do set "raw=%%B"
if defined raw for /f "tokens=* delims= " %%I in ("!raw!") do set "IFACE=%%I"
if not defined IFACE set "IFACE=Wi-Fi"
echo     Using interface: "%IFACE%"

echo.
echo [2/3] Re-enabling Wi-Fi AutoConfig (scanning) on "%IFACE%"...
netsh wlan set autoconfig enabled=yes interface="%IFACE%"
if %errorlevel% neq 0 (
  echo   ^> Failed to enable AutoConfig on "%IFACE%".
  echo   ^> Check the interface name via: netsh wlan show interfaces
  echo   ^> Then edit the IFACE variable in this script.
) else (
  echo   AutoConfig re-enabled on "%IFACE%".
  echo   Wi-Fi scanning and auto-join restored.
)

echo.
echo [3/3] Opening Windows Settings ^> Mobile hotspot...
start "" ms-settings:network-mobilehotspot
echo   Use this Settings window to manually turn OFF your hotspot if desired.
echo.
echo ------------------------------------------------------------
echo Done.
echo To verify AutoConfig status:
echo   netsh wlan show autoconfig
echo ------------------------------------------------------------
pause
ENDLOCAL
