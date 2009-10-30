' Custom Characters

DEFINE NUM_CHARS	3
DEFINE HEIGHT		8

#custom_chars_setup
	lcd_param = &B01000000
	GOSUB lcd_cmd

	FOR i = 0 TO NUM_CHARS * HEIGHT - 1
		LOOKTAB custom_chars, i, lcd_param
		GOSUB lcd_put
	NEXT i
RETURN

' Characters are 5 by 8
TABLE custom_chars
	'  0 Up Arrow
	&B00000100 ' ..#..
	&B00001110 ' .###.
	&B00010101 ' #.#.#
	&B00000100 ' ..#..
	&B00000100 ' ..#..
	&B00000100 ' ..#..
	&B00000100 ' ..#..
	&B00000000 ' .....

	'  1 Down Arrow
	&B00000100 ' ..#..
	&B00000100 ' ..#..
	&B00000100 ' ..#..
	&B00000100 ' ..#..
	&B00010101 ' #.#.#
	&B00001110 ' .###.
	&B00000100 ' ..#..
	&B00000000 ' .....
	
	'  2 Enter / Select
	&B00000000 ' .....
	&B00000001 ' ....#
	&B00000001 ' ....#
	&B00000101 ' ..#.#
	&B00001001 ' .#..#
	&B00011111 ' #####
	&B00001000 ' .#...
	&B00000100 ' ..#..
	
	
	&B00000000 ' .....
	&B00000000 ' .....
	&B00000000 ' .....
	&B00000000 ' .....
	&B00000000 ' .....
	&B00000000 ' .....
	&B00000000 ' .....
	&B00000000 ' .....
TABEND

