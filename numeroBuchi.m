%la funzione riceve un'immagine binaria
function num = numeroBuchi(bw)
%faccio l'opposto dell'immagine binaria, ottenendo lo sfondo
    bw2 = ~bw;
    %faccio la labeling delle componenti connesse, dove ottengo lo sfondo
    %esterno e ogni buco dell'immagine
    labels = bwlabel(bw2);
    %il massimo di labels è il numero di CC
    num = max(max(labels(:,:)));
    %tolgo dal numero di sezioni di sfondo lo sfondo esterno, restando con
    %i buchi interni all'oggetto
    num = num-1;
end
