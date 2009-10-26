
/* Kleines Beispielprogramm zu C - (c) Dietmar Harlos, 18. November 1999
   (Arrays, FOR-Schleifen, Pointer, Unterprogramme, Assemblereinbindung)

   Bitte vor der Kompilierung die Kommentare in CPROG.BAT lesen und die
   Pfade in CPROG.LCF anpassen!!

   Dieses Programm erst mit COSMIC-C kompilieren (mit CPROG.BAT) und dann
   in ZAP laden (CPROG.H05) und simulieren (im Menu Debug -> Step), wobei
   der Speicherbereich von Adresse 0x50 bis 0xff betrachtet werden sollte
   (im Menu Show -> Memory -> Data -> Byte).

   Eventuell muss in ZAP erst der Programmcounter (PC) auf Adresse 0x101
   gesetzt werden.

   Alle hier angegebenen Adressen stimmen nur, wenn die mitgelieferte
   CPROG.LCF-Datei verwendet wird! */


/* "array" ist ein Array aus 10 Byte auf der Adresse 0x50 bis 0x59 */

char array[10];

void main(void)         // Hauptprogramm-Routine
{
  int var;              // "var" ist eine Integervariable auf Adresse $5a:$5b
  _asm("rsp\n");        // Assemblerbefehl "rsp" einbinden
  init();               // Unterprogramm aufrufen
  while(1)              // Endlos-Schleife
  {
    for (var=0; var<=9; var++)  // FOR-Schleife
      unterprogramm(var);       // Unterprogrammaufruf mit Parameteruebergabe
  }
}

/* "pointer" liegt auf Adresse $5c und "nummer" als lokale Variable auf */
/* Adresse $5d:$5e */

void unterprogramm(int nummer)
{
  char *pointer;           // "pointer" wird als Zeiger auf ein Byte vereinbart
  array[nummer]++;         // das Element "nummer" von "array" wird inkrementiert
  pointer=&array[nummer];  // "pointer" mit Adresse dieses Elementes laden
  (*pointer)++;            // entspricht "array[nummer]++"

}

/* Assemblercode, der ins C-Programm eingebunden wird */
/* ueberschreibt den Speicherbereich von $50 bis $5f mit #$ff */

void init(void)         // 1. VOID: Unterprogramm liefert keinen Output
{                       // 2. VOID: Unterprogramm benoetigt keinen Input
  #asm

  ldx #$50
  lda #$ff
loop:
  sta ,x
  incx
  cpx #$60
  bmi loop

  #endasm
}
