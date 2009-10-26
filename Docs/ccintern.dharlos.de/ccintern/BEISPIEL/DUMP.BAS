
' PEEK- & POKE-Funktionen fuer CCBASIC-Chip
' (c) Dietmar Harlos am 19. Juli 1999 um 06:17

' Da die dem C-Control/BASIC-Chip zugrundeliegende CPU keine 16-Bit-Zeiger
' kennt, werden diese im vorliegenden Programm durch kleine Maschinensprache-
' programme, die in der Zeropage (im RAM) liegen, nachgebildet. Leider wird
' dadurch der User-Variablenbereich eingeschraenkt. Wenn POKE nicht benoetigt
' wird, koennen die Zeilen 31 bis 37 und 15 bis 22 geloescht und so User-RAM
' gespart werden.

' Weiter unten im Listing befindet sich jeweils ein Beispiel zur Benutzung
' der PEEK- und der POKE-Funktion.

define poke &hac

define byte12 byte [12]
define pokevalue byte [13]
define byte14 byte [14]
define pokeadr word [8]
define byte17 byte [17]

define peek &hb2

define byte18 byte [18]
define peekadr word [10]
define word11 word [11]
define byte23 byte [23]
define peekresult byte [24]

' POKE initialisieren

byte12=&ha6    'LDA pokevalue
byte14=&hc7    'STA pokeadr
pokeadr=&hb8   'RTS
byte17=&h81

' PEEK initialisieren

byte18=&hc6    'LDA peekadr
word11=&hb7b8  'STA peekresult
byte23=&h81    'RTS


' Beispiel fuer PEEK:

' Senden des gesamten Speicherinhaltes des
' C-Control/BASIC-Chips ueber die RS232-Schnittstelle
' (kann z.B. mit TERMINAL.EXE empfangen und mit DI05.EXE untersucht werden)

for peekadr=0 to 8191
  sys peek
  put peekresult
next peekadr

end


' und ein POKE-Beispiel:

' Um ein Byte ins interne EEPROM (Adresse $101 bis $1ff) speichern zu koennen,
' muessen verschiedene EEPROM-Programmierbits auf Adresse 7 gesetzt werden.

' Im Manual zum MC68HC05 von Motorola steht, dass das interne EEPROM maximal
' 10000 Schreibzyklen vertraegt! Deshalb sollten die Werte im EEPROM nicht
' zu haeufig geaendert werden. Werte die sich haeufig aendern sollte man ans
' Ende des EEPROMs speichern. Dort sind eventuelle Fehler nicht ganz so
' tragisch.

peekadr=&h1ff                       'der Inhalt dieser Adresse wird geaendert

sys peek : print "Wert vor der Programmierung: ";peekresult

if ((peekresult xor (peekresult-1)) and (peekresult-1))=0 then goto ueber
print "Ich loesche die Speicherzelle"
pokeadr=7 : pokevalue=6 : sys poke  'wenn ich das Manual richtig verstanden
pokeadr=peekadr : sys poke          'habe, dann ist dieser Loeschvorgang nur
pokeadr=7 : pokevalue=7 : sys poke  'notwendig, wenn in der zu programmieren-
pause 1                             'den Speicherstelle wenigstens ein zu-
pokevalue=5 : sys poke              'saetzliches Bit gesetzt werden soll

#ueber
pokeadr=7 : pokevalue=2 : sys poke
pokeadr=peekadr : pokevalue=peekresult-1 : sys poke
pokeadr=7 : pokevalue=3 : sys poke
pause 1
pokevalue=1 : sys poke

sys peek : print "Wert nach der Programmierung: ";peekresult

end
