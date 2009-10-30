' Test Toetsenbord

DEFINE keys AD[8]

DEFINE now BYTE
DEFINE last BYTE
DEFINE value BYTE
DEFINE i BYTE

#loop
last = now
now = get_key
IF now <> last THEN GOSUB print_now
GOTO loop
END

#print_now
IF now < 10 THEN PRINT now
IF now = 10 THEN PRINT "*"
IF now = 11 THEN PRINT "#"
RETURN

#get_key
' * => 10
' # => 11
' Niets => 255
value = keys
FOR i = 0 TO 11
	IF value < 11 + i * 23 THEN GOTO get_key_lookup
NEXT i
RETURN 255
#get_key_lookup
LOOKTAB get_key_table, i, value
RETURN value
TABLE get_key_table
	10 7 4 1
	 0 8 5 2
	11 9 6 3
TABEND

