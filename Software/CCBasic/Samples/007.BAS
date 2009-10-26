'********************************************************************
'
' C-Control/BASIC       007.BAS
'
' Systemvoraussetzungen:
'
' - Low-Current-LEDs an Port 1 bis Port 7, Vorwiderstand ca. 1k,
'   alle Kathoden nach GND 
' - Taster an Port 9 und Port 11 nach GND
'
' Schwerpunkte:
'
' - Digitalports als Eingaenge
' - binaere Operation
'
'********************************************************************

' --- Definitionen --------------------------------------------------

' LED
define led1 port[1]
define led2 port[2]
define led3 port[3]
define led4 port[4]
define led5 port[5]
define led6 port[6]
define led7 port[7]

' Taster
define key1 port[9]
define key2 port[11]

' --- Programmoperationen -----------------------

' dieses Programm arbeitet in einer Endlosschleife,
' zum Beenden druecken Sie bitte den roten Reset-Taster

' Programmbeginn
#loop

  ' die erste LED gibt unmittelbar den vom ersten Taster
  ' eingelesenen Wert aus,
  ' Sie erkennen, bei nicht gedruecktem Taster wird
  ' wegen der 10k-Pull-Up-Widerstaende eine 1 gelesen,
  ' bei gedruecktem Taster eine 0

  led1 = key1

  ' die zweite LED invertiert den Wert von key1 und
  ' leuchtet somit, wenn der Taster gedrueckt ist

  led2 = not key1

  ' die dritte LED demonstriert eine UND-Verknuepfung der
  ' beiden Taster, die Taster-Werte werden zuvor invertiert,
  ' die LED leuchtet, wenn beide Taster gedrueckt sind

  led3 = not key1 and not key2

  ' die vierte LED demonstriert eine NICHT-UND-Verknuepfung der
  ' beiden Taster, die Taster-Werte werden zuvor invertiert,
  ' die LED leuchtet nicht, wenn beide Taster gedrueckt sind

  led4 = not key1 nand not key2

  ' die fuenfte LED demonstriert eine ODER-Verknuepfung der
  ' beiden Taster, die Taster-Werte werden zuvor invertiert,
  ' die LED leuchtet, wenn mindestens ein Taster gedrueckt ist

  led5 = not key1 or not key2

  ' die sechste LED demonstriert eine NICHT-ODER-Verknuepfung der
  ' beiden Taster, die Taster-Werte werden zuvor invertiert,
  ' die LED leuchtet nicht, wenn mindestens ein Taster gedrueckt ist

  led6 = not key1 nor not key2

  ' die siebte LED demonstriert eine EXCLUSIV-ODER-Verknuepfung der
  ' beiden Taster, die Taster-Werte werden zuvor invertiert,
  ' die LED leuchtet, wenn ein Taster gedrueckt ist 

  led7 = not key1 xor not key2

' wieder von vorn beginnen
goto loop

' der END-Befehl wird wegen der Endlosschleife
' nicht benoetigt

