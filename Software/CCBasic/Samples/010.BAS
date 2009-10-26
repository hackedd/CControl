'********************************************************************
'
' C-Control/BASIC       010.BAS
'
' Systemvoraussetzungen:
'
' - serielle Verbindung zum PC
' - Terminalprogramm
' - Taster an Port 9 nach GND
' - 25k-Potentiometer, mit den Aussenkontakten
'   zwischen 5V und GND geschaltet, Schleifer verbunden
'   mit A/D 1
'
' Schwerpunkte:
'
' - bedingte Ausfuehrung mit IF...THEN...ELSE
' - Vergleichsoperationen
' - logische VerknÅpfungen
' - Programme mit Dauerschleife und definiertem Ausstieg
'
' Beispiel 007.BAS arbeitet bereits mit einer Dauerschliefe,
' kann jedoch nur mit RESET beendet werden.
'
'********************************************************************

' --- Definitionen --------------------------------------------------

  define poti ad[1]
  define key port[9]
  
  define SCHWELLE 100


' --- Programmoperationen -------------------------------------------

'Programmtitel ausgeben 
  print "C-Control/BASIC      010.BAS"
  print "============================"
  print
  

' Beginn der Dauerschleife
#loop

' Abfrage des Potis und Vergleich mit einem Schwellwert
  if poti > SCHWELLE then print "viel", else print "wenig",

' sollen mehrere Anweisungen bedingt ausgefÅhrt werden, dann ist
' ein Unterprogrammaufruf notwendig

  if poti = 255 then gosub special
  
' Wenn der Taster gedrueckt ist, dann wird 0 vom Port gelesen
' -> Invertieren des Ports entspricht der Frage "Taste gedrueckt?".
' Gleichwertig im Ergebnis, jedoch langsamer in der AusfÅhrung 
' ist der Vergleich key = 0.

  if not key then print "Taste gedrueckt";
  
' Abbruchbedingung und Programmende
  if not key and poti = 0 then end

' wenn kein Programmende, dann geht es hier weiter: 
' eine Leerzeile ausgeben und eine kurze Pause
  print
  pause 10
  
goto loop    


' ein Unterprogramm aus mehreren Anweisungen,
#special
  print "!!! ";
  print "sehr viel";
  print " !!!",
return

