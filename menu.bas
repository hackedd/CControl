#include "lcd_header.bas"
#include "key_header.bas"

DEFINE menu_option	BYTE
DEFINE i			BYTE
DEFINE j			BYTE

DEFINE options		BYTE[10]
DEFINE half			BIT[81]
DEFINE long			BIT[82]
DEFINE proef		BIT[83]

' Initialize LCD Screen
GOSUB lcd_init

' Store our custom chars in the LCD's Memory
GOSUB custom_chars_setup

' Default Settings
half = OFF
long = OFF
proef = ON

' Start at Metric Option
menu_option = 0

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
	IF menu_option = 2 THEN GOSUB menu_render_start
	IF menu_option = 3 THEN GOSUB menu_render_test
	
#menu_render_wait_key
	GOSUB get_key
	IF key_nr = -1 THEN GOTO menu_render_wait_key
	
	' Up one item in menu
	IF key_nr =  2 AND menu_option > 0 THEN menu_option = menu_option - 1
	IF key_nr =  2 AND menu_option = 0 THEN menu_option = 3
	
	' Down one item in menu
	IF key_nr =  8 AND menu_option < 3 THEN menu_option = menu_option + 1
	IF key_nr =  8 AND menu_option = 3 THEN menu_option = 0
	
	' Left and Right in Metric option
	IF key_nr =  4 AND menu_option = 0 THEN GOSUB menu_metric_left
	IF key_nr =  6 AND menu_option = 0 THEN GOSUB menu_metric_right
	
	' Left and Right in ProefPijlen option
	IF (key_nr =  4 OR key_nr = 6) AND menu_option = 1 THEN GOSUB menu_proef_toggle
	
	' Start
	IF key_nr = 11 AND menu_option = 2 THEN GOTO start_proef
	
	' Start Testing Code
	IF key_nr = 11 AND menu_option = 3 THEN GOTO start_test
	
	GOTO menu_render

#start_proef
#start_test
	' Do nothing for now...
	GOSUB lcd_cls
	END

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
ASCIITABLE menu_controls	" 2\x00 8\x01 4\x7F 6\x7E #\x02 "
ASCIITABLE menu_metric		"Metric: "
'                            0123456789ABCDEF0123456789ABCDEF
ASCIITABLE menu_metric_o	"Short   Long    Half Sh Half Lo "
ASCIITABLE menu_proef		"ProefPijlen: "
ASCIITABLE menu_proef_o		"Ja Nee"
ASCIITABLE menu_start		"Start Wedstrijd "
ASCIITABLE menu_test		"Test Signalen   "

#include "lcd_chars.bas"
#include "lcd_routines.bas"
#include "key_routines.bas"

