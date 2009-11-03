' This file is part of 'Buiten Wedstrijd Installatie' - HBSV Assumburg
' (C) 2009 Paul Hooijenga - <phooijenga@gmail.com>
' $Id$
'

DEFINE SLASH 47

#round
	GOSUB show_abcd
	
	FOR j = 0 TO 1
#start_red
		red = ON
		GOSUB buzz
		GOSUB buzz

		TIMER = 0
		t = TIMER + RED_TIME
#red_loop
			' Display number of seconds left
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
			' Display number of seconds left
			lcd_temp = (t - TIMER) / TICKS_PER_SECOND
			GOSUB display_time_left
			IF TIMER < t THEN GOTO green_loop

		green = OFF

#start_orange
		orange = ON

		TIMER = 0
		t = TIMER + ORANGE_TIME
#orange_loop
			' Display number of seconds left
			lcd_temp = (t - TIMER) / TICKS_PER_SECOND
			GOSUB display_time_left
			IF TIMER < t THEN GOTO orange_loop

		orange = OFF
		
		IF j = 0 THEN GOSUB toggle_ab
	NEXT j
	
	IF round_proef THEN GOSUB toggle_ab
	
	lcd_temp = 60
	GOSUB display_time_left

#start_collect
	GOSUB set_collect_controls
	
	red = ON
	GOSUB buzz
	GOSUB buzz
	GOSUB buzz

	TIMER = 0
	t = TIMER + COLLECT_MIN_TIME
#collect_loop_1
		red = ON
		PAUSE 25
		red = OFF
		PAUSE 50
		lcd_temp = (t - TIMER) / TICKS_PER_SECOND
		GOSUB display_time_left
		IF TIMER < t THEN GOTO collect_loop_1

#collect_loop_2
		red = ON

		TIMER = 0
		t = TIMER + 25
#collect_loop_2_red
			GOSUB get_key
			IF TIMER < t AND key_nr <> 11 THEN GOTO collect_loop_2_red
		
		IF key_nr = 11 THEN GOTO collect_loop_2_end
		
		red = OFF
					
		TIMER = 0
		t = TIMER + 50
#collect_loop_2_not_red
			GOSUB get_key
			IF TIMER < t AND key_nr <> 11 THEN GOTO collect_loop_2_not_red

		IF key_nr = 11 THEN GOTO collect_loop_2_end ELSE GOTO collect_loop_2
	
#collect_loop_2_end	
	red = OFF
	
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

#set_collect_controls
	' Set cursor at 2:0
	lcd_param = lcd_line1
	GOSUB lcd_cmd

	FOR j = 0 TO 15
		LOOKTAB collect_display, j, lcd_param
		GOSUB lcd_put
	NEXT j
	
	' Set cursor at 2:0
	lcd_param = lcd_line2
	GOSUB lcd_cmd
	
	FOR j = 0 TO 9
		LOOKTAB collect_controls, j, lcd_param
		GOSUB lcd_put
	NEXT j

#display_time_left
	lcd_param = lcd_line2 + 13
	GOSUB lcd_cmd
	GOSUB lcd_print_digit
RETURN

'							 0123456789ABCDEF
ASCIITABLE round_display	"ProefRonde XX/XX"
ASCIITABLE round_controls	"* Nood          "
ASCIITABLE collect_display	"  Pijlen Halen  "
ASCIITABLE collect_controls "# Volgende      "

