%la funzione riceve un'immagine binaria e controlla se il suo centro di
%gravità appartiene all'area dell'oggetto
function out = belongs(bw)
%calcolo l'area dell'oggetto
    Area = sum(sum(bw(:,:)));
    %se l'immagine è nera non devo calcolare il descrittore
    if Area >0
        %estraggo il centro di gravità dell'oggetto
        stats = regionprops(im2double(bw),'centroid');
        %arrotondo le coordinate
        x = floor(stats.Centroid(1));
        y = floor(stats.Centroid(2));
        %controllo se nella posizione delle coordinate(riga, colonna) se
        %abbiamo un pixel bianco, questo indica che siamo nell'oggetto o
        %meno
        if bw(y,x)>0
            out = 1;
        else
            out = 0;
        end
        %se non viene rilevato un'oggetto dalla binarizzazione segno come
        %se il centro fosse fuori
    else
        out =0;
    end
end