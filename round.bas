' This file is part of 'Buiten Wedstrijd Installatie' - HBSV Assumburg
' (C) 2009 Paul Hooijenga - <phooijenga@gmail.com>
' $Id$
'

DEFINE SLASH 47

#round
	GOSUB set_round_display
	GOSUB set_round_controls
	GOSUB show_abcd
	
	FOR archer = 1 TO 2
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
			
			GOSUB get_key
			IF key_nr = KEY_STAR THEN GOSUB panic_button
			IF key_nr = 0 THEN GOSUB pause_button
			IF key_nr = KEY_HASH THEN t = TIMER
			
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
			
			GOSUB get_key
			IF key_nr = KEY_STAR THEN GOSUB panic_button
			IF key_nr = 0 THEN GOSUB pause_button
			IF key_nr = KEY_HASH THEN t = TIMER
			
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
			
			GOSUB get_key
			IF key_nr = KEY_STAR THEN GOSUB panic_button
			IF key_nr = 0 THEN GOSUB pause_button
			IF key_nr = KEY_HASH THEN t = TIMER
			
			IF TIMER < t THEN GOTO orange_loop

		orange = OFF
		
		IF archer = 1 THEN GOSUB toggle_ab
	NEXT archer
	
	IF round_proef THEN GOSUB toggle_ab
	
	'lcd_temp = 60
	'GOSUB display_time_left

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
		'lcd_temp = (t - TIMER) / TICKS_PER_SECOND
		'GOSUB display_time_left
		IF TIMER < t THEN GOTO collect_loop_1

#collect_loop_2
		red = ON

		TIMER = 0
		t = TIMER + 25
#collect_loop_2_red
			GOSUB get_key
			IF TIMER < t AND key_nr <> KEY_HASH THEN GOTO collect_loop_2_red
		
		IF key_nr = KEY_HASH THEN GOTO collect_loop_2_end
		
		red = OFF
					
		TIMER = 0
		t = TIMER + 50
#collect_loop_2_not_red
			GOSUB get_key
			IF TIMER < t AND key_nr <> KEY_HASH THEN GOTO collect_loop_2_not_red

		IF key_nr = KEY_HASH THEN GOTO collect_loop_2_end ELSE GOTO collect_loop_2
	
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
	%LCD_PRINT_SUBSTRING (round_display, j, 5, 10)
	
	' Set cursor at 1:11
	lcd_param = lcd_line1 + 11
	GOSUB lcd_cmd
	
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
	%LCD_PRINT_STRING (round_controls, j)
RETURN

#set_collect_controls
	' Set cursor at 2:0
	lcd_param = lcd_line1
	GOSUB lcd_cmd
	%LCD_PRINT_STRING (collect_display, j)
	
	' Set cursor at 2:0
	lcd_param = lcd_line2
	GOSUB lcd_cmd
	%LCD_PRINT_STRING (collect_controls, j)
RETURN

#display_time_left
	lcd_param = lcd_line2 + 13
	GOSUB lcd_cmd
	GOSUB lcd_print_digit
RETURN

#pause_button
	'Store the amount of time left
	time_left = t - TIMER
	
	lcd_param = lcd_line2
	GOSUB lcd_cmd
	%LCD_PRINT_STRING (pause_controls, j)
	
#pause_loop
	GOSUB get_key
	IF key_nr <> 0 THEN GOTO pause_loop
	
	GOSUB set_round_controls
	
	' Restore amount of time left
	TIMER = 0
	t = TIMER + time_left
RETURN

'							 0123456789ABCDEF
ASCIITABLE round_display	"ProefRonde XX/XX"
ASCIITABLE round_controls	"*\x7ENood #\x7ESkip   "
ASCIITABLE collect_display	"  Pijlen Halen  "
ASCIITABLE collect_controls "#\x7EVolgende Ronde"
ASCIITABLE pause_controls	"Pause 0\x7EDoorgaan"

