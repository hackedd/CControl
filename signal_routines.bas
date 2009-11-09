' This file is part of 'Buiten Wedstrijd Installatie' - HBSV Assumburg
' (C) 2009 Paul Hooijenga - <phooijenga@gmail.com>
' $Id$
'

#buzz
RETURN
	BEEP 400, 50, 25
RETURN
	buzzer = ON
	PAUSE 50
	buzzer = OFF
	PAUSE 25
RETURN

#toggle_ab
	IF round_ab = ON THEN round_ab = OFF ELSE round_ab = ON
	
#show_abcd
	IF round_ab = ON THEN GOTO show_ab
	
#show_cd
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


