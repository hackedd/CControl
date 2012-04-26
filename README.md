CControl
========

CControl is een programma om de 'Stoplichten' van de Buiten Wedstrijd
installatie bij HBSV Assumburg te bedienen.
Het is gescrheven in een Basic dialect voor het **C-Control - Applicationboard**.

Voor het compilen maak ik gebruik van een custom pre-processor (`ccbpp`),
te vinden in de map Tools. `ccbpp` is gescrheven in Python, en ondersteunt
`#include`, `#define` voor simpele macro's, en een extra token ASCIITABLE
die een string definieert als TABLE van ASCII waarden.
