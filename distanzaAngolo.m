%la funzione ottiene un'immagine binaria e ne calcola 60 distanze dal
%centroide, prese in modo equivalente per ogni immagine, in un cerchio
function dist = distanzaAngolo(bw)
%estraggo con sobel il margine dell'immagine
    mar = edge(bw, "sobel");
    %inizializzo ad array vuoto le distanza
    dist = [];
    %imposto quante distanze voglio calcolare
    num = 60;
    %estraggo le dimensioni dell'immagine binaria
    [t,s] = size(bw);
    %creo una secondaria immagine nera
    temp = zeros(t,s);
    %controllo se l'immagine ottenuta in input ha qualche oggetto
    %rappresentato
    Area = sum(sum(bw(:,:)));
    if Area > 0
        %estraggo il centro di gravità dell'oggetto
        stats = regionprops(im2double(bw),'centroid');
        x = floor(stats.Centroid(1));
        y = floor(stats.Centroid(2));
        %imposto una lunghezza per le linee, 300 è in base al fatto che per
        %calcolare i descrittori porto l'immagine a risoluzione 700x700,
        %con 300 riesco a ricoprire quasi sempre l'oggetto
        L = 300;
        %aggiungo a temp 60 linee di lunghezza L che partono dal centro di
        %gravità e arrivano fino ad un punto in base alla lunghezza e
        %all'angolo, quindi avrò una linea ogni 6 gradi
        for i=1:num
            xf = x+ L*cos((180/num)*i);
            yf = y+ L*sin((180/num)*i);
            xf = max(0, min(xf, s));
            yf = max(0, min(yf, t));
            temp = insertShape(temp, 'Line', [x,y,xf,yf]);
        end
        %insertShape inserisce elementi colorati, lo porto in binario
        temp = rgb2gray(temp);
        temp = imbinarize(temp);
        %rimuovo dagli edge i punti di intersezione con le linee create
        %sopra
        neg = mar - temp;
        %porto neg in valori logici
        neg = neg>0;
        %estraggo i punti di intersezione togliendo dagli edge i punti non
        %toccati dalle linee, restando solo coi punti dove si intersecano
        pti = mar - neg;
        pti = pti>0;
        %estraggo le coordinate dei punti rimasti
        [ri,co] = find(pti);
        %estraggo quanti punti sono rimasti
        len = size(ri);
        len = len(1);
        %calcolo lo step size, a volte una linea interseca più volte
        %l'oggetto e quindi non posso prendere direttamente le intersezioni
        %perchè per i descrittori mi serve un array di lunghezza costante
        n = len/num;
        for i=1:num
            step = ceil(i*n);
            step = step(1);
            if step <= len
                %estraggo un punto per ogni step e lo porto in una
                %struttura con x e y che sono il centro di gravità
                X = [x,y;ri(step),co(step)];
                %calcolo la distanza dal centro di gravità del punto
                d = pdist(X,'euclidean');
                %arrotondo la distanza
                d = floor(d);
                %aggiungo la distanza in un vettore con tutte le altre
                %calcolate prima
                dist = [dist d];
            else
                %se non ho raggiunto il numero richiesto, aggiungo 0 in
                %fondo all'array fino ad arrivare a num distanze
                dist = [dist 0];
            end
        end
%         %controllo quante distanze ho calcolato
%         [t,s] =size(dist);
%         %se ho meno di num distanze aggiungo 0 per il resto
%         for i=s+1:num
%             dist = [dist 0];
%         end
    else
        %se non c'è un oggetto rimasto imposto distanza 0 per tutte e num
        dist = zeros(1,num);
    end
end