'********************************************************************
'
' C-Control/BASIC       014.BAS
'
' Systemvoraussetzungen:
'
' - serielle Verbindung zum PC
' - Terminalprogramm
' - ein Piezo-Schallwandler ohne Elektronik (z.B Conrad Electronic
'   Best.-Nr. 75 16 69) zwischen dem BEEP-Port und GND
' - DCF77 Aktivantenne
'
' Schwerpunkte:
'
' - Verwendung der integrierten Echtzeituhr 
' - Warten auf Eintreten einer Bedingung mit WAIT
'
' Das Programm gibt Datum und Uhrzeit seriell aus und piept zu jeder
' vollen Minute.
'********************************************************************

' --- Definitionen --------------------------------------------------

define lastsec byte


' --- Programmoperationen -------------------------------------------

lastsec = 0

' Programmschleife (mit RESET beenden)

#loop

  ' warten, bis neue Sekunde angebrochen ist
  wait second <> lastsec 
  lastsec = second
  
  ' Tag
  if day < 10 then print "0";   ' fuehrende Null hinzufuegen
  print day; ".";

  ' Monat
  if month < 10 then print "0";   
  print month; ".";
  
  ' Jahr
  if year < 10 then print "0";   
  print year,
  
  ' Stunde
  if hour < 10 then print "0";   
  print hour; ":";

  ' Minute
  if minute < 10 then print "0";   
  print minute; ":";
  
  ' Sekunde
  if second < 10 then print "0";   
  print second
  if second = 0 then beep 100,20,0

goto loop

