
; Routine zum Entfernen des "Top-Of-Stack Words" vom Rechenstack
; (c) by Dietmar Harlos ADPC am 11. November 1999 um 06:05 MEZ

  org $101
	
realpop:
  clrx
loop:
  lda $93,x
  sta $91,x
  incx
  cpx #12
  bne loop
  rts

	
	
	
