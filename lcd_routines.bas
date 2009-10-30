#lcd_init
	lcd_port = &h38

	lcd_port = &b10000011
	PULSE lcd_enable
	pause 1
	lcd_port = &b10000011
	pulse lcd_enable

	lcd_port = &b10000011
	pulse lcd_enable

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

