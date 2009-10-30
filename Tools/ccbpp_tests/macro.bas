' Define Test

#define LOOP (var, start, stop) FOR %var = %start TO %stop

DEFINE i	BYTE

%LOOP (i, 0, 10)
	PRINT i
NEXT i

