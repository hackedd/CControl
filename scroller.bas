#include "lcd_header.bas"

DEFINE SCROLLER_DELAY	5	
DEFINE scroller_offset	BYTE
DEFINE scroller_length	BYTE
DEFINE scroller_pos 	BYTE
DEFINE i				BYTE

GOSUB lcd_init

scroller_offset = lcd_line1
scroller_length = 25
scroller_pos = 0

#scroller_loop
	lcd_param = scroller_offset
	GOSUB lcd_cmd

	FOR i = scroller_pos TO scroller_pos + lcd_width
		LOOKTAB scroller_message, i MOD scroller_length, lcd_param
		GOSUB lcd_put
	NEXT i
	scroller_pos = scroller_pos + 1
	IF scroller_pos > 2 * scroller_length THEN scroller_pos = 0
	PAUSE SCROLLER_DELAY
	GOTO scroller_loop

END

ASCIITABLE scroller_message "This is a long message - "

#include "lcd_routines.bas"

