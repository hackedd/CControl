'********************************************************************
'
' C-Control/BASIC       015.BAS
'
' Systemvoraussetzungen:
'
' - 25k-Potentiometer, mit den Aussenkontakten
'   zwischen 5V und GND geschaltet, Schleifer verbunden
'   mit A/D 1
' - Referenzspannungseingang mit 5V verbunden
' - serielle Verbindung zum PC
' - Terminalprogramm
' - Low-Current-LEDs an Port 1 bis Port 7, Vorwiderstand ca. 1k,
'   alle Kathoden nach GND
' - Taster an Port 9 und Port 11 nach GND
'
' Schwerpunkte:
'
' - Datenaufzeichnung
' - Verwendung der integrierten Echtzeituhr
' - Aufruf von Unterroutinen
'
' Das Programm misst zu jeder vollen Minute einen Analogwert und
' speichert ihn im EEPROM-Chip. Auf Tastendruck werden alle Daten
' seriell ausgegeben. Ist der Speicher voll, endet die Aufzeichnung
' und eine LED wird eingeschaltet.
'********************************************************************

' --- Definitionen --------------------------------------------------

define count word
define value word
define lastsec byte

define key port[9]
define led port[1]

define poti ad[1]


' --- Programmoperationen -------------------------------------------

count = 0
led = 0
lastsec = 0

' Datei ruecksetzen
open# for write
close#

' Programmschleife (mit RESET beenden)

#loop1

  ' wenn Minute voll und in dieser Sekunde nicht schon geschrieben
  ' dann messen und aufzeichnen
  if second = 0 and second <> lastsec then gosub log 
  lastsec = second  

#loop2

  ' wenn Taste gedrueckt, dann ausgeben
  if not key then gosub dump

  ' kleine Pause
  pause 20
  
' wenn led ein, dann Datei voll, dann nur noch Taste abfragen
if led then goto loop2 else goto loop1


' messen und speichern
#log
  beep 100, 10, 0
  open# for append
    if filefree then print# poti else goto filefull
  close#
  count = count + 1
return

#filefull
  close#
  led = ON
return


' Messwerte ausgeben
#dump
  print
  print count, " Messwerte"
  open# for read

#dumpnext
  if eof then return
  input# value
  print value; " ";
goto dumpnext
