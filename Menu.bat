@echo off
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
	
 :Start1 
    cls
    goto Start
	
	set "input="
	
    :Start
	COLOR 17
	CLS
    echo --------------------------------------
    echo     WITAJ W PROGRAMIE WindowsTime_2.1  
    echo --------------------------------------            
    echo WYBIERZ NUMER OPCJI Z LISTY PONIZEJ:
    echo [1]	ZAINSTALUJ OGRANICZENIE CZASU
	echo [2]	ODINSTALUJ OGRANICZENIE CZASU
	echo [3]	DODAJ LUB ODEJMIJ CZAS NA DZISIAJ
	echo [4]	ZMIEN CZAS CODZIENNY LUB WEEKENDOWY
	echo [5]	POKAZ AKTUALNY STAN CZASU
	echo [6]	EXIT

    set /a add=1
	set /a add2=2
	set /a add3=3
	set /a add4=4
	set /a add5=5
	set /a add6=6
	
    set input=
    set /p input= Enter your choice:
	
	GOTO SET_OPERATION
	
	:SET_OPERATION
	
	echo:
	echo:
	set operator=1
	
	IF "%input%" equ "%add%" Set operator=2
	IF "%input%" equ "%add2%" Set operator=2
	IF "%input%" equ "%add3%" Set operator=2
	IF "%input%" equ "%add4%" Set operator=2
	IF "%input%" equ "%add5%" Set operator=2
	IF "%input%" equ "%add6%" Set operator=2
	
	GOTO CHECK_LOOP
	
	:CHECK_LOOP
	setlocal enabledelayedexpansion

	IF  %operator% EQU 2 (
	GOTO OPTION_CHOOSEN
	)	else	(
	CLS
	ECHO "MUSISZ PODAC PRAWIDLOWY NUMER OD 1-6"
	GOTO Start1
	)
	
	:OPTION_CHOOSEN
	
	if %input% equ %add% goto A 
	if %input% equ %add2% goto B 
	if %input% equ %add3% goto C 
	if %input% equ %add4% goto D 
	if %input% equ %add5% goto E 
	if %input% equ %add6% goto F
	
	

    :A
	CALL %~dp0Main\INSTALL.bat
	GOTO Start
	
	:B
	CALL %~dp0Main\FILES\DEINSTALL.BAT
	GOTO Start
	
	:C
	CALL %~dp0Main\FILES\change_elasped_time.bat
	GOTO Start
	
	:D
	CALL %~dp0Main\FILES\change_time.bat
	GOTO Start
	
	:E
	CALL %~dp0Main\FILES\show_aktu_time.bat
	GOTO Start
	
    :F
    exit
