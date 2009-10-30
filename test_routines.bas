' This file is part of 'Buiten Wedstrijd Installatie' - HBSV Assumburg
' (C) 2009 Paul Hooijenga - <phooijenga@gmail.com>
' $Id$
'

#start_test
	lcd_param = lcd_line1
	GOSUB lcd_cmd
	
	FOR i = 0 to 15
		LOOKTAB test_mode, i, lcd_param
		GOSUB lcd_put
	NEXT i
	
	lcd_param = lcd_line2
	GOSUB lcd_cmd

	FOR i = 16 to 31
		LOOKTAB test_mode, i, lcd_param
		GOSUB lcd_put
	NEXT i
	
	PAUSE 250 '5 seconds
		
	GOTO menu_render_controls
	
'                        0123456789ABCDEF
ASCIITABLE test_mode	"Test Mode        Not Implemented"
