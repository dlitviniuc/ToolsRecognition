%ricevo un'immagine binaria
function out = numeroManiglie(bw)
    bw = imerode(bw, strel("disk", 10));
    %calcolo la trasformata distanza dell'immagine
    D = bwdist(~bw);
    %normalizzo la trasformata a distanza
    D = D / max(max(D));
    %prendo scheletrizzo sulla porzione interna della trasformata a
    %distanza
    skel = bwskel(D>0.1);
    %calcolo l'area dell'immagine binaria
    Area = sum(sum(bw(:,:)));
    %calcolo la proiezione dell'immagine binaria
    [proH, proL] = proiezione(bw);
    %grazie alle proiezioni ottengo altezza e larghezza dell'oggetto
    H = max(proL(:))*Area;
    L = max(proH(:))*Area;
    %segno come altezza il maggiore dei due
    alt = max(H , L);
    %estraggo i punti di branching dallo scheletro
    B = bwmorph(skel, "branchpoints");
    %tolgo i punti di branching, ottenendo le varie parti dello scheletro
    %separate
    branches = skel - B;
    %faccio la labeling per le CC
    labels = logical(branches);
    %estraggo la lunghezza di ogni parte dello scheletro (essendo di larghezza 1 sarà l'area)
    lunghezza = regionprops(labels, "area");
    %inizializzo a 0 il numero di maniglie
    out = 0;
    %per ogni CC, controllo se è più lunga di altezza/2.5 (controllato manualmente)
    for i=1:size(lunghezza)
        if lunghezza(i).Area>= alt/2.5
            %se vero, segno l'elemento come maniglia e incremento il numero
            out = out+1;
        end
    end
end