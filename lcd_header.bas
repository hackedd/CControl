' This file is part of 'Buiten Wedstrijd Installatie' - HBSV Assumburg
' (C) 2009 Paul Hooijenga - <phooijenga@gmail.com>
' $Id$
'

DEFINE lcd_port		BYTEPORT[2]
DEFINE lcd_rs		PORT[14]
DEFINE lcd_rw		PORT[13]
DEFINE lcd_enable	PORT[15]

DEFINE lcd_param 	BYTE
DEFINE lcd_temp		BYTE

DEFINE lcd_line1	&h80
DEFINE lcd_line2	&hC0
DEFINE lcd_width	16

#define LCD_PRINT_SUBSTRING (table, index, start, end) \
	FOR %index = %start TO %end\
		LOOKTAB %table, %index, lcd_param\
		GOSUB lcd_put\
	NEXT %index

#define LCD_PRINT_STRING (table, index) \
	FOR %index = 0 TO 15\
		LOOKTAB %table, %index, lcd_param\
		GOSUB lcd_put\
	NEXT %index

