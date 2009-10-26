portb   equ 1
pbdir   equ 5

        org $101
        
        lda #$FF
        sta pbdir
        lda portb
        eor #$FF
        sta portb
        rts
        