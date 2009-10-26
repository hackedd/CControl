
' Dieses CCBASIC-Programm demonstriert den Stackfehler, der fuer falsche
' ON..GOSUB-Fallunterscheidungen in BASIC-Programmen, die eine BASIC-
' Interruptroutine verwenden, verantwortlich ist.

' Die Befehle "wordv=wordv+1" und "print wordv" in der Interrupt-Routine
' am Ende dieses Programms bewirken, dass Woerter auf den Rechenstack gepusht
' werden. Da das jeweils letzte Word nicht wieder vom Stack entfernt wird,
' kommt es zu Stackfehlern im Hauptprogramm.

' Um den Fehler zu demonstrieren, muss eine Interruptquelle am IRQ-Eingang
' angeschlossen werden. Das kann eine einfache Strippe sein, mit dem
' dieser Eingang auf Masse (GND) gezogen wird. Der Fehler kann schon nach
' wenigen Interrupt-Ausloesungen auftauchen; manchmal kann es aber auch
' einige hundert Ausloesungen dauern.

' Naehere Informationen stehen in der Textdatei BUGS.TXT.

' Wie der Stackfehler behoben werden kann steht am Ende dieses Programms!


define bytev byte
define wordv word
define ausgefuehrt byte

bytev=0
wordv=0
print "Bitte jetzt den Interrupt-Pin (IRQ) viele male auf GND ziehen!"

#nochmal
  ausgefuehrt=0
  interrupt unterbrechung  ' Unterbrechungsroutine setzen
  on bytev gosub l0,l1
  if bytev=0 then bytev=1 else bytev=0
if ausgefuehrt=1 then goto nochmal
print "Fehler: Keine Subroutine ausgefuehrt!"
end

#l0
  table disableirq         ' Diese Tabelle entspricht dem BASIC-Befehl
    73 0 0                 ' "INTERRUPT 0", d.h. die Unterbrechungsroutine
  tabend                   ' wird deaktiviert
  ausgefuehrt=1
if bytev=0 then return
print "Fehler: 1 als 0 erkannt!"
end

#l1
  table disableirq2
    73 0 0
  tabend
  ausgefuehrt=1
if bytev=1 then return
print "Fehler: 0 als 1 erkannt!"
end


#unterbrechung
  wordv=wordv+1
'  sys &h101                 '[*]
  print "Interrupt Nr. ";
  print wordv
'  sys &h101                 '[*]
return interrupt

'syscode "ongosub.s19"       '[*]


' Um den Stackfehler zu beheben muss das Programm ONGOSUB.ASM  assembliert
' und in diesem Programm die Zeilen hinter denen [*] steht aktiviert werden.


' (c) by Dietmar Harlos ADPC am 11. November 1999 um 06:05 MEZ

