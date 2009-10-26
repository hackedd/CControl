'********************************************************************
'
' C-Control/BASIC       012.BAS
'
' Systemvoraussetzungen:
'
' - serielle Verbindung zum PC
' - Terminalprogramm
'
' Schwerpunkte:
'
' - selektive Ausfuehrung mit ON...GOSUB (ON...GOTO)
'
' Dieses Beispiel arbeitet nur mit ON...GOSUB. ON...GOTO wird
' analog verwendet. Beachten Sie dabei dann den Unterschied zwischen
' GOSUB (Unterprogrammaufruf) und GOTO (Sprung).
'
'********************************************************************

' --- Definitionen --------------------------------------------------

  define selection word


' --- Programmoperationen -------------------------------------------

'Programmtitel ausgeben
  print
  print "C-Control/BASIC      012.BAS"
  print "============================"

  gosub menu


' Beginn der Dauerschleife
#loop

  input selection
  on selection gosub bye, howareyou, hi
  gosub menu

goto loop


' Ausgabe des Menues
#menu
  print
  print
  print "---------------------------"
  print "   (2) - Gruss"
  print "   (1) - Wie geht es so?"
  print "   (0) - Verabschiedung"
  print "---------------------------"
  print "> ";
return


#bye
  print "Auf Wiedersehen!"
  end
'return kann entfallen, da Programmende

#howareyou
  print "Danke, gut!"
return

#hi
  print "Hallo!"
return

