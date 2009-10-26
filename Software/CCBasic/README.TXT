Conrad Electronic C-Control/BASIC
=================================

README.TXT
Copyright (c) 1997 Conrad Electronic GmbH, CTC TKB 

Stand 15.05.97

aktuelle Software C-Control/BASIC:
	CCBAS.EXE       1.31
	CCDL.EXE        1.31
	MINITERM.EXE    1.31
	CCE.EXE         1.31
	CCEW32D.EXE     1.32
	CCEW32D.DLL	1.1

Diese Datei enthaelt aktuelle Informationen, die erst nach Redaktionsschluss
der Bedienungsanleitung, der Software und der Hilfedateien verfuegbar waren.
Sollten Probleme bei der Bedienung Ihres C-Control/BASIC-Systems auftreten,
so lesen Sie bitte diese Datei sowie die Anleitung nochmals vollstaendig durch.
Ausserdem enthalten die Online-Hilfen zu den Programmen CCE und CCEW32D eventuell
die Loesung zu Ihrem Problem.


Anwenderservice
===============

Das C-Control/BASIC-System inklusive Software wurde umfangreich getestet. Dennoch
koennen aufgrund der Komplexitaet des Systems und der Vielzahl unterschiedlicher 
Computer-Konfigurationen einige Fehler, Probleme oder Ausnahmebedingungen uebersehen
worden sein. Sollte sich irgendein Problem nach Studium der Bedienungsanleitung, dieser
README-Datei und der Online-Hilfen nicht loesen lassen so, informieren Sie bitte unsere 
Technische Kundenbetreuung.

per Brief       Conrad Electronic   
                TKB Computer/Messtechnik
                Klaus-Conrad-Str.1
                92240 Hirschau
	
Fax             0180 53 12 119
tel. Hotline    0180 53 12 116

!!! W I C H T I G !!!
Halten Sie bitte eine moeglichst genaue Beschreibung folgender Randbedingungen bereit:

* zum PC
	- Rechnertyp
	- Speicherausbau (RAM)
	- Grafiksystem und dessen Einstellung (Aufloesung, Farben, Schriftgrad)
        - Anzahl, Adressen und Interruptnummern der seriellen Schnittstellen
	- Betriebssystem (DOS bzw. Windows-Version)
	- unter Windows parallel laufende Programme
	- die von Ihnen ausgefuehrte Bediensequenz
	- Versionsnummern der C-Control/BASIC Software

* zum C-Control/BASIC Steuercomputer (ControlUnit)
        - Beschriftung des Mikroprozessors (siehe Etikett oder Aufdruck)
	- Spannungsversorgung (Netzteil, Batterie oder Akku, vieviel Volt)
        - Stromaufnahme des Gesamtsystems
	- Beschaltung der Ports
	- Ihr BASIC-Programm

stellen Sie bitte fest, ob das Problem zufaellig oder reproduzierbar in
Erscheinung tritt. Betrifft das Problem das DOS- und/oder das Windows-Programm?

Die Technische Kundenbetreuung kann Sie gegebenenfalls mit aktuellen Informationen 
versorgen.


Problemloesungen
================

* Probleme beim Uebertragen eines Programms in die ControlUnit

Wenn Sie beim Versuch, ein Programm in die ControlUnit zu uebertragen, 
eine der folgenden Meldungen erhalten

  "...die ControlUnit antwortet nicht"
  "...Uebertragungsfehler"

, so druecken Sie den roten RESET-Schalter an der ControlUnit und probieren
Sie es nochmal. Sollte sich keine Loesung einstellen

, so gehen Sie bitte folgende Pruefliste durch

  - werden nur die Originalkabel verwendet
  - sind Nullmodemkabel und Adapterkabel verbunden
  - ist das Nullmodemkabel am PC angesteckt
  - ist das Adapterkabel polungsrichtig auf die ControlUnit gesteckt
  - sind die Jumper 232 und LED auf der ControlUnit gesetzt
  - ist im Programm die richtige COM-Schnittstelle eingestellt
  - ist die Betriebsspannung angeschlossen und eingeschaltet
  - fuehrt eine zu hohe Belastung der Spannungsversorgung eventuell zu 
    einem Spannungseinbruch
  - greift ein anderes Programm gerade auf die gewaehlte serielle Schnittstelle
    zu (Terminalprogramm, FAX-Programm), dann beenden Sie dieses
  - schliessen Sie alle DOS-Fenster unter Windows
  - gibt es Hardwarekonflikte der verwendeten seriellen Schnittstelle mit anderen 
    Komponenten Ihres PCs, pruefen Sie z.B. Interrupts und Adresseneinstellungen
    von Netzwerk-, Sound-, Modem- oder anderen Einsteckkarten

Kann die Funktion des Systems nach Pruefung aller Punkte und auch nach Herunterfahren, 
Ausschalten und Neustart des PCs nicht hergestellt werden, so wenden Sie sich bitte an
unsere Technische Kundenbetreuung.

