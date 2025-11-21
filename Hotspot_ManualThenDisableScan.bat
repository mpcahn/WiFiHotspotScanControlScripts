@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
title Mobile Hotspot: Manual Enable, Then Disable Wi-Fi Scanning

:: ===== Admin check =====
>nul 2>&1 net session
if %errorlevel% neq 0 (
  echo This script requires Administrator privileges.
  echo Right-click it and choose "Run as administrator".
  pause
  exit /b 1
)

echo [1/4] Opening Windows Settings ^> Mobile hotspot...
start "" ms-settings:network-mobilehotspot

echo.
echo A Settings window opened to "Mobile hotspot".
echo Please toggle "Mobile hotspot" to ON manually.
echo When it shows ON, return to this window.
echo.

:confirm
choice /C YN /M "Is Mobile hotspot now turned ON? (Y/N)"
if errorlevel 2 (
  echo   You chose No. Make sure Mobile hotspot is ON, then try again.
  goto confirm
)

echo.
echo [2/4] Detecting your Wi-Fi interface name...
set "IFACE="
for /f "tokens=1,* delims=:" %%A in ('netsh wlan show interfaces ^| findstr /R /C:"^\s*Name"') do set "raw=%%B"
if defined raw for /f "tokens=* delims= " %%I in ("!raw!") do set "IFACE=%%I"
if not defined IFACE set "IFACE=Wi-Fi"
echo     Using interface: "%IFACE%"

echo.
echo [3/4] Disabling Wi-Fi AutoConfig (scanning) on "%IFACE%"...
netsh wlan set autoconfig enabled=no interface="%IFACE%"
if %errorlevel% neq 0 (
  echo   ^> Failed to disable AutoConfig on "%IFACE%".
  echo   ^> Check the exact interface name via:  netsh wlan show interfaces
  echo   ^> Then re-run with the correct name by editing IFACE in this script.
  goto done
) else (
  echo   AutoConfig disabled. Background scanning/auto-join will stop.
)

echo.
echo [4/4] Done.
echo ------------------------------------------------------------
echo To re-enable scanning later:
echo   netsh wlan set autoconfig enabled=yes interface="%IFACE%"
echo
echo To quickly check interface name again:
echo   netsh wlan show interfaces
echo ------------------------------------------------------------
echo Note: Mobile hotspot remains ON (you turned it on manually).
echo       Disabling AutoConfig does not turn the hotspot off.
echo.
:done
pause
ENDLOCAL