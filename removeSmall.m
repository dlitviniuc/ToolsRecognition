function out = removeSmall(im)
    %binarizzo l'immagine
    bw = Binarizzazione(im);
    %per ogni CC se la sua area è sotto 3000(calibrato manualmente) la
    %elimino, togliendo rumore e principalmente elementi non desiderati
    bw = bwareafilt(bw, [1500, 99999999]);
    %porto l'output in valori logici
    out = bw>0;
end