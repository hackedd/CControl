' This file is part of 'Buiten Wedstrijd Installatie' - HBSV Assumburg
' (C) 2009 Paul Hooijenga - <phooijenga@gmail.com>
' $Id$
'

#menu_render_controls
	' Position cursor at 2:0
	lcd_param = lcd_line2
	GOSUB lcd_cmd
	
	' Write contents of menu_controls
	FOR i = 0 TO 15
		LOOKTAB menu_controls, i, lcd_param
		GOSUB lcd_put
	NEXT i

#menu_render
	' Position cursor 1:0
	lcd_param = lcd_line1
	GOSUB lcd_cmd
	
	' Jump to currently selected option
	IF menu_option = 0 THEN GOSUB menu_render_metric
	IF menu_option = 1 THEN GOSUB menu_render_proef
	IF menu_option = 2 THEN GOSUB menu_render_opschiet
	IF menu_option = 3 THEN GOSUB menu_render_start
	IF menu_option = 4 THEN GOSUB menu_render_test
	
#menu_render_wait_key
	GOSUB get_key
	IF key_nr = NO_KEY THEN GOTO menu_render_wait_key
	
	' Up one item in menu
	IF key_nr =  2 THEN IF menu_option = 0 THEN menu_option = 4 ELSE menu_option = menu_option - 1
	
	' Down one item in menu
	IF key_nr =  8 THEN IF menu_option = 4 THEN menu_option = 0 ELSE menu_option = menu_option + 1
	
	' Left and Right in Metric option
	IF key_nr =  4 AND menu_option = 0 THEN GOSUB menu_metric_left
	IF key_nr =  6 AND menu_option = 0 THEN GOSUB menu_metric_right
	
	' Left and Right in ProefPijlen option
	IF (key_nr =  4 OR key_nr = 6) AND menu_option = 1 THEN GOSUB menu_proef_toggle	
	' Left and Right in Opschiet option
	IF (key_nr =  4 OR key_nr = 6) AND menu_option = 2 THEN GOSUB menu_opschiet_toggle

	' Start
	IF key_nr = KEY_HASH AND menu_option = 3 THEN GOTO start_proef
	
	' Start Testing Code
	IF key_nr = KEY_HASH AND menu_option = 4 THEN GOTO start_test
	
	GOTO menu_render

#include "menu_metric.bas"

#menu_render_proef
	' Render ProefPijlen:
	FOR i = 0 TO 12
		LOOKTAB menu_proef, i, lcd_param
		GOSUB lcd_put
	NEXT i
	
	' Render Ja / Nee
	IF proef = ON THEN j = 0 ELSE j = 3
	FOR i = j TO j + 2
		LOOKTAB menu_proef_o, i, lcd_param
		GOSUB lcd_put
	NEXT i
RETURN

#menu_proef_toggle
	IF proef = ON THEN proef = OFF ELSE proef = ON
RETURN

#menu_render_opschiet
	FOR i = 0 TO 12
		LOOKTAB menu_opschiet, i, lcd_param
		GOSUB lcd_put
	NEXT i
	
	' Render Ja / Nee
	IF opschiet = ON THEN j = 0 ELSE j = 3
	FOR i = j TO j + 2
		LOOKTAB menu_proef_o, i, lcd_param
		GOSUB lcd_put
	NEXT i
RETURN

#menu_opschiet_toggle
	IF opschiet = ON THEN opschiet = OFF ELSE opschiet = ON
RETURN

#menu_render_start
	' Render Start Wedstrijd
	FOR i = 0 TO 15
		LOOKTAB menu_start, i, lcd_param
		GOSUB lcd_put
	NEXT i
RETURN

#menu_render_test
	' Render Test Signalen
	FOR i = 0 TO 15
		LOOKTAB menu_test, i, lcd_param
		GOSUB lcd_put
	NEXT i
RETURN

'                            0123456789ABCDEF0123456789ABCDEF
ASCIITABLE menu_controls	" \x002 8\x01 \x7F4 6\x7E #\x02 "
ASCIITABLE menu_metric		"Metric: "
'                            0123456789ABCDEF0123456789ABCDEF
ASCIITABLE menu_metric_o	"Short   Long    Half Sh Half Lo "
ASCIITABLE menu_proef		"ProefPijlen: "
ASCIITABLE menu_proef_o		"Ja Nee"
ASCIITABLE menu_opschiet	"OpschietMode "
ASCIITABLE menu_start		"Start Wedstrijd "
ASCIITABLE menu_test		"Test Signalen   "

