' Test Display

'-----------------------------------------------------------------
' Portbelegung des LCDs an der Open-Mini:
'  PTB.0       D4  (Datenleitung des LCDs, 4Bit-Mode)
'  PTB.1       D5  (Datenleitung des LCDs, 4Bit-Mode)
'  PTB.2       D6  (Datenleitung des LCDs, 4Bit-Mode)
'  PTB.3       D7  (Datenleitung des LCDs, 4Bit-Mode)
'  PTB.4       R/W (Read/Write)
'  PTB.5       RS  (Register Select)
'  PTB.6       En  (Enable)
'  PTB.7       LCD-Beleuchtung
'-----------------------------------------------------------------

DEFINE lcd_port		BYTEPORT[2]
DEFINE lcd_rs		PORT[14]
DEFINE lcd_rw		PORT[13]
DEFINE lcd_enable	PORT[15]

DEFINE lcd_param 	BYTE
DEFINE lcd_temp		BYTE

DEFINE lcd_line1	&h80
DEFINE lcd_line2	&hC0

DEFINE i			BYTE

GOSUB lcd_init

i = 0
#loop1
	LOOKTAB hello, i, lcd_param
	PRINT lcd_param
	IF lcd_param = 0 THEN GOTO break1
	GOSUB lcd_put
	i = i + 1
	GOTO loop1
#break1

lcd_param = lcd_line2 + 5
GOSUB lcd_cmd

i = 0
#loop2
	LOOKTAB world, i, lcd_param
	PRINT lcd_param
	IF lcd_param = 0 THEN GOTO break2
	GOSUB lcd_put
	i = i + 1
	GOTO loop2
#break2

lcd_param = &B01000000
GOSUB lcd_cmd

FOR i = 0 TO 7
	LOOKTAB smiley, i, lcd_param
	GOSUB lcd_put
NEXT 

lcd_param = lcd_line2
GOSUB lcd_cmd
lcd_param = 0
GOSUB lcd_put

END

TABLE smiley
	&H00 &H0A &H00 &H04 &H04 &H11 &H1F &H00
TABEND

TABLE hello
	72 101 108 108 111 0
TABEND
TABLE world
	87 111 114 108 100 0
TABEND

#lcd_init
lcd_port = &h38

'function set 8 bit
lcd_port = &b10000011
PULSE lcd_enable
pause 1
lcd_port = &b10000011
pulse lcd_enable

lcd_port = &b10000011
pulse lcd_enable

' function set 4 bit
lcd_port = &b10000010
pulse lcd_enable

lcd_param = &h28
GOSUB lcd_cmd
lcd_param = &h0C
GOSUB lcd_cmd
lcd_param = &h06
GOSUB lcd_cmd
 
#lcd_cls
lcd_param = &h01
GOSUB lcd_cmd
PAUSE 1
RETURN

#lcd_cmd
lcd_rs = 0
GOTO lcd_write

#lcd_put
lcd_rs = 1

#lcd_write
lcd_port = (lcd_port AND &hF0) or (lcd_param SHR 4)
PULSE lcd_enable
lcd_port = (lcd_port AND &hF0) or (lcd_param AND &h0F)
PULSE lcd_enable
RETURN

#lcd_print_digit
IF lcd_temp > 99 THEN lcd_param = (lcd_temp / 100) + &h30          ELSE lcd_param = &h20
GOSUB lcd_put
#lcd_print_digit_2
IF lcd_temp > 9  THEN lcd_param = ((lcd_temp MOD 100) / 10) + &h30 ELSE lcd_param = &h20
GOSUB lcd_put
#lcd_print_digit_1
lcd_param = (lcd_temp MOD 10) + &h30
GOSUB lcd_put
RETURN

END

