' Test Toetsenbord

DEFINE keys AD[8]

DEFINE now BYTE
DEFINE last BYTE
DEFINE value BYTE

#loop
last = now
now = get_key
IF now <> last THEN GOSUB print_now
GOTO loop
END

#print_now
IF now <= 9 THEN PRINT now
IF now = 10 THEN PRINT "*"
IF now = 11 THEN PRINT "#"
RETURN

#get_key
' * => 10
' # => 11
' Niets => 255
value = keys
IF value >= 85  AND value <= 90  THEN RETURN 0
IF value >= 65  AND value <= 70  THEN RETURN 1
IF value >= 150 AND value <= 155 THEN RETURN 2
IF value >= 235 AND value <= 240 THEN RETURN 3
IF value >= 45  AND value <= 50  THEN RETURN 4
IF value >= 130 AND value <= 135 THEN RETURN 5
IF value >= 210 AND value <= 215 THEN RETURN 6
IF value >= 20  AND value <= 25  THEN RETURN 7
IF value >= 110 AND value <= 115 THEN RETURN 8
IF value >= 190 AND value <= 195 THEN RETURN 9
IF value >= 0   AND value <= 5   THEN RETURN 10
IF value >= 170 AND value <= 175 THEN RETURN 11
RETURN 255

