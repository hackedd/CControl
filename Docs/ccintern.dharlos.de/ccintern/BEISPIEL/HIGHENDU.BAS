
' Lage des High-Endurance-Block des 24C65-EEPROMs lesen und verschieben
' (c) Dietmar Harlos ADPC am 11. November 1999 um 06:49 MEZ
' leider ungetestet und absolut ohne Gewaehr

' Naehere Informationen stehen in der Textdatei TIPSUTRI.TXT.

syscode "highendu.s19"

' Mit dem folgenden Befehl wird der High-Endurance-Block auf Block 14 des
' EEPROMs verschoben. Nach dem Ausfuehren des Befehls reagiert das EEPROM
' u.U. nicht mehr und muss resettet werden. Sinnvoll ist es, wenn der
' High-Endurance-Block auf Block 0 (den ersten Block) gesetzt wird, denn
' dieser Bereich wird wohl am haeufigsten durch das Laden eines neuen BASIC-
' Programmes umprogrammiert. Ausserdem wird in dem Bereich das Word, das die
' Groesse der Datendatei bestimmt, gespeichert.

'sys &h103 14

' Mit dem folgenden Befehl wird die Lage des High-Endurance-Blocks aus-
' gelesen. Ab Werk sollte dieser auf dem letzten Block des EEPROMs, auf
' Block 15 liegen. Das Byte liegt noch im RAW-Format vor und repraesentiert
' direkt das, was das EEPROM sendet. Eine UND-Verknuepfung mit &b1111
' ergibt die Nummer des Blocks.

print readhighendurance     ' block = (readhighendurance AND &h1111)
end

#readhighendurance
  sys &h101
return

' Falls das Auslesen oder Verschieben des Blocks nicht funktionieren sollte
' bitte das Manual zum 24C65-EEPROM von Microchip (21058g.pdf) konsultieren
' und - falls vorhanden - mit einem Speicheroszilloskop die Signale auf dem
' I2C-Bus ueberpruefen. Ich habe auf meiner M-Unit ein 24C64'er EEPROM, und
' kann deshalb leider nicht weiterhelfen - mein EEPROM hat keinen HEB!
