' TROVA.BAS 1.1 - Per QB 4.x
' by Marco da Venezia, 1987
' Finder per una stringa in tutti i file di una directory

DECLARE SUB Lettore (file$, stringa$)

CLS
LINE INPUT "Cerca stringa (max 255 caratteri) ", stringa$
stringa$ = LTRIM$(RTRIM$(stringa$))
IF LEN(stringa$) = 0 THEN END

SHELL "DIR /B /A-D > TEMPDIR"

LOCATE , , 1: PRINT "Attendere... ";
OPEN "TEMPDIR" FOR INPUT AS #1
IF LOF(1) = 0 THEN PRINT "Directory vuota": END

OPEN "TROVA.TO" FOR OUTPUT AS #2
PRINT #2, "Stringa cercata: "; stringa$
nFiles = 0: nRighe = 0: trovati = 0

DO WHILE NOT EOF(1)
    LINE INPUT #1, file$
    IF UCASE$(file$) <> "TEMPDIR" AND UCASE$(file$) <> "TROVA.TO" THEN
        nFiles = nFiles + 1
        OPEN file$ FOR INPUT AS #3
        riga = 0
        DO WHILE NOT EOF(3)
            LINE INPUT #3, riga$
            riga = riga + 1: nRighe = nRighe + 1
            IF LEN(riga$) >= LEN(stringa$) THEN
                conf.riga$ = UCASE$(riga$)
                conf.stringa$ = UCASE$(stringa$)
                IF INSTR(conf.riga$, conf.stringa$) THEN
                    trovati = trovati + 1
                    PRINT #2,
                    PRINT #2, "File: "; file$; " - Riga"; riga
                    PRINT #2, riga$
                END IF
            END IF
       LOOP
       CLOSE #3
    END IF
LOOP

PRINT #2,
PRINT #2, "Analizzati:"; nFiles; "file e"; nRighe; "righe"

CLOSE #1, #2

Lettore "TROVA.TO", stringa$

SUB Lettore (file$, stringa$)

' conta le righe del file per definire la grandezza di un array
OPEN file$ FOR INPUT AS #1
    WHILE NOT EOF(1)
        LINE INPUT #1, r$
        r = LEN(r$) \ 81 ' addendo per il contatore per righe pi— lunghe di 80 caratteri
        totrighe = totrighe + 1 + r
    WEND
CLOSE #1

DIM righe(0 TO totrighe) AS STRING

OPEN file$ FOR INPUT AS #1
    FOR i = 1 TO totrighe
        LINE INPUT #1, r$
        WHILE LEN(r$) > 80
            righe(i) = LEFT$(r$, 80) ' Salva il primo pezzo di 80
            r$ = MID$(r$, 81)        ' Conserva in r$ solo il resto della stringa
            i = i + 1                ' Avanza all'indice successivo dell'array
        WEND
        righe(i) = r$                ' Salva l'ultimo pezzo (o l'unico, se la riga era <= 80)
    NEXT
CLOSE #1

rigacorrente = 1

CLS
COLOR 15
LOCATE 1, 40 - (LEN("File: " + file$) \ 2): PRINT "File: "; file$
LOCATE 25, 17: PRINT "Premi [+] e [-] per scorrere o [Esc] per uscire ";
c = POS(1)
COLOR 0, 7
DO
    IF k$ = "" OR k$ = "+" OR k$ = "-" OR k$ = "*" OR k$ = "/" OR k$ = "." OR k$ = "0" THEN
        VIEW PRINT 3 TO 23: CLS (2): VIEW PRINT
        LOCATE 3, 1, 0
        FOR i = rigacorrente TO rigacorrente + 20
            IF i <= totrighe THEN
                PRINT righe(i);
                r$ = righe(i): s$ = stringa$
                IF INSTR(UCASE$(r$), UCASE$(s$)) THEN
                    COLOR 12
                    FOR j = 1 TO LEN(r$) - LEN(s$) + 1
                        j$ = MID$(r$, j, LEN(s$))
                        IF UCASE$(j$) = UCASE$(s$) THEN
                            LOCATE , j: PRINT j$;
                            ' siccome j deve saltare alla posizione successiva all'occorrenza,
                            ' lo spostamento deve essere la lunghezza della stringa
                            j = j + LEN(s$) - 1
                        END IF
                    NEXT
                END IF
                COLOR 0
                PRINT
            END IF
        NEXT
        LOCATE 25, c, 1
    END IF
    k$ = INPUT$(1)
    SELECT CASE k$
        CASE "+" '--- avanti di una riga
            IF rigacorrente + 20 < totrighe THEN rigacorrente = rigacorrente + 1
        CASE "-" '--- indietro di una riga
            IF rigacorrente > 1 THEN rigacorrente = rigacorrente - 1
        CASE "*" '--- avanti di 20 righe
            IF rigacorrente + 20 <= totrighe - 20 THEN rigacorrente = rigacorrente + 20
        CASE "/" '--- indietro di 20 righe
            IF rigacorrente - 20 > 0 THEN rigacorrente = rigacorrente - 20
        CASE "." '--- va all'ultima riga
            IF totrighe > 20 THEN rigacorrente = totrighe - 20 'ELSE rigacorrente = 1
        CASE "0" '--- va alla prima riga
            rigacorrente = 1
        CASE CHR$(27)
            VIEW PRINT
            COLOR 7, 0
            LOCATE 25
            END
    END SELECT
LOOP

END SUB

