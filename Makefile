# Makefile for C-Control Basic Files

CCBASIC=/home/paul/Projects/CControl/trunk/Tools/ccbpp
CCBASICFLAGS=-v $(BASFLAGS)
CONTROL=/home/paul/Projects/CControl/trunk/Tools/control.py
CONTROLFLAGS=-v -f dat

%.dat: %.bas
	$(CCBASIC) $(CCBASICFLAGS) $<

test: test.dat
	$(CONTROL) $(CONTROLFLAGS) -i $< store

menu.dat: menu.bas menu_metric.bas lcd_routines.bas lcd_header.bas lcd_chars.bas key_header.bas key_routines.bas
	$(CCBASIC) $(CCBASICFLAGS) menu.bas
	
menu: menu.dat
	$(CONTROL) $(CONTROLFLAGS) -i $< store

