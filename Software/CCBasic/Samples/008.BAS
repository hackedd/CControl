'********************************************************************
'
' C-Control/BASIC       008.BAS
'
' Systemvoraussetzungen:
'
' - 25k-Potentiometer, mit den Aussenkontakten
'   zwischen 5V und GND geschaltet, Schleifer verbunden
'   mit A/D 1
' - Referenzspannungseingang mit 5V verbunden
' - serielle Verbindung zum PC
' - Terminalprogramm
'
' Schwerpunkte:
'
' - Definition eines A/D-Ports
' - Einlesen eines Messwertes von einem A/D-Port
'
' Sie erkennen in diesem Beispiel, dass A/D-Ports wie gewoehnliche
' Variablen im Quelltext benutzt werden koennen (natuerlich nur
' lesend).
'
'********************************************************************

' --- Definitionen --------------------------------------------------

  define poti ad[1]

' --- Programmoperationen -------------------------------------------

'Programmtitel ausgeben 
  print "C-Control/BASIC      008.BAS"
  print "============================"
  print

' dieses Programm arbeitet ab jetzt in einer Endlosschleife,
' zum Beenden druecken Sie bitte den roten Reset-Taster

' drehen Sie am Potentiometer, beobachten Sie die
' Bildschirmausgaben, die erreichbaren Werte von 0 bis 255
' zeugen von der 8-Bit-Aufloesung bei der A/D-Wandlung

#loop

' Wert vom A/D-Wandler lesen und seriell ausgegeben

  print poti

' kleine Pause vor der naechsten Messung, um Wertaenderungen
' am Bildschirm verfolgen zu koennen

  pause 25

goto loop

