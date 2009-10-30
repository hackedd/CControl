' This file is part of 'Buiten Wedstrijd Installatie' - HBSV Assumburg
' (C) 2009 Paul Hooijenga - <phooijenga@gmail.com>
' $Id$
'

#get_key
	FOR key_nr = 0 TO 11
		LOOKTAB key_codes, key_nr, key_compare
		IF ABS(key_value - key_compare) < 3 THEN RETURN
	NEXT
	key_nr = -1
RETURN

TABLE key_codes
	90			' 0 is out of place, to make the FOR loop work 
	68 152 235 
	46 132 214
	23 111 193
	0      173	' * = 10, # = 11
TABEND

