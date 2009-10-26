
; Die ersten 256 Bytes von einer Chip-Karte (z.B. Telefonkarte)
; lesen und im Hexadezimal-Format ausgeben lassen.
; (c) Dietmar Harlos ADPC am 4. Dezember 1999 um 18:08 MEZ

; Dieses reine Assemblerprogramm macht exakt das gleiche wie das BASIC-
; Programm KARTEBAS.BAS, und soll als anschauliches Beispiel dienen, wie
; man ein BASIC-Programm in Assembler umschreibt. Au·erdem sieht man
; natÅrlich recht schîn, da· ein in Assembler geschriebenes Programm viel
; schneller ausgefÅhrt wird. Wobei dieses Assemblerprogramm allerdings sehr
; stark durch die relativ niedrige öbertragungsgeschwindigkeit der seriellen
; Schnittstelle ausgebremst wird.

; FÅr Informationen zu Telefonkarten und zur erforderlichen Chipkartenlese-
; einrichtung bitte in KARTEBAS.BAS nachlesen!

reset equ 0   ; RESET liegt am in BASIC als PORT[1] bezeichneten Bitport
clock equ 1   ; CLOCK liegt am in BASIC als PORT[2] bezeichneten Bitport
io equ 2      ; I/O liegt am in BASIC als PORT[3] bezeichneten Bitport
leer equ 3    ; SCHLIESSER liegt am in BASIC als PORT[4] bezeichneten Bitport

portb equ $01       ; Die Adresse von PORTB (BYTEPORT[1] in BASIC)
ddrb equ $05        ; Die Adresse des Richtungsregisters von PORTB
bytezaehler equ $54 ; Auf dieser Adresse steht die ZÑhlvariable
temp equ $55        ; Auf dieser Adresse werden temporÑre Daten gespeichert

  org $101          ; Das Assemblerprogramm beginnt an Adresse $101
  
  lda #%00000011    ; RESET und CLOCK werden zu Ausgabeports, der Rest
  sta ddrb          ; von PORTB wird auf Eingang geschaltet.
  clra              ; Alle Pins von PORTB auf 0 Volt setzen
  sta portb         ; (CLOCK und RESET "off" (d.h. auf GND-Potential) setzen)

start:
  jsr printcrlf          ; Subroutine zum Ausgeben von CR+LF Åber RS232 aufrufen
  ldx #(bittekarte-$100) ; die Adresse von "Bitte Karte" relativ zum Anfang des EEPROMs
  jsr printstring        ; ..und den String Åber die serielle Schnittstelle ausgeben
  ldx #(einlegen-$100)   ; die Adresse von "einlegen" relativ zum Anfang des EEPROMs
  jsr printstring        ; ..und den String Åber die serielle Schnittstelle ausgeben
  jsr printcrlf          ; ..und wieder CR+LF Åber serielle Schnittstelle ausgeben
  
wartekarte:               ; solange warten, bis Karte eingefÅhrt wurde
  brset #leer,portb,wartekarte  ; d.h. warten, bis Pin LEER auf 0 Volt liegt
  
  jsr pause              ; kleine Pause einlegen
  
  bset #reset,portb      ; RESET setzen (wie RESET=ON in BASIC), d.h. 5 Volt
  bset #clock,portb      ; CLOCK setzen (wie CLOCK=ON in BASIC), d.h. 5 Volt
  bclr #clock,portb      ; CLOCK lîschen (wie CLOCK=OFF in BASIC), d.h. 0 Volt
  bclr #reset,portb      ; RESET lîschen (wie RESET=OFF in BASIC), d.h. 0 Volt

  clr bytezaehler        ; BYTEZAEHLER lîschen (auf 0 setzen)
                         ; (entspricht in BASIC: FOR BYTEZAEHLER=0 TO ...)
byteloop:
  lda bytezaehler        ; BYTEZAHLER MOD 16 (ist gleich BYTEZAEHLER AND 15)
  and #$0f               ; errechnen und wenn nicht Null, dann nach BLWEITER
  bne blweiter           ; springen.
  
  bsr printcrlf          ; CR+LF Åber serielle Schnittstelle ausgeben
  ldx #'$'               ; "$" Åber serielle Schnittstelle ausgeben
  jsr $0c77
  lda bytezaehler        ; BYTEZAEHLER als HEX-Zahl Åber RS232 ausgeben
  bsr hexbyte
  ldx #':'               ; ":" Åber serielle Schnittstelle ausgeben
  jsr $0c77
blweiter:
  ldx #' '               ; " " Åber serielle Schnittstelle ausgeben
  jsr $0c77
  ldx #'$'               ; "$" Åber serielle Schnittstelle ausgeben
  jsr $0c77

  bsr readnibble         ; ein Nibble (4 Bit) von der Chipkarte lesen,
  bsr hexnibble          ; und als HEX-Zahl Åber ser. Schnittstelle ausgeben
  bsr readnibble         ; ein Nibble (4 Bit) von der Chipkarte lesen,
  bsr hexnibble          ; und als HEX-Zahl Åber ser. Schnittstelle ausgeben
  
  lda #255               ; BYTEZAEHLER mit dem Wert 255 vergleichen
  cmp bytezaehler        ; (entspricht in BASIC: FOR BYTEZAEHLER=... TO 255)
  beq blende             ; wenn gleich, dann nach BLENDE, sonst BYTEZAEHLER
  inc bytezaehler        ; um eins inkrementieren (erhîhen)
  bra byteloop           ; (entspricht in BASIC: NEXT BYTEZAEHLER)
