'********************************************************************
'
' C-Control/BASIC       009.BAS
'
' Systemvoraussetzungen:
'
' - serielle Verbindung zum PC
' - Terminalprogramm
'
' Schwerpunkte:
'
' - Definition von internen und externen Tabellen
' - Zugriff auf Tabellen
'
'********************************************************************

' --- Definitionen --------------------------------------------------

  define x word
  define i byte

  define tab1_ende 9
  define tab2_ende 19

' --- Programmoperationen -------------------------------------------

'Programmtitel ausgeben 
  print "C-Control/BASIC      009.BAS"
  print "============================"
  print

' Ausgabe der ersten Tabelle, i ist die Indexvariable,
' beachten Sie, dass der erste Tabelleneintrag den Index 0 hat

  for i = 0 to tab1_ende
    looktab tab1, i, x
    print "tab1["; i; "]="; x
  next

' Leerzeile
  print

  for i = 0 to tab2_ende
    looktab tab2, i, x
    print "tab2["; i; "]="; x
  next

' Leerzeile
  print

' der END-Befehl ist hier besonders wichtig, da die
' nachfolgenden Tabellendaten sonst vom Mikroprozessor
' wie Befehle abgearbeitet werden, was sicher zu einem
' Systemabsturz fuehrt

end

' Definition einer internen Tabelle

table tab1
  3 10 7 -1234 789
  -32100 0 53 90 -45
tabend

' Definition einer externen Tabelle
table tab2 "009DEMO.TAB"
