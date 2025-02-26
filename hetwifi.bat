@echo off
setlocal enabledelayedexpansion

for /f "skip=9 tokens=*" %%i in ('netsh wlan show profiles') do (
    for /f "tokens=2 delims=:" %%j in ("%%i") do (
        set "profile=%%j"
        rem Remove leading spaces from profile name
        set "profile=!profile:~1!"
        call :show_profile
    )
)
goto :eof

:show_profile
echo !profile! | findstr -i -v "echo" >nul && (
    netsh wlan show profiles "!profile!" key=clear
)
goto :eof