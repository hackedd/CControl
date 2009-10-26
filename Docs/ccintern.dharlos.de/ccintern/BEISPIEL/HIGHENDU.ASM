
; Lage des High-Endurance-Block des 24C65-EEPROMs lesen und verschieben
; (c) Dietmar Harlos ADPC am 11. November 1999 um 06:49 MEZ
; leider ungetestet und absolut ohne Gewaehr

I2C_Read        equ $086F
I2C_ReadLast    equ $08BB
I2C_Start       equ $083C
I2C_Stop        equ $08E5
I2C_Write       equ $0846

; #$a0 = Schreibkennung des EEPROMs
; #$a1 = Lesekennung des EEPROMs

  org $101

  bra gethighendurance
  bra sethighendurance


;----------------------------------------------------------------------------
;     Lage des High Endurance Blocks lesen
;----------------------------------------------------------------------------

gethighendurance:
  bsr prolog
  
  ldx #%10000000
  jsr I2C_Write
  clrx
  jsr I2C_Write
  ldx #%01000000
  jsr I2C_Write
  bsr I2C_OwnRead
  clr $91
  sta $92
  jsr I2C_Stop

  bsr epilog
  rts

  
;----------------------------------------------------------------------------
;     High Endurance Block setzen
;----------------------------------------------------------------------------

sethighendurance:
  bsr prolog
  
  lda $92
  and #%1111
  lsla
  ora #%10000000
  tax
  jsr I2C_Write
  clrx
  jsr I2C_Write
  clrx
  jsr I2C_Write
  jsr I2C_Stop

; eventuell reagiert das EEPROM ab jetzt nicht mehr und muss resettet werden
  
  bsr epilog
  rts


;----------------------------------------------------------------------------
;     EEPROM auf Eingabe schalten
;----------------------------------------------------------------------------

prolog:
  jsr I2C_ReadLast
  ldx #$A0
  jsr I2C_Start
  rts
  
;----------------------------------------------------------------------------
;     EEPROM in seinen alten Status zuruecksetzen
;----------------------------------------------------------------------------
  
epilog:
  ldx #$A0
  jsr I2C_Start
  ldx $66
  jsr I2C_Write
  ldx $67
  jsr I2C_Write
  ldx #$A1
  jsr I2C_Start
  rts

;----------------------------------------------------------------------------
;     aus dem EEPROM lesen ohne anschliessend ACK zu setzen
;     (entspricht ziemlich genau der Betriebssystemroutine
;      I2C_ReadLast, mit dem Unterschied, dass das gelesene
;      Byte zurueckgeliefert wird)
;----------------------------------------------------------------------------
  
I2C_OwnRead:
  bclr #0,$04         ; Pin 0 (SDA) von PORTA als Eingang schalten
  clra                ; Akku soll das gelesene Byte enthalten
  ldx #8              ; Index Register ist Zaehler von 8 bis 1

loop:
  brset #0,$00,weiter ; Carry setzen wenn Bit gesetzt (=1) ist
weiter:
  rola                ; Bit in den Akku schieben
  bset #1,$00         ; SCL high
  bclr #1,$00         ; SCL low
  decx                ; Zaehler dekrementieren
  bne loop            ; bis gleich null
  
  bset #0,$04         ; Pin 0 (SDA) von PORTA als Ausgang schalten
  bset #0,$00         ; SDA high (ACK nicht setzen)
  bset #1,$00         ; SCL high
  bclr #1,$00         ; SCL low
  rts                 ; Ruecksprung
  
  
  
																
