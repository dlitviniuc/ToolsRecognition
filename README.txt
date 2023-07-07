Componenti del gruppo:
- Dan Litviniuc (869329)
- Golub Oleksandra (856706)
- Lorenzo Cino (866120)

***

Per classificare le immagini ci sono due metodi:

	1) 	Usare "app1", una semplice GUI implementata con matlab che permette di visualizzare un'immagine e classificarla,
		inoltre è possibile vedere i grafici ottenuti in fase di test e validation alla creazione del classificatore.
		Abbiamo predisposto un insieme di immagini non contenute nel dataset, singole e in gruppo, queste sono presenti
		nella cartella risorse/foto e possono essere selezionate dalla lista presente nell'interfaccia grafica.

		Si possono semplicemente visionare premendo "Mostra Immagine" oppure classificare premendo "Classifica".
		Alla fine della classificazione, viene cambiato il colore alla lampadina segnata come finito, portandola a verde.
		Quando si sceglie un'immagine diversa dalla lista, la lampadina ritorna al colore rosso.

		Si possono inoltre vedere il grafico di validazione premendo Grafico Precisione oppure l'acuratezza dei vari
		classificatori con i nostri descrittori, premendo Precisione vari Classificatori.

		In caso si desiderasse classificare un'immagine esterna, è possibile salvarla nella cartella risorse/foto e scrivere
		il suo nome nello spazio chiamato Immagine, senza l'estensione (si presume sia .jpg).
		Alternativamente si può premere il tasto esterna e scrivere nella edit field il path completo, con l'estensione dell'immagine.


	2) 	Usare il codice matlab "ClassificazioneCodice" che permette di vedere le varie fasi dell'immagine
		in questo caso: Binarizzata, con oggetti piccoli tolti e Classificata.

***

Per creare i descrittori, si deve chiamare dalla console di matlab la funzione "create_descriptor_files".

Il codice "TestClassificazione_Training" permette di vedere la precisione dei vari classificatori separatamente, in questo caso pers che sono i descrittori creati da noi, 
lbp e qhist che sono quelli messi a disposizione. Inoltre fa il training del classificatore di tipo bagged trees con cross-validation a 5 fold e
si vede la precisione della validazione del classificatore nel quale abbiamo usato i tre descrittori insieme.

Per il resto dei file abbiamo:

-"myresize" che è una semplice funzione di resize che cambia la risoluzione dell'immagine.

-"Binarizzazione" che è la funziona da noi implementata per binarizzare l'immagine.

-"removeSmall" usato in congiunzione alla binarizzazione per rimuovere oggetti troppo piccoli.

-"readlists" che legge le due liste in risorse e ritorna i contenuti.

-"create_descriptor_files" che crea i vari file descrittori e li salva in risorse.

-"descrittori" che è la nostra funzione che crea i descrittori pers.

-"belongs" che è una funzione che dice se il centroide appartiene all'immagine.(usato in descrittori.m)

-"distanzaAngolo" che è una funzione che calcola un numero di distanze dal centro di gravità.(usato in descrittori.m)

-"numeroBuchi" che è una funzione che ritorna il numero di buchi presenti in un oggetto.(usato in descrittori.m)

-"numeroManiglie" che è una funzione che ritorna il numero di maniglie di un oggetto.(usato in descrittori.m)

-"proiezione" che è una funzione che calcola la proiezione di un'immagine binaria e ne ritorna 50 per altezza e 50 per larghezza.(usato in descrittori.m)

-"compute_lbp" che crea i descrittori lbp. Non è stato modificato da quello predisposto.

-"compute_qhist" che crea i descrittori qhist. Non è stato modificato da quello predisposto.

-"confmat" che non è stato modificato da quello predisposto.

-"TestClassificazione_Training" descritta sopra.

-"ClassificazioneCodice" descritta sopra.

-"classifica" che è la funzione da chiamare per classificare un'immagine qualsiasi, questo ritorna un'immagine con le bounding box labelate.

-"classificazioneImm" che è la funzione che ritorna la label per un'immagine contenente un'oggetto unico (preferibilmente).(usato in classifica)

-"test_classifier" che testa l'accuratezza dei classificatori.

-"trainClassifierEnsamble" che è un classificatore generato da matlab tramite Classification learner(usa BaggedTrees).

