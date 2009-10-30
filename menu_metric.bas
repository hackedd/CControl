' This file is part of 'Buiten Wedstrijd Installatie' - HBSV Assumburg
' (C) 2009 Paul Hooijenga - <phooijenga@gmail.com>
' $Id$
'

#menu_render_metric
	' Render Metric:
	FOR i = 0 TO 7
		LOOKTAB menu_metric, i, lcd_param
		GOSUB lcd_put
	NEXT i
	
	' Render currently selected metric option
	j = 0
	IF long = ON THEN j = j + 8
	IF half = ON THEN j = j + 16
	FOR i = j TO j + 7
		LOOKTAB menu_metric_o, i, lcd_param
		GOSUB lcd_put
	NEXT i
RETURN

#menu_metric_left
	' Your basic four item endless list, going up
	IF long = OFF AND half = OFF THEN GOTO menu_metric_is_half_l
	IF long = ON  AND half = OFF THEN GOTO menu_metric_is_short
	IF long = OFF AND half = ON  THEN GOTO menu_metric_is_long
	IF long = ON  AND half = ON  THEN GOTO menu_metric_is_half_s

#menu_metric_right
	' Your basic four item endless list, going down
	IF long = OFF AND half = OFF THEN GOTO menu_metric_is_long
	IF long = ON  AND half = OFF THEN GOTO menu_metric_is_half_s
	IF long = OFF AND half = ON  THEN GOTO menu_metric_is_half_l
	IF long = ON  AND half = ON  THEN GOTO menu_metric_is_short
	
#menu_metric_is_short
	long = OFF
	half = OFF
RETURN
	
#menu_metric_is_long
	long = ON
	half = OFF
RETURN
	
#menu_metric_is_half_s
	long = OFF
	half = ON
RETURN
	
#menu_metric_is_half_l
	long = ON
	half = ON
RETURN