blende:

  bsr printcrlf          ; CR+LF Åber serielle Schnittstelle ausgeben
  bsr printcrlf          ; CR+LF Åber serielle Schnittstelle ausgeben
  ldx #(bittekarte-$100) ; die Adresse von "Bitte Karte" relativ zum Anfang des EEPROMs
  jsr printstring        ; ..und den String Åber die serielle Schnittstelle ausgeben
  ldx #(herausnehmen-$100) ; die Adresse von "herausnehmen" relativ zum Anfang des EEPROMs
  jsr printstring        ; ..und den String Åber die serielle Schnittstelle ausgeben
  jsr printcrlf          ; CR+LF Åber serielle Schnittstelle ausgeben
  
warteleer:               ; solange warten, bis Karte herausgenommen wird
  brclr #leer,portb,warteleer  ; d.h. warten, bis Pin LEER auf 5 Volt liegt
  
  bsr pause              ; und wieder eine kurze Pause einlegen
  
  bra start              ; endlos weitermachen



; ---- UNTERPROGRAMME -------------------------------------------------------

;----------------------------------------------------------------------------
;     Ein Nibble (4 Bit) von der Chipkarte holen
;     Ausgabe: a=gelesenes Nibble
;----------------------------------------------------------------------------

readnibble:
  ldx #4                    ; x-Register auf #4 setzen
  clra                      ; Akku lîschen
rnloop:
  brset #io,portb,rnweiter  ; kleiner Trick: Es wird in jedem Fall bei
rnweiter:                   ; RNWEITER weitergemacht, aber das Carry-Flag
                            ; wird nur gesetzt, wenn der I/O-Pin "HIGH" ist.
  rola                      ; Akku nach links schieben, dabei Carry-Bit ins
                            ; niederwertigste Bit Åbernehmen.
                            ; (genauer: Akku links rotieren, Carry ins LSB,
                            ;  MSB ins Carry; "Rotate Left through Carry")                
  bset #clock,portb         ; und CLOCK pulsen (wie PULSE CLOCK in BASIC)
  bclr #clock,portb
  decx                      ; x-Register dekrementieren (um eins erniedrigen)
  bne rnloop                ; nach RNLOOP springen, wenn x-Reg. nicht null
  rts

;----------------------------------------------------------------------------
;     Ein Nibble Åber die serielle Schnittstelle als Hex-Ziffer ausgeben
;     Eingabe: a=die auszugebende Zahl
;----------------------------------------------------------------------------

hexnibble:
  cmp #10            ; ist die Zahl kleiner als #10?
  blo hnkleiner      ; wenn ja, dann nach HNKLEINER
  add #39            ; falls nein, dann ASC("a")-ASC("0")+10 addieren
hnkleiner:
  add #'0'           ; ASC("0") hinzuaddieren (Ziffer 0 ist CHR$(48))
  tax                ; Inhalt vom Akku in das Indexregister kopieren
  jmp $0c77          ; ..und Betriebssystemfunktion aufrufen

  
;----------------------------------------------------------------------------
;     Ein Byte Åber die serielle Schnittstelle als Hex-Zahl ausgeben
;     Eingabe: a=die auszugebende Zahl
;----------------------------------------------------------------------------

hexbyte:
  sta temp           ; Akkuinhalt zwischenspeichern
  lsra               ; Zahl im Akku um 4 binÑre Stelle nach rechts schieben
  lsra               ; (d.h. Akku durch 2^4=16 teilen)
  lsra               ; (dadurch wird das High-Nibble ins Low-Nibble geschoben)
  lsra               ; (das High-Nibble ist danach 0)
  bsr hexnibble      ; und das erste Nibble Åber die RS232 ausgeben
  lda temp           ; gespeicherte Zahl zurÅckholen
  and #$0f           ; auf Low-Nibble reduzieren (High-Nibble ist 0)
  bra hexnibble      ; und das zweite Nibble Åber die RS232 ausgeben
  
;----------------------------------------------------------------------------
;     CR+LF (Carriage Return & Line Feed) Åber die RS232 senden
;     dadurch wandert der "Cursor" an den Anfang der nÑchsten Zeile
;----------------------------------------------------------------------------

printcrlf:
  ldx #$0d           ; ASCII-Code fÅr Carriage Return ausgeben
  jsr $0c77
  ldx #$0a           ; ASCII-Code fÅr Line Feed ausgeben
  jmp $0c77
  
;----------------------------------------------------------------------------
;     Einen String (mu· innerhalb des EEPROMs liegen) Åber RS232 ausgeben.
;     Der String mu· null-terminiert sein, d.h. nach dem String mu· im
;     Speicher ein Null-Byte folgen!
;     Eingabe: x=Adresse des Strings relativ zur Adresse $100
;----------------------------------------------------------------------------

printstring:
  lda $100,x         ; Zeichen (ein Byte) vom String in den Akku laden
  beq psende         ; wenn das Byte null ist, dann Ende
  stx temp           ; Index-Register zwischenspeichern
  tax                ; Inhalt vom Akku in das Indexregister kopieren
  jsr $0c77          ; und ein Byte Åber die serielle Schnittstelle ausgeben
  ldx temp           ; Index-Register wieder restaurieren
  incx               ; und um eins erhîhen
  bra printstring    ; weitermachen
psende:
  rts
  
;----------------------------------------------------------------------------
;     Eine kurze Pause von 500 ms (eine halbe Sekunde) einlegen.
;----------------------------------------------------------------------------

pause:
  clr $ce            ; siehe ROM-Listing (Suche nach "10f7 :")
  lda #25
  sta $cf
  jmp $10f7

  
; ---- VARIABLEN ------------------------------------------------------------
  
bittekarte:
  db "Bitte Karte ",0
einlegen:
  db "einlegen",0
herausnehmen:
  db "herausnehmen",0
  
  

  
