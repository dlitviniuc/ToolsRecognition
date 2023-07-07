function DescriptorVector = descrittori(ImageRGB)
    %area, altezza/larghezza, numero maniglie, 60 distanze dal centro, 
    %centroide dell'oggetto, areaConvessa/area, numero buchi, proiezione
    
    %inizializzo il vettore dei descrittori
    DescriptorVector=[];
    %binarizzo l'immagine e rimuovo gli oggetti piccoli
    bw = removeSmall(ImageRGB)>0;
    %controllo la rotazione dell'immagine e la ruoto per avere una
    %posizione stabile
    stats = regionprops(bw, 'Orientation');
    if size(stats) == [0,1]
        rot = 0;
    else
        rot = -stats(1).Orientation;
    end
    %l'angolo rot è stato stabilito da Orientation di regionprops
    bw = imrotate(bw, rot);
    %porto l'immagine ad una dimensione standard
    bw = imresize(bw, [700, 700]);

    %calcolo l'area dell'oggetto
    Area2 = sum(sum(bw(:,:)));
    %aggiungo l'area al vettore dei descrittori
    DescriptorVector = [Area2];
    
    %estraggo l'altezza e larghezza dell'oggetto, prendendo i pixel più in
    %alto e in basso per l'altezza e più a destra e a sinistra per la
    %larghezza
    [r,c] = find(bw);
    minh = min(r(:));
    maxh = max(r(:));
    minl = min(c(:));
    maxl = max(c(:));
    H = maxh-minh;
    L = maxl-minl;
    %segno come altezza quello maggiore
    h = max(H,L);
    %segno come larghezza quello minore
    l = min(H,L);
    %controllo che l non sia nullo
    [u,d] = size(l);
    %se l non ha elementi, quindi immagine vuota, metto hl a 0  per non
    %dividere per 0
    if u == 0
        hl = 0;
    else
        %calcolo la proporzione altezza/larghezza
        hl = h/l;
    end 
    %proporzioni altezza/larghezza aggiunte ai descrittori
    DescriptorVector = [DescriptorVector hl];
    
    %numero maniglie aggiunte ai descrittori
    DescriptorVector = [DescriptorVector numeroManiglie(bw)];
    
    %distanze dal centroide(sempre 60) aggiunte ai descrittori  
    DescriptorVector = [DescriptorVector distanzaAngolo(bw)];
    
    %centroide dell'oggetto aggiunte ai descrittori
    DescriptorVector = [DescriptorVector belongs(bw)];
    
    %calcolo l'area minima dell'immagine convessa che contiene l'oggetto
    %rilevato dalla binarizzazione
    conv = bwconvhull(bw);
    AreaConv = sum(sum(conv(:,:)));
    %la divisione tra area convessa e area aggiunte ai descrittori
    DescriptorVector = [DescriptorVector AreaConv/Area2];
    
    %il numero di buchi interni all'oggetto aggiunte ai descrittori
    DescriptorVector = [DescriptorVector numeroBuchi(bw);];
    
    %la proiezione dell'oggetto aggiunte ai descrittori
    [proH, proL] = proiezione(bw);
    DescriptorVector = [DescriptorVector proH proL];
end
