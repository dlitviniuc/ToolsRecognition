Questi codici, vengono usati dopo la creazione del dataset per, in ordine in cui vanno eseguiti.

Nel caso il dataset sia già stato rinominato, inquanto con matlab non riusciamo a sostituire un file con un altro dello stesso nome, va cambiata la cartella di destinazione.

- "renameDataset" per cambiare i nomi delle immagini, portandole dal formato del telefono con cui sono state scattate a imageN.jpg

- "datasetResize" portare tutte le immagini del dataset a risoluzione 1400xN (mantenendo la scala) per processarle più velocemente ed occupare meno spazio

- "saveFileNames" per creare la lista images.list contenente tutti i nomi.

