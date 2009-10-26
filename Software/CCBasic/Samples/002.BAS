'********************************************************************
'
' C-Control/BASIC       002.BAS
'
' Systemvoraussetzungen:
'
' - serielle Verbindung zum PC
' - Terminalprogramm
'
' Schwerpunkte:
'
' - Definition von Labeln
' - Sprungbefehl GOTO
'
' Das Beispiel zeigt, wie mit dem GOTO-Befehl im Programm
' verzweigt werden kann, dadurch jedoch schnell der
' Ueberblick ueber den Programmverlauf verloren geht.
' Der GOTO-Befehl sollte daher sparsam und wohlueberlegt
' eingesetzt werden.
' Das Einruecken von Quelltextzeilen innerhalb eines
' zusammenhaengenden Anweisungsblocks kann die Lesbarkeit eines
' Programms erhoehen.
'********************************************************************

' --- Programmoperationen -------------------------------------------

'Programmtitel ausgeben 
  print "C-Control/BASIC      002.BAS"
  print "============================"
  print

  goto abc

' noch eine Leerzeile ausgeben und Programmende
#ende
  print
end

#defg
  print "DEFG";
goto hijklmn

#uvwxyz
  print "UVWXYZ"
goto ende

#opq
  print "OPQ";
goto rst

#abc
  print "ABC";
goto defg

#rst
  print "RST";
goto uvwxyz

#hijklmn
  print "HIJKLMN";
goto opq


