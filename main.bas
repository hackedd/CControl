' This file is part of 'Buiten Wedstrijd Installatie' - HBSV Assumburg
' (C) 2009 Paul Hooijenga - <phooijenga@gmail.com>
' $Id$
'

#include "lcd_header.bas"	' 2 BYTEs
#include "key_header.bas"	' 2 BYTEs

DEFINE red		PORT[1]
DEFINE orange 	PORT[2]
DEFINE green 	PORT[3]
DEFINE buzzer 	PORT[4]
DEFINE A 		PORT[5]
DEFINE B 		PORT[6]
DEFINE C 		PORT[7]
DEFINE D 		PORT[8]

DEFINE menu_option	BYTE
DEFINE i			BYTE
DEFINE j			BYTE
DEFINE rounds		BYTE
DEFINE blaat		BYTE

DEFINE options		BYTE[10]
DEFINE half			BIT[81]
DEFINE long			BIT[82]
DEFINE proef		BIT[83]
DEFINE round_proef	BIT[84]
DEFINE round_ab		BYTE 'BIT[85]

DEFINE t			WORD ' 11 & 12

DEFINE green_time	BYTE

' Magic Constants
DEFINE RED_TIME		400 '20 sec
DEFINE ORANGE_TIME	3 '30 sec
DEFINE GREEN_TIME_LONG 2 '240 sec
DEFINE GREEN_TIME_SHORT 1 '120 sec

' Initialize LCD Screen
GOSUB lcd_init

' Store our custom chars in the LCD's Memory
GOSUB custom_chars_setup

' Default Settings
half = OFF
long = OFF
proef = ON

' Start at Metric Option
menu_option = 2

#include "menu.bas"

#start_proef
	IF long = ON THEN green_time = GREEN_TIME_LONG ELSE green_time = GREEN_TIME_SHORT
	
	IF proef = OFF THEN GOTO start_round_1
	
	round_proef = ON
	IF long THEN rounds = 1 ELSE rounds = 2
	
	FOR i = 1 TO rounds
		GOSUB set_round_display

		GOSUB show_ab
		GOSUB red_green_orange_cycle
		
		GOSUB show_cd
		GOSUB red_green_orange_cycle
		' Collect Arrows
	NEXT i
	
#start_round_1
	' Do nothing for now...
	GOSUB lcd_cls
	
	A = OFF
	B = OFF
	C = OFF
	D = OFF
	
	END

#include "round.bas"

#include "lcd_chars.bas"
#include "lcd_routines.bas"
#include "key_routines.bas"
#include "signal_routines.bas"
#include "test_routines.bas"

