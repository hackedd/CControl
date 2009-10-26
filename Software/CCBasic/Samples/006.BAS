'********************************************************************
'
' C-Control/BASIC       006.BAS
'
' Systemvoraussetzungen:
'
' - Low-Current-LEDs an Port 1 bis Port 8, Vorwiderstand ca. 1k,
'   alle Kathoden nach GND 
'
' Schwerpunkte:
'
' - Definition und Schalten von Digitalports
' - die Befehle TOG und DEACT
' - Hexadezimal- und Binaerzahlendarstellung
' - der PAUSE-Befehl zur Steuerung des zeitlichen Programmablaufs
' - mehrere Anweisungen in einer Zeile - mit Doppelpunkt getrennt
'
' Neben dem Gewinnen von Erfahrungen bezueglich der genannten
' Schwerpunkte koennen Sie hier auch die Funktion der roten
' System-LED gut erkennen. Waehrend der PAUSE-Zeiten ist sie
' ausgeschaltet, bei allen anderen Programmoperationen eingeschaltet.
' Sie bietet somit eine zusaetzliche optische Kontrolle der
' Programmfunktion.
'********************************************************************

' --- Definitionen --------------------------------------------------

' alle LEDs zusammen
define leds byteport[1]

' einzelne LEDs
define led1 port[1]
define led2 port[2]
define led3 port[3]
define led4 port[4]
define led5 port[5]
define led6 port[6]
define led7 port[7]
define led8 port[8]

' eine Schleifenvariable
define k byte

' --- Programmoperationen -----------------------

' alle LEDs an- und ausschalten, dazwischen eine Sekunde Pause
' dazu muessen alle Bits an Port 1 (leds) gesetzt werden,
' dafuer gibt es vier syntaktische Moeglichkeiten:

' Dezimal-Variante:

  leds = 255
  pause 50              ' 50 x 20ms = 1000ms = 1s 
  leds = 0
  pause 50

' Hexadezimal-Variante:

  leds = &HFF	
  pause 50
  leds = &H00
  pause 50

' Binaer-Variante:

  leds = &B11111111
  pause 50
  leds = &B00000000
  pause 50

' ON/OFF-Variante:

  leds = ON
  pause 50
  leds = OFF
  pause 50

' die LEDs sind jetzt 4x ein- und ausgeschaltet worden

' die Binaer-Variante ist bei der Ausgabe von Bitmustern
' am besten ueberschaubar, da jede 1 einem gesetzten und
' jede 0 einem ausgeschalteten Port entspricht,
' hier noch ein paar Bitmuster-Beispiele mit jeweils
' 500 ms Pause dazwischen:

  leds = &B00011000
  pause 25              ' 25 x 20ms = 500ms
  leds = &B00100100
  pause 25
  leds = &B01000010
  pause 25
  leds = &B10000001
  pause 25

' Ausgabe aller moeglichen Zust„nde eines Byte-Ports mit 100ms
' Pause dazwischen

  for k = 0 to 255
    leds = k
    pause 5            ' 5 x 20ms = 100ms
  next

' alle LEDs sind nun eingeschaltet, jetzt soll der DEACT-Befehl
' demonstriert werden:

  deact leds

' achten Sie auf die LEDs - sie leuchten sehr schwach, sind aber nicht
' ausgeschaltet. Ursache dafuer ist, dass die LED-Ports deaktiviert
' wurden und jetzt allein der Strom durch die 10k-Pull-Up-Widerstaende
' die LEDs leicht glimmen laesst. In diesem Zustand befinden sich alle
' Ports nach dem Reset oder dem Einschalten der Betriebsspannung.

' 5 Sekunden Pause, dann werden die LEDs ausgeschaltet, um nocheinmal
' den Unterschied zwischen "ausgeschaltet" und "deaktiviert" zu zeigen:

  pause 250            ' 250 x 20ms = 5000ms = 5s
  leds = 0
  pause 250            

' nun ein kleines Lauflicht-Beispiel, hier wird gezeigt, wie der
' Stand von Portvariablen jederzeit fuer Berechnungen herangezogen
' werden kann

  leds = &B10000000

  for k = 1 to 8
    pause 20
    leds = leds shr 1
  next

' der TOG-Befehl dient zum Umschalten einzelner Ausgabeports,
' er wirkt nur auf aktive Ports

  tog led8
  pause 25
  tog led8
  pause 25
  tog led8
  pause 25
  tog led8
  pause 25

' abschliessend werden jetzt alle LEDs einzeln geschaltet,
' ausserdem wird gezeigt, wie mehrere Anweisungen in einer Zeile
' geschrieben werden koennen

  led1 = ON :  pause 20
  led2 = ON :  pause 20
  led3 = ON :  pause 20
  led4 = ON :  pause 20
  led5 = ON :  pause 20
  led6 = ON :  pause 20
  led7 = ON :  pause 20
  led8 = ON :  pause 20

  led8 = OFF :  pause 20 : led7 = OFF :  pause 20
  led6 = OFF :  pause 20 : led5 = OFF :  pause 20
  led4 = OFF :  pause 20 : led3 = OFF :  pause 20
  led2 = OFF :  pause 20 : led1 = OFF :  pause 20


' Ports deaktivieren und Programmende
  deact leds
end





