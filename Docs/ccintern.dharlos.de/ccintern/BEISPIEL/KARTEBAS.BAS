
' Die ersten 256 Bytes von einer Chip-Karte (z.B. Telefonkarte)
' lesen und im Hexadezimal-Format ausgeben lassen.
' (p) Dietmar Harlos, 30. November 1999

' Als Chipkarten-Kontaktier-Einrichtung wurde in diesem Beispiel die
' sehr teure (19.95 DM) Conrad-Electronic-Bestellnummer 730521 benutzt.
' Der erste Pin der Chipkarte liegt auf Dauer-Plus (+5V). Bei Verwendung
' einer M-Unit ist zu beachten, dass Pin sieben der Chipkarte (I/O-Pin)
' mit einem Pull-Up-Widerstand (z.B. 10 kOhm) auf +5V gezogen werden muss!
' Die Kontaktier-Einrichtung hat ausserdem einen Schliesser, der anzeigt,
' ob eine Karte eingesteckt ist. Auch dieser braucht einen Pull-Up-Widerstand.
' Es sollte eine Kontaktier-Einrichtung mit nicht schleifenden Kontakten
' verwendet werden.

' Informationen zum Format von Telefonkarten am Ende dieser Datei!!

' ------------------------
' |    1     |      5    |  Kontaktierflaeche einer Chipkarte nach ISO 7816-2
' |____      |       ____|
' |    \____/    ___/    |  Pin 1 = Vcc (+5 Volt, Betriebsspannung)
' |  2    |     |     6  |  Pin 2 = Reset
' |_______|     |________|  Pin 3 = Clock
' |       |     |        |  Pin 4 = n.c. (meistens nicht vorhanden)
' |  3  __|_____|__   7  |  Pin 5 = GND (Masse)
' |____/     |     \_____|  Pin 6 = n.c. (evt. Vpp)
' |          |           |  Pin 7 = I/O
' |   (4)    |     (8)   |  Pin 8 = n.c. (meistens nicht vorhanden)
' |__________|___________|

define reset port [1]  ' RESET ist der zweite Pin der Chipkarte
define clock port [2]  ' CLOCK ist der dritte Pin
define io port [3]     ' I/O ist der siebte Pin (Pull-Up-Widerst. verwenden!)
define leer port [4]   ' Schliesser (ebenfalls Pull-Up-Widerst. verwenden!)

define n byte          ' Zaehler fuer gelesene Bytes (0..255)
define i byte          ' Zaehler fuer gelesene Bits (0..7)
define b byte          ' gelesenes Byte von der Karte

clock=off
reset=off

#endlos
  print
  print "Bitte Karte einlegen"
  wait leer=off        ' warten, bis Karte eingelegt wird
  pause 10
  
  reset=on             ' Karte resetten
  pulse clock          ' (eigentlich muss RESET waehrend des Lesens der
  reset=off            '  ersten 16 Bits gesetzt sein, aber so geht's auch)

  for n=0 to 255
  
    if (n mod 16)<>0 then goto ueber
      print            ' aktuelle "Adresse" ausgegeben (alle 16 Bytes)
      b=n
      gosub hex
      print ":";
    #ueber
    
    b=0
    for i=0 to 7       ' 8 Bits (ein Byte) von der Chipkarte lesen
      if io then b=(b shl 1) or 1 else b=b shl 1
      pulse clock
    next i
    print " ";
    gosub hex          ' das Byte hexadezimal ausgeben
    
  next n
  print

  print
  print "Bitte Karte entnehmen"
  wait leer=on         ' warten, bis Karte entfernt wird
  pause 10
goto endlos


' Variable b hexadezimal ausgeben (ohne weitere Variable zu benutzen)

#hex
 put 36
 if (b shr 4)>9 then put (b shr 4)+87 else put (b shr 4)+48
 if (b and 15)>9 then put (b and 15)+87 else put (b and 15)+48
return


' Informationen zu Telefonkarten:
' ===============================

' Eine Telefonkarte gibt 64 Bytes aus. Wenn darueber hinaus weitergelesen
' wird, finden ein Ueberlauf des internen Adresszaehlers statt und die
' ersten 64 Bytes werden immer wieder ausgegeben.

' Byte Nr. | Bit Nr. | binaer    | hex | Bedeutung

'    1     | 1-8     | 1101 1000 | $d8 | ???, auch $dd moeglich
'    2     | 9-16    | 0010 1111 | $2f | Land ($2f = Deutschland)     
'    3     | 17-24   | 1111 1111 | $ff | ???, auch $fc und $2f moeglich
'    4     | 25-32   | 1100 1010 | $ca | ???, auch $2a und $4a moeglich
'    5     | 33-40   | 1010 0001 | $a1 | 1. Nibble: Nennwert (1010=12 DM)
'          |         |           |     | 2. Nibble: Herausgabe- oder Ungueltig-
'          |         |           |     | keitsjahr (1990+n oder 2000+n) (?)
'    6     | 41-48   |           |     | 1. Nibble: Herausgabemonat (?)
'          |         |           |     | 2. Nibble: 9. Stelle Seriennummer
'    7     | 49-56   |           |     | 1. Nibble: 8. Stelle Seriennummer
'          |         |           |     | 2. Nibble: 7. Stelle Seriennummer
'    8     | 57-64   |           |     | 1. Nibble: 6. Stelle Seriennummer
'          |         |           |     | 2. Nibble: 5. Stelle Seriennummer
'    9     | 65-72   | 0000 0000 | $00 | 4096 * (Anzahl Bits) Pfennige
'   10     | 73-80   | 0000 0011 | $03 |  512 * (Anzahl Bits) Pfennige
'   11     | 81-88   | 0000 0011 | $03 |   64 * (Anzahl Bits) Pfennige
'   12     | 89-96   | 0011 1111 | $3f |    8 * (Anzahl Bits) Pfennige
'   13     | 97-104  | 0000 0000 | $00 |    1 * (Anzahl Bits) Pfennige
'   14     | 105-112 | 1111 1110 | $fe | ???, teilweise auch $ff
'  15-64   | 113-512 | 1111 1111 | $ff | Bereich mit $ff, teilweise auch
'          |         |           |     | anders belegt

' Die Karte in diesem Beispiel ist eine neue 12 DM-Telefonkarte. Der
' aktuelle Geldwert kann durch die Wertigkeit der Bits 65 bis 104 bestimmt
' werden:

' 512*2 + 64*2 + 8*6 = 1200 Pfennige (12 DM)

' ** alle Angaben ohne Gewaehr **


