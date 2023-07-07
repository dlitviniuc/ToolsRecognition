%la funzione riceve in input un'immagine da classificare
function out = classifica(im)
%porto l'immagine ad una risoluzione più piccola del solito per la quale
%abbiamo calibrato la binarizzazione
    im = myresize(im, 1400);
    %binarizzo e rimuovo gli oggetti piccoli dall'immagine
    bw = removeSmall(im);
    %faccio la labeling dell'immagine binaria
    labels = bwlabel(bw);
    %estraggo il numero di elementi trovati
    n = max(labels(:));
    %inizializzo il vettore delle coordinate
    coord = [];
    %per ogni elemento trovo il suo pixel più alto-basso-a destra-a
    %sinistra per avere la sua posizione approssimativa
    for i=1 : n
        temp = labels == i;
        [r,c] = find(temp);
        minh = min(r(:));
        maxh = max(r(:));
        minl = min(c(:));
        maxl = max(c(:));
        coord = [coord, [minh,maxh, minl,maxl]];
    end
    %estraggo il numero di coordinate trovate (numero elementi * 4)
    [r,c] = size(coord);
    %inizializzo il vettore per i nomi degli oggetti
    nome = [];
    %uso una variabile secondaria per copiare l'immagine per non
    %modificarla per altri calcoli
    out = im;
    %per ogni oggetto trovato faccio i prossimi controlli
    for i=1:c/4
        img = im;
        %copro gli altri elementi oltre a quello in considerazione in
        %un'area grigia poco più grande delle coordinate trovate prima
        for j=1:c/4
            if j~=i
                img(coord(1,((j-1)*4)+1):coord(1,((j-1)*4)+2), coord(1,((j-1)*4)+3):coord(1,((j-1)*4)+4),:)=192;
            end
        end

        %save("image"+i, "img");
        %classifico l'oggetto in considerazione, ottenendo il suo nome
        nome = [nome classificazioneImm(img)];
        %calcolo l'altezza e larghezza dell'oggetto per creare la bounding
        %box
        h = coord(1,((i-1)*4)+2)-coord(1,((i-1)*4)+1);
        l = coord(1,((i-1)*4)+4)-coord(1,((i-1)*4)+3);
        %aggiungo un rettangolo all'immagine per ogni elemento
        out = insertShape(out, 'rectangle', [coord(1,((i-1)*4)+3),coord(1,((i-1)*4)+1),l,h], LineWidth=5);
    end
    %aggiungo i nomi degli elementi sulle bounding box
    for i=1:c/4
        out = insertText(out, [coord(1,((i-1)*4)+3),coord(1,((i-1)*4)+1)-20],nome(i),FontSize=30);
    end
end
