# TROVA11.BAS (TROVA versione 1.1) - Finder testuale a colpo d'occhio

**Autore:** Marco da Venezia
**Anno:** 1987 (versione 1.1)
**Linguaggio:** Microsoft QuickBASIC 4.x
**Categoria:** Utility di ricerca testuale basata su console DOS

---

## Descrizione

TROVA11.BAS è un programma di ricerca testuale che analizza tutti i file presenti nella directory corrente e mostra le righe contenenti una stringa specificata dall'utente. Le occorrenze vengono **evidenziate in rosso** durante la visualizzazione.

Questo strumento consente di individuare rapidamente dove ricorre una parola o sequenza di testo, senza dover aprire manualmente i file uno per uno.

---

## Caratteristiche

* Ricerca **multi-file** all'interno della directory corrente

* Evidenziazione inline della stringa tovata

* Adattamento automatico per schermi **80 colonne**

* Compatibile con file **testuali**

* Navigazione interattiva tramite i seguenti tasti:

  * `[+]` Avanza di 1 riga
  * `[-]` Torna indietro di 1 riga
  * `[*]` Avanza di 20 righe
  * `[/]` Torna indietro di 20 righe
  * `[.]` Salta all'ultima pagina
  * `[0]` Torna alla prima pagina
  * `[Esc]` Esce

* Genera un file di output `TROVA.TO` contenente tutte le righe trovate

---

## Esempio di Output

Di seguito un esempio di file `TROVA.TO` generato dal programma:

[TROVA.TO](TROVA.TO)

E uno screenshot della visualizzazione in DOSBox-X:

![Screenshot TROVA11.BAS in esecuzione](screenshot.png)

---

## Confronto Storico

A differenza di strumenti successivi come **Norton Commander**, **PC-Shell** o editor visuali avanzati, TROVA11.BAS:

* non richiede di aprire manualmente ciascun file
* mostra subito i risultati in chiaro
* permette di scorrere rapidamente l'intero contesto

Negli anni '80 questa funzione era **rara e preziosa**, soprattutto su sistemi DOS privi di viewer avanzati.

---

## Evoluzione

Il progetto **TROVA** nasce come TROVA11.BAS (versione 1.1) nel 1987 con QuickBASIC 4.0 e viene rivisto come TROVA12 (versione 1.2) con QuickBASIC Extended 7.1 (QBX) nel 1990 implementando REDIM PRESERVE per una migliore efficienza del codice.
Il codice riflette la filosofia dell’epoca: **efficienza, leggibilità, e controllo diretto**.
La sua struttura modulare e la gestione manuale della visualizzazione lo rendono un esempio didattico perfetto per chi vuole comprendere la logica dei programmi utility del secolo scorso.

---

## Licenza

Pubblico dominio.
Libero per uso personale, didattico, archivistico o nostalgico.
Una piccola testimonianza della storia della programmazione su PC.
