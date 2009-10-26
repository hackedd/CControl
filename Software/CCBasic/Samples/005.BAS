'********************************************************************
'
' C-Control/BASIC       005.BAS
'
' Systemvoraussetzungen:
'
' - serielle Verbindung zum PC
' - Terminalprogramm
'
' Schwerpunkte:
'
' - Programmschleifen mit FOR...TO...STEP und NEXT
'
' Das Beispiel zeigt am Ende den Effekt der Verwendung einer
' Bytevariable als Schleifenvariable in Verbindung mit einem
' ungueltigem Schleifenendwert (>255).
'********************************************************************

' --- Definitionen --------------------------------------------------

' automatische Variablen

define i word
define k byte

' --- Programmoperationen -----------------------

'Programmtitel ausgeben 
  print "C-Control/BASIC      005.BAS"
  print "============================"
  print

' einfachste Schleifenform
  for i = 0 to 10
    print i; " ";
  next

' neue Ausgabezeile
  print

' Schleife mit Schrittweitenangabe
  for i = 0 to 10 step 2
    print i; " ";
  next

'* Achtung: die Schleife wird nur beendet, wenn durch fortlaufende
'* Addition der Schrittweite auf den Startwert auch tatsaechlich
'* der angegebene Endwert erreicht wird!
'* "for i = 1 to 10 step 2" wuerde zu einer Endlosschleife fuehren!

' neue Ausgabezeile
  print

' Schleife mit negativer Schrittweite
  for i = 10 to 0 step -1
    print i; " ";
  next

' neue Ausgabezeile
  print

' verschachtelte Schleifen
  for i = 0 to 5
    for k = 0 to 5
      print "(i,k)=("; i; ","; k; ") ";
    next
    print
  next

' neue Ausgabezeile
  print

' eine etwas laengere Schleife
  for i = 0 to 300
    print i; " ";
  next

' neue Ausgabezeile
  print

' zum Schluss ein (hier absichtlicher) Fehler, der zu einer
' Endlosschleife fuehrt. Achten Sie auf den Ueberlauf von
' 255 nach 0. Wenn Sie genug gesehen haben, druecken Sie
' den roten Reset-Taster.

  for k = 0 to 300
    print k; " ";
  next

' hierher komm das Programm nie!
  print
end


