%la funzione riceve un'immagine e una altezza alla quale portarla
function out = myresize (im, s)
%estraggo le dimensioni dell'immagine ricevuta
    [n,m] = size(im);
    %calcolo la scala per l'immagine con altezza desiderata/altezza
    %immagine
    scale = s/n;
    %faccio la resize dell'immagine con la scala calcolata
    out = imresize(im, scale);
end