' This file is part of 'Buiten Wedstrijd Installatie' - HBSV Assumburg
' (C) 2009 Paul Hooijenga - <phooijenga@gmail.com>
' $Id$
'

#panic_button
	' Store the amount of time left
	time_left = t - TIMER
	
	' Store the current state of the lights
	panic_red = red
	red = ON
	panic_orange = orange
	orange = OFF
	panic_green = green
	green = OFF

	' Signal five times	
	GOSUB buzz
	GOSUB buzz
	GOSUB buzz
	GOSUB buzz
	GOSUB buzz
	
	' Display the panic text and controls
	lcd_param = lcd_line1
	GOSUB lcd_cmd
	%LCD_PRINT_STRING (panic_display, j)

	lcd_param = lcd_line2
	GOSUB lcd_cmd
	%LCD_PRINT_STRING (panic_controls, j)

	' Blink red light repeatedly
#panic_loop	
		red = ON
		TIMER = 0
		t = TIMER + 15
#panic_loop_red
			GOSUB get_key
			IF key_nr = KEY_HASH THEN GOTO panic_end
			IF t - TIMER > 0 THEN GOTO panic_loop_red
		
		red = OFF
		TIMER = 0
		t = TIMER + 15
#panic_loop_not_red
			GOSUB get_key
			IF key_nr = KEY_HASH THEN GOTO panic_end
			IF t - TIMER > 0 THEN GOTO panic_loop_not_red
	
		GOTO panic_loop
		
#panic_end
	' Display 20 seconds of Red
	red = ON
	TIMER = 0
	t = TIMER + PANIC_RED_TIME
#panic_red_loop
		' Display number of seconds left
		lcd_temp = (t - TIMER) / TICKS_PER_SECOND
		GOSUB display_time_left
		IF t - TIMER > 0 THEN GOTO panic_red_loop

	' Restore round display
	GOSUB set_round_display
	GOSUB set_round_controls
	
	' Restore lights
	red = panic_red
	orange = panic_orange
	green = panic_green
	
	IF panic_orange = ON THEN GOTO panic_was_orange
	IF panic_red = ON THEN GOTO panic_was_red
	
#panic_was_green
	' Give the archers an extra 30 seconds of green
	IF time_left < PANIC_BACK_TIME THEN time_left = green_time ELSE time_left = time_left + PANIC_BACK_TIME
	
	' Restore the amount of time left
	TIMER = 0
	t = TIMER + time_left
RETURN

#panic_was_orange
	orange = OFF
	green = ON

	' Round is set back 30 seconds, which is almost always in Green
	TIMER = 0
	t = TIMER + (PANIC_BACK_TIME - (ORANGE_TIME - time_left))
#panic_was_orange_green_loop
		' Display number of seconds left
		lcd_temp = (t - TIMER) / TICKS_PER_SECOND
		GOSUB display_time_left
		
		IF t - TIMER > 0 THEN GOTO panic_was_orange_green_loop
	
	' Set the time left back to the full Orange time
	green = OFF
	orange = ON
	TIMER = 0
	t = TIMER + ORANGE_TIME
RETURN

#panic_was_red
	' Do not restore amount of time left, b/c there was already Red
	t = TIMER
RETURN

ASCIITABLE panic_display	"    Noodstop    "
ASCIITABLE panic_controls	"#\x7EDoorgaan      "

