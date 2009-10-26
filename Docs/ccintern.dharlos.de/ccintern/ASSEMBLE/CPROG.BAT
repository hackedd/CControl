@echo off

REM Kompilieren eines C-Programms mit Hilfe des COSMIC-C-Compilers
REM Version v4.1j, damit dieses mit ZAP Version 3.20a simuliert
REM werden kann.

REM Die Dateien >>> CPROG.BAT, CPROG.C und CPROG.LCF <<< muessen in das
REM Verzeichnis kopiert werden, in das der COSMIC-C-Compiler installiert
REM wurde (muss die Dateien CA6805.EXE, CG6805.EXE, usw. enthalten).
REM Ausserdem muessen die Pfade in der Datei CPROG.LCF angepasst werden !!

REM Schliesslich kann diese BAT-Datei unter DOS aufgerufen und das Programm
REM kompiliert werden.

REM Nach der Kompilierung muss ZAP gestartet und CPROG.H05 geladen werden.
REM ZAP teilt jetzt bestimmt mit, das es eine Datei nicht finden kann und
REM fragt nach, ob die Pfade geaendert werden sollen. Das muss bejaht und
REM der Pfad von COSMIC-C hinzugefuegt werden. Danach sollte das Programm
REM im Single-Step-Modus durchlaufen werden (das Symbol mit den beiden
REM roten Schuhen fuer jeden Schritt druecken).

REM Fuer weitere Infos bitte das Manual zu COSMIC-C und die Onlinehilfe
REM zu ZAP konsultieren. Letztere enthaelt allerdings einen Fehler bei der
REM Parametrisierung des folgenden "CX6805"-Aufrufs:

cx6805 +debug -vl -no cprog.c
if errorlevel 1 goto bad
:clink
echo.
echo Linking ...
clnk -o cprog.h05 cprog.lcf
if errorlevel 1 goto bad
:chexa
echo.
echo Converting ...
chex -o cprog.hex cprog.h05
if errorlevel 1 goto bad
:cllabs
echo.
echo Generating absolute listing ...
clabs cprog.h05
if errorlevel 1 goto bad
echo.
echo.
echo        The compilation was successful.
goto sortie
:bad
echo.
echo.
echo        THE COMPILATION WITH COSMIC C FAILED.
:sortie
echo on