* ein BASIC-Programm tut nicht, was es soll

  - lesen Sie nochmals die Beschreibungen zu den verwendeten Befehlen in der Anleitung
    und in der Online-Hilfe, plazieren Sie dazu den blinkenden Cursor im CCE- oder CCEW32D-
    Editor nacheinander auf den interessierenden Befehlen und druecken Sie CTRL+F1
  - reduzieren Sie Ihr Programm und testen Sie es abschnittsweise aus, um die problematischen
    Stellen zu finden
  - achten Sie auf Wertebereiche und Arrangement der Variablen Ihres Programms im Speicher 
    (eventuelle Ueberlappung von Variablen!)
  - in CCEW32D koennen Sie Ihr Programm schrittweise simulieren, versuchen Sie so,
    den Fehler zu finden
  - sollte sich keine Loesung einstellen, koennen Sie sich mit einer Anfrage an unsere technische
    Kundenbetreuung wenden

* nach Aus- und Einschalten der Betriebsspannung funktioniert ein geladenes
  BASIC-Programm nicht mehr

  - lesen Sie nochmals die Hinweise zu den erforderlichen RESET-Schaltungen in der
    Bedienungsanleitung


Weitere Hinweise zur Software
=============================

* Sie koennen die DOS-Programme CCBAS.EXE, CCDL.EXE und MINITERM.EXE
  auch von der DOS-Kommandozeile aus aufrufen 

  CCBAS <dateiname.bas>
  CCDL <dateiname.dat> <comnummer>
  MINITERM <comnummer>

* Das Miniterminalprogramm ist sehr einfach gehalten und empfaegt Daten von 
  der seriellen Schnittstelle ungepuffert und arbeitet im sogenannten Polling. Auf
  langsamen Rechnern und beim Einsatz unter Windows koennen so empfangene Zeichen
  "verschluckt" werden. Das ist kein Programmfehler, sondern prinzipbedingt! 
  Wir gehen davon aus, dass Sie fuer eine konkrete Anwendung mit serieller
  Kommunikation zwischen PC und ControlUnit ein eigenes, angepasstes Programm 
  verwenden.

* CCEW32D verfuegt ueber kein eigenes Terminalprogramm. Verwenden Sie unter 
  Windows das dort zugehoerige Terminal- bzw. Hyperterminal-Programm. Stellen
  Sie dort ein: 
    
    Direktverbindung ueber COMx, 
    9600 Baud, 8 Datenbits, kein Paritaetsbit, 1 Stopbit,
    kein Protokoll,
    gesendete Zeilen enden mit Zeilenvorschub,
    lokales Echo

* Unter CCEW32D ist kein Assembleraufruf integriert. Lassen Sie bei Bedarf Ihren
  Assembler in einem DOS-Fenster laufen.

* Die Tabellen-Dateien im TABLES-Verzeichnis gehoeren zu den zum Starter Board
  kompatiblen Telemetrie-Sensoren. Die Bedienungsanleitungen zu den Sensoren beziehen
  sich softwareseitig auf das Conrad Electronic Telemetriesystem, nicht auf 
  C-Control/BASIC. Sie koennen diese Hinweise ignorieren. Das Beispiel 009.BAS
  demonstriert, wie Sie Tabellen verwenden. 
  Die Tabelle KTY10.TAB enthaelt die mit 10 multiplizierten Werte aus KTY.TAB, da
  die ControlUnit nur ganze Zahlen verarbeitet.


Weitere Hinweise zur Hardware
=============================

* Verwendung der DCF-Antenne

  Es kann ausschliesslich die DCF-Aktivantenne (Best.-Nr.12 11 77)
  verwendet werden.
  Zur Leitungsverlaengerung muessen abgeschirmte Leitungen verwendet werden.
  Achten Sie auf den richtigen Anschluss der Antenne:
  Pin 1 - Masse
  Pin 2 - Betriebsspannung
  Pin 3 - >> nicht verwendet (DCF) <<
  Pin 4 - DCF Ausgang invertiert fuer CControl

  Es ist kein Fehler seitens der ControlUnit, wenn ueber einen laengeren Zeitraum 
  die DCF-Synchronisation ausfaellt (gruene LED blinkt). Pruefen Sie nochmals die 
  Plazierung und Ausrichtung der Antenne. In vielen Faellen ist der PC eine extreme
  Stoerquelle fuer den DCF-Empfang. Die Synchronisation erfolgt dann erst nach 
  Abschalten des PCs. Gleiches kann auch fuer andere elektrische/elektronische 
  Geraete gelten. Untersuchen Sie daher den Einsatzort Ihres C-COntrol/BASIC-Systems
  auf moegliche Stoerquellen.
  

Bekannte Ausnahmeerscheinungen
==============================

* FOR..TO..- Zeilen duerfen keine durch Doppelpunkt getrennten weiteren Anweisungen
  enthalten. Obwohl keine Fehlermeldung des Compilers erfolgt, wird sonst das Programm
  nicht wie erwartet abgearbeitet.
  
* Bei langen BASIC-Programmen, die in CCEW32D compiliert werden, kann eine "Programm
  zu lang"-Fehlermeldung vom Compiler erfolgen, obwohl 8000 Bytes Programmlaenge noch 
  nicht erreicht sind. Ursache dafuer sind die verborgenen Simulator-Codes. Compilieren 
  und uebertragen Sie das Programm dann unter DOS (CCE).
