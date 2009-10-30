# Makefile for C-Control Basic Files

CCBASIC=/home/paul/Projects/CControl/trunk/Tools/ccbpp
CCBASICFLAGS=-v $(BASFLAGS)
CONTROL=/home/paul/Projects/CControl/trunk/Tools/control.py
CONTROLFLAGS=-v -f dat

FILES=main.bas key_header.bas key_routines.bas lcd_chars.bas lcd_header.bas \
	lcd_routines.bas menu.bas menu_metric.bas signal_routines.bas \
	test_routines.bas round.bas

main: main.dat
	$(CONTROL) $(CONTROLFLAGS) -i $< store

main.dat: $(FILES)
	$(CCBASIC) $(CCBASICFLAGS) main.bas

%.dat: %.bas
	$(CCBASIC) $(CCBASICFLAGS) $<

