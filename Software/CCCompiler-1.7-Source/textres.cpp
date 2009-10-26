/********************************************************************

	 textres.cpp

	 Modul mit String-Ressourcen

********************************************************************/

#include "textres.h"


const char far* TXT_WELCOME = "\nC-Control/BASIC Compiler, Version 1.5\n";
const char far* TXT_COPYRIGHT =  "Copyright (c) 1998, Conrad Electronic GmbH, "
										"D-92240 Hirschau\n";

const char far* TXT_CALLINGLOADER =  "...fertig, starte Lader-Programm...\n\n";
const char far* TXT_READY = "bereit.\n\n";

const char far* TXT_USAGE = "Aufruf: CCBAS <dateiname>\n";
const char far* TXT_CANTWRITE = "...kann Ausgabedatei nicht schreiben\n";
const char far* TXT_CANTREAD = "...kann Eingabedatei nicht lesen\n";

const char far* TXT_ERROR = "Fehler";
const char far* TXT_ERRORSFOUND = "Fehler gefunden";
const char far* TXT_LINE = "Zeile";

const char far* TXT_MISSING = "fehlendes";
const char far* TXT_EXPECTED = "erwartet";
const char far* TXT_UNEXPECTED = "unerwartetes";
const char far* TXT_EOL = "Zeilenende";
const char far* TXT_EOS = "Anweisungsende";
const char far* TXT_OUTOFRANGE = "nicht im gueltigen Bereich";
const char far* TXT_PROGRAMTOOLONG = "Programm zu lang";
const char far* TXT_SYSPROGRAMTOOLONG = "Assemblerprogramm zu lang";
const char far* TXT_UNDEFINEDLABEL = "undefiniertes Label";
const char far* TXT_REDEFINEDLABEL = "mehrfach definiertes Label";
const char far* TXT_UNDEFINEDIDENTIFIER = "undefinierter Bezeichner";
const char far* TXT_NEXTWITHOUTFOR = "NEXT ohne FOR";
const char far* TXT_VARIABLE = "Variable";
const char far* TXT_UNDEFINEDVAR = "ist nicht als Variable definiert";
const char far* TXT_CONSTANT = "Konstante";
const char far* TXT_BITNUMBER = "Bitnummer";
const char far* TXT_BITPORTVARIABLE = "Bitportvariable";
const char far* TXT_INVALIDSYMBOL = "kein gueltiger Bezeichnername";
const char far* TXT_REDEFINEDSYMBOL = "mehrfach definierter Bezeichner";
const char far* TXT_FILENOTFOUND = "Datei nicht gefunden";
const char far* TXT_INVALIDFILEFORMAT = "ungueltiges Dateiformat";

const char far* TXT_SYNTAXERROR = "Syntaxfehler";
