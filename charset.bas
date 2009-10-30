#include "lcd_header.bas"

DEFINE i BYTE
DEFINE j BYTE

GOSUB lcd_init

FOR i = 0 TO 14 STEP 2
	lcd_param = lcd_line1
	GOSUB lcd_cmd
	FOR j = 0 TO 15
		lcd_param = i * 16 + j
		GOSUB lcd_put
	NEXT j
	
	lcd_param = lcd_line2
	GOSUB lcd_cmd
	FOR j = 0 to 15
		lcd_param = 16 + i * 16 + j
		GOSUB lcd_put
	NEXT j
	
	PAUSE 100
NEXT i

END

#include "lcd_routines.bas"

