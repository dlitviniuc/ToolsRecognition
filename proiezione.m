%funzione che ritorna la proiezione di un'immagine, 
%limitata a num righe/colonne, riceve in input un'immagine binaria
function [proH1, proL1] = proiezione(bwimg)
    %estraggo la dimensione dell'immagine
    [n,m] = size(bwimg);
    %creo due array che conterranno le proiezioni, 
    %H verticale, L orizzontale
    proH = zeros(n,1);
    proL = zeros(m,1);
    %calcolo l'area dell'oggetto (numero di pixel bianchi)
    Area = sum(sum(bwimg(:,:)));
    %imposto quante righe e colonne voglio estrarre dalla proiezione
    num = 50;
    %calcolo la proiezione per ogni riga, contando il numero di pixel
    %bianchi per ogniuna e salvandolo nell'array corrispondente
    for i=1 : n
        proH(i,1) = sum(sum(bwimg(i:i,:)));
    end
    %stesso passaggio di prima ma per le colonne
    for i=1 : m
        proL(i,1) = sum(sum(bwimg(:,i:i)));
    end
    %calcolo la dimensione del step per estrarre solo num elementi
    step1 = n/num;
    step2 = m/num;
    %inizializzo due vettori che conterranno i num elementi estratti
    proH1 = [];
    proL1 = [];
    %estraggo num elementi dai due vettori proiezione, permettendomi di
    %usarli come descrittori.
    for i = 1: num
        s = ceil(i*step1);
        t = ceil(i*step2);
        proH1 = [proH1 proH(s)];
        proL1 = [proL1 proL(t)];
    end
end