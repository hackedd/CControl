'********************************************************************
'
' C-Control/BASIC       011.BAS
'
' Systemvoraussetzungen:
'
' - ein Piezo-Schallwandler ohne Elektronik (z.B Conrad Electronic
'   Best.-Nr. 75 16 69) zwischen dem BEEP-Port und GND
'
' Schwerpunkte:
'
' - Ausgabe von Toenen (Rechteckschwingungen) mit BEEP
'
'********************************************************************


' --- Programmoperationen -------------------------------------------
 

'spielt "Alle meine Entchen"

beep 625,12,1
beep 550,12,1
beep 500,12,1
beep 475,12,1
beep 425,24,1
beep 425,24,1

beep 375,12,1
beep 375,12,1
beep 375,12,1
beep 375,12,1
beep 425,24,24

beep 375,12,1
beep 375,12,1
beep 375,12,1
beep 375,12,1
beep 425,24,24

beep 475,12,1
beep 475,12,1
beep 475,12,1
beep 475,12,1
beep 500,24,1
beep 500,24,1

beep 425,12,1
beep 425,12,1
beep 425,12,1
beep 425,12,1
beep 625,24,1

	


