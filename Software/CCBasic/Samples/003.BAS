'********************************************************************
'
' C-Control/BASIC       003.BAS
'
' Systemvoraussetzungen:
'
' - serielle Verbindung zum PC
' - Terminalprogramm
'
' Schwerpunkte:
'
' - Definition von Variablen und Konstanten
' - einfache Zuweisungen und Rechenoperationen
' - Ausgabe von Texten und Ergebnissen mit PRINT
'
' Das Beispiel zeigt u.a. die Effekte, die durch Ueberlappung von
' Variablen oder durch Ueberschreitung des Wertebereicches entstehen.
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
print "C-Control/BASIC      003.BAS"
print "============================"
print

' Initialisierungen
a = 3
b = k1                  ' b = 100
c = 0
x = -k2                 ' x = -1234
y = -k3                 ' y = 247, nicht -9 (Bytes sind immer positiv)

' alle Werte ausgeben, achten Sie auf z = b!
print "a = "; a, "b = "; b, "c = "; c
print "x = "; x, "y = "; y, "z = "; z
print

' ein paar Berechnungen
a = a + 97              ' a = 100
b = k2 * k3 / k1        ' b = 111
c = (17 + 4) / 7        ' c = 3
x = abs(x)              ' x = 1234
y = 13 shl 2            ' y = 52

' alle Werte ausgeben, achten Sie auf z = b!
print "a = "; a, "b = "; b, "c = "; c
print "x = "; x, "y = "; y, "z = "; z
print

' noch ein paar Berechnungen
a = k2 * k3 MOD k1      ' a = 6
c = 200 + 60            ' c = 4, nicht 260 (c ist ein Byte!)
z = 0                   ' das loescht auch b
x = sqr(x)              ' x = 35
y = 52 shr 2            ' y = 13

' alle Werte ausgeben, achten Sie auf z = b!
print "a = "; a, "b = "; b, "c = "; c
print "x = "; x, "y = "; y, "z = "; z
print

' noch eine Leerzeile ausgeben und Programmende
print
end

' Wenn der Starttaster jetzt noch gedrueckt ist,
' beginnt das Programm wieder von vorn!


