DEFINE red		PORT[1]
DEFINE orange 	PORT[2]
DEFINE green 	PORT[3]
DEFINE buzzer 	PORT[4]
DEFINE A 		PORT[5]
DEFINE B 		PORT[6]
DEFINE C 		PORT[7]
DEFINE D 		PORT[8]

DEFINE t		BYTE
DEFINE archer	BYTE
DEFINE round	BYTE
DEFINE ab		BYTE

DEFINE green_time	BYTE

' Magic Constants
DEFINE RED_TIME		2 '20
DEFINE ORANGE_TIME	3 '30

green_time = 3

ab = ON

FOR round = 0 TO 1
	GOSUB show_abcd
	
	FOR archer = 0 TO 1
#start_rood
		red = ON
		GOSUB buzz
		GOSUB buzz

		FOR t = 0 to RED_TIME * 2
			PAUSE 25
		NEXT t
		red = OFF

#start_green
		green = ON
		GOSUB buzz

		FOR t = 0 to green_time * 2
			PAUSE 25
		NEXT t
		green = OFF

#start_orange
		orange = ON
		FOR t = 0 to ORANGE_TIME * 2
			PAUSE 25
		NEXT t
		orange = OFF
		
		IF archer = 0 THEN GOSUB toggle_ab
		PRINT "Archer: "; archer
	NEXT archer
	
	PRINT "-Archer: "; archer
	PRINT "Round: "; round
	
#start_collect
	red = ON
	GOSUB buzz
	GOSUB buzz
	GOSUB buzz

	FOR t = 0 TO 10
#collect_loop
		red = ON
		PAUSE 25
		red = OFF
		PAUSE 50
		'GOTO collect_loop
	NEXT t
NEXT round

A = OFF
B = OFF
C = OFF
D = OFF

END

#buzz
	BEEP 400, 50, 25
	RETURN
	buzzer = ON
	PAUSE 50
	buzzer = OFF
	PAUSE 25
RETURN

#toggle_ab
	ab = NOT ab

#show_abcd
	IF ab THEN GOTO show_ab
	A = OFF
	B = OFF
	C = ON
	D = ON
RETURN
#show_ab
	C = OFF
	D = OFF
	A = ON
	B = ON
RETURN
