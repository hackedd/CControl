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
DEFINE lcd_light	PORT[16]

DEFINE lcd_param 	BYTE
DEFINE lcd_temp		BYTE

GOSUB lcd_init
lcd_param = 65
GOSUB lcd_put
END

#lcd_init
lcd_port = &h38
lcd_port = &B10000010
PULSE lcd_enable

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
'POP lcd_param
lcd_rs = 0
GOTO lcd_write

#lcd_put
'POP lcd_param
lcd_rs = 1

#lcd_write
lcd_port = (lcd_port AND &hF0) or (lcd_param SHR 4)
PULSE lcd_enable
lcd_port = (lcd_port AND &hF0) or (lcd_param AND &h0F)
PULSE lcd_enable
RETURN

#lcd_print_digit
IF lcd_temp > 99 THEN lcd_param = (lcd_temp / 100) + &h30         ELSE lcd_param = &h20
GOSUB lcd_put
#lcd_print_digit_2
IF lcd_temp > 9  THEN lcd_param = ((lcd_temp MOD 100) / 10) + &h30 ELSE lcd_param = &h20
GOSUB lcd_put
#lcd_print_digit_1
lcd_param = (lcd_temp MOD 10) + &h30
GOSUB lcd_put
RETURN

END

