'********************************************************************
'
' C-Control/BASIC       013.BAS
'
' Systemvoraussetzungen:
'
' - Low-Current-LEDs an Port 1 bis Port 8, Vorwiderstand ca. 1k,
'   alle Kathoden nach GND
' - 25k-Potentiometer, mit den Aussenkontakten
'   zwischen 5V und GND geschaltet, Schleifer verbunden
'   mit A/D 1
' - Referenzspannungseingang mit 5V verbunden
'
' Schwerpunkte:
'
' - Verwendung des Timers
' - Arbeit mit Tabellen
' - MAX-Funktion
'
' Das Programm implementiert eine Balkenanzeige für A/D 1 mit acht
' LEDs. Dabei wird der Spitzenwert fuer 5 Sekunden in der
' jeweils obersten LED gehalten.
'********************************************************************

' --- Definitionen --------------------------------------------------

define leds byteport[1]
define poti ad[1]
define key port[9]

define nexttime word
define sample byte
define peak byte

define ledmask byte
define peakmask byte

define DELAY 100		' 2 sec


' --- Programmoperationen -------------------------------------------

peak = 0
leds = OFF

' Programmschleife

#loop
  sample = poti / 31                ' 255 / 8 -> Schrittweite 31 
  looktab bartab, sample, ledmask   ' "Leuchtbalken" aus Tabelle lesen

  peak = max(sample, peak)          ' neuen Maximalwert ermitteln
  looktab peaktab, peak, peakmask   ' passende LED aus Tabelle

  leds = ledmask or peakmask        ' Max-LED mit "Leuchtbalken" kombinieren

  ' nach der Haltezeit den Maximalwert ruecksetzen
  if timer >= nexttime then gosub resetpeak

  ' Programm auf Tastendruck beenden 
  if not key then end

goto loop

#resetpeak
  peak = 0
  nexttime = timer + DELAY
return

table bartab
  &H00 &H01 &H03 &H07 &H0f  &H1f &H3F &H7F  &Hff
tabend

table peaktab
  &H00 &H01 &H02 &H04 &H08 &H10 &H20 &H40 &H80
tabend





