'********************************************************************
'
' C-Control/BASIC       004.BAS
'
' Systemvoraussetzungen:
'
' - serielle Verbindung zum PC
' - Terminalprogramm
'
' Schwerpunkte:
'
' - Aufruf einer Unterroutine mit GOSUB
' - Rueckkehr mit RETURN
'
' Das Beispiel fuehrt, bis auf die Titelzeile, zur selben
' Bildschirmausgabe wie 003.BAS. Die Ergebnisausgaben sind jedoch
' in einer Unterroutine zusammengefasst.
'********************************************************************

' --- Definitionen --------------------------------------------------

' automatische Variablen

define a word
define b word
define c byte

' Variablen mit Angabe der Speicherzelle
define x word[7]
define y byte[24]       ' letzte verfuegbare Speicherzelle
define z word[2]        ' gleiche Zelle wie autom. Variable b!

' Konstanten
define k1 100
define k2 1234
define k3 9

' --- Programmoperationen -----------------------

'Programmtitel ausgeben 
print "C-Control/BASIC      004.BAS"
print "============================"
print

' Initialisierungen
  a = 3
  b = k1                  ' b = 100
  c = 0
  x = -k2                 ' x = -1234
  y = -k3                 ' y = 247, nicht -9 (Bytes sind immer positiv)

  gosub ausgabe

' ein paar Berechnungen
  a = a + 97              ' a = 100
  b = k2 * k3 / k1        ' b = 111
  c = (17 + 4) / 7        ' c = 3
  x = abs(x)              ' x = 1234
  y = 13 shl 2            ' y = 52

  gosub ausgabe

' noch ein paar Berechnungen
  a = k2 * k3 MOD k1      ' a = 6
  c = 200 + 60            ' c = 4, nicht 260 (c ist ein Byte!)
  z = 0                   ' das loescht auch b
  x = sqr(x)              ' x = 35
  y = 52 shr 2            ' y = 13

  gosub ausgabe

' noch eine Leerzeile ausgeben und Programmende
  print
end


' die Unterroutine zur Ausgabe der Ergebnisse
#ausgabe
  print "a = "; a, "b = "; b, "c = "; c
  print "x = "; x, "y = "; y, "z = "; z
  print
return
