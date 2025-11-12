' FINDATTR.BAS - Cerca pattern sintattici in file BASIC
' Compatibile con QuickBASIC e QB64
' By Marco da Venezia, 1989 - rev. Copilot, 2025

DECLARE FUNCTION MatchSintattico$ (riga$, pattern$)

CLS
PRINT "Inserisci la stringa da cercare [es. SCREEN(,,1)]:"
LINE INPUT pattern$
pattern$ = LTRIM$(RTRIM$(pattern$))
IF LEN(pattern$) = 0 THEN END

SHELL "DIR /B /A-D *.BAS > TEMP.TXT" ' Genera lista di file .BAS

LOCATE , , 1: PRINT "Analisi in corso..."
OPEN "TEMP.TXT" FOR INPUT AS #1
IF LOF(1) = 0 THEN PRINT "Nessun file .BAS": END

OPEN "ANALISI.TXT" FOR OUTPUT AS #3
PRINT #3, "Stringa cercata: "; pattern$
totFile = 0: totRighe = 0: trovati = 0
DO WHILE NOT EOF(1)
    LINE INPUT #1, nomefile$
    totFile = totFile + 1
    OPEN nomefile$ FOR INPUT AS #2
    riga = 0
    DO WHILE NOT EOF(2)
        LINE INPUT #2, riga$
        riga = riga + 1: totRighe = totRighe + 1
        ' LOCATE CSRLIN, 1: PRINT USING "File: \          \ - Riga: #### "; nomefile$; riga;
        IF LEN(pattern$) <= LEN(riga$) THEN
            risultato$ = MatchSintattico$(riga$, pattern$)
            IF risultato$ = "TRUE" THEN
                trovati = trovati + 1
                PRINT
                PRINT "File: "; nomefile$; " - Riga"; riga
                PRINT riga$
                PRINT #3,
                PRINT #3, "File: "; nomefile$; " - Riga"; riga
                PRINT #3, riga$
            END IF
        END IF
    LOOP
    CLOSE #2
LOOP

PRINT
PRINT "Ricerca completata."
PRINT "Analizzati:"; totFile; "file e"; totRighe; "righe"
PRINT "Occorrenze trovate:"; trovati
PRINT #3,
PRINT #3, "Analizzati:"; totFile; "file e"; totRighe; "righe"
PRINT #3, "Occorrenze trovate:"; trovati
PRINT "Risultati salvati in ANALISI.TXT"
PRINT
END

FUNCTION MatchSintattico$ (riga$, pattern$)
    ' Verifica se pattern$ esiste in riga$, in ordine

    ' Preparazione per confronto case-insensitive
    conf.riga$ = LTRIM$(RTRIM$(UCASE$(riga$)))
    conf.pattern$ = UCASE$(pattern$)

    ' Separazione pattern in blocco alfanumerico e simboli
   
    FOR i = 1 TO LEN(conf.pattern$)
        c$ = MID$(conf.pattern$, i, 1)
        IF c$ >= "A" AND c$ <= "Z" OR c$ >= "0" AND c$ <= "9" OR c$ = " " THEN
            blocco$ = blocco$ + c$
        ELSE
            simboli$ = simboli$ + c$
        END IF
    NEXT
   
    ' Cerca blocco alfanumerico unito
    posiz = INSTR(conf.riga$, blocco$)
    IF posiz = 0 THEN MatchSintattico$ = "FALSE": EXIT FUNCTION

    ' Cerca simboli in ordine, anche se intervallati
    FOR i = 1 TO LEN(simboli$)
        c$ = MID$(simboli$, i, 1)
        posiz = INSTR(posiz + 1, conf.riga$, c$)
        IF posiz = 0 THEN MatchSintattico$ = "FALSE": EXIT FUNCTION
    NEXT

    IF posiz THEN MatchSintattico$ = "TRUE"
END FUNCTION

