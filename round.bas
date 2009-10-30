' This file is part of 'Buiten Wedstrijd Installatie' - HBSV Assumburg
' (C) 2009 Paul Hooijenga - <phooijenga@gmail.com>
' $Id$
'

DEFINE SLASH 47

#round
	GOSUB show_abcd
	
	FOR j = 0 TO 1
#red_green_orange_cycle
#start_red
		red = ON
		GOSUB buzz
		GOSUB buzz

		TIMER = 0
		t = TIMER + RED_TIME
#red_loop
			'Do something meaningful, like updating the display
			lcd_temp = (t - TIMER) / TICKS_PER_SECOND
			GOSUB display_time_left
			IF TIMER < t THEN GOTO red_loop
		red = OFF

#start_green
		green = ON
		GOSUB buzz

		TIMER = 0
		t = TIMER + green_time
#green_loop
			'Do something meaningful, like updating the display
			lcd_temp = (t - TIMER) / TICKS_PER_SECOND
			GOSUB display_time_left
			IF TIMER < t THEN GOTO green_loop

		green = OFF

#start_orange
		orange = ON

		TIMER = 0
		t = TIMER + ORANGE_TIME
#orange_loop
			'Do something meaningful, like updating the display
			lcd_temp = (t - TIMER) / TICKS_PER_SECOND
			GOSUB display_time_left
			IF TIMER < t THEN GOTO orange_loop

		orange = OFF
		
		IF j = 0 THEN GOSUB toggle_ab
	NEXT j
	
	IF round_proef THEN GOSUB toggle_ab
	
	lcd_temp = 0
	GOSUB display_time_left
	
#start_collect
	red = ON
	GOSUB buzz
	GOSUB buzz
	GOSUB buzz

	FOR t = 0 TO 1
#collect_loop
		red = ON
		PAUSE 25
		red = OFF
		PAUSE 50
		'GOTO collect_loop
	NEXT t	
RETURN

#set_round_display
	' Set cursor at 1:0
	lcd_param = lcd_line1
	GOSUB lcd_cmd
	
	' Write either Proef or just blanks
	FOR j = 0 TO 4
		IF round_proef = ON THEN LOOKTAB round_display, j, lcd_param ELSE lcd_param = 32
		GOSUB lcd_put
	NEXT j
	' Write Ronde
	FOR j = 5 TO 10
		LOOKTAB round_display, j, lcd_param
		GOSUB lcd_put
	NEXT j
	
	lcd_temp = i ' i contains current Round
	GOSUB lcd_print_digit_2
	
	lcd_param = SLASH
	GOSUB lcd_put
	
	lcd_temp = rounds
	GOSUB lcd_print_digit_2
RETURN

#set_round_controls
	' Set cursor at 2:0
	lcd_param = lcd_line2
	GOSUB lcd_cmd
	
	FOR j = 0 TO 15
		LOOKTAB round_controls, j, lcd_param
		GOSUB lcd_put
	NEXT j
RETURN

#display_time_left
	lcd_param = lcd_line2 + 13
	GOSUB lcd_cmd
	GOSUB lcd_print_digit
RETURN

'							 0123456789ABCDEF
ASCIITABLE round_display	"ProefRonde XX/XX"
ASCIITABLE round_controls	"* Nood          "
