
' Die ersten 256 Bytes von einer Chip-Karte (z.B. Telefonkarte)
' lesen und im Hexadezimal-Format ausgeben lassen.
' (c) Dietmar Harlos ADPC am 4. Dezember 1999 um 18:08 MEZ

' Bitte erst KARTEASM.ASM mit einem Assembler (z.B. AS05.EXE) assemblieren
' und dann dieses BASIC-Programm kompilieren und zur C-Control-Unit
' schicken.

' FÅr Informationen zu Telefonkarten und zur erforderlichen Chipkartenlese-
' einrichtung bitte in KARTEBAS.BAS nachlesen!

syscode "karteasm.s19"
sys &h101
