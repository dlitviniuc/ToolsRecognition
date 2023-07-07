%close all;
%clear all;
%leggo un'immagine rgb
%im = imread("risorse/foto/im_group27.jpg");
%im = imread("risorse/foto/esempio4.jpg");
%im=imnoise(im, 'salt & pepper');

function out = Binarizzazione(im)
  %im=imnoise(im, 'salt & pepper');
    %siccome' il dataset contiene le immagini di diverse dimensioni
    %ad ogni immagine in input viene applicata la funzione myresize per
    %ridimensionarla sotto gli stessi paramenti
    im = myresize(im, 1400);
    %trasformo l'immagine in valori double tra 0 e 1
    im = im2double(im);
    %trasformo l'immagine a livelli di grigio
    im = rgb2gray(im);
    im = ordfilt2(im, 5, ones(3,3)); %filtro mediano su 3x3
    se = strel('disk', 100);
    im = imsubtract(imadd(im,imtophat(im,se)),imbothat(im,se));
    %idea principale della riga di sopra:
    %1) schiarisco gli oggetti che hanno dimensione minore
    %dell'elemento strutturale(disco di raggio 100)
    %im1 = imtophat(im,se);
    %2) scurisco le zone che hanno dimensione maggiore dell'elemento strutturale
    %per ottenere gli oggetti chiari
    %im2 = imbothat(im,se);
    %3) unisco im a livelli di grigio e im1 a cui ho applicato imtophat
    %per ottenere attorno gli oggetti le zone bianche senza dei dettagli
    %im3 = imadd(im,im1);
    %4) sottraggo im2 da im3, per ottenere l'immagine chaira (più di prima) 
    %con gli oggetti scuri (più di prima) 
    %im4 = imsubtract(im3,im2);
    
    %peggioro consapevolmente la visibilità dell'immagine, lavorando con 
    %le intensità dei pixel grigi (uso il gamma 0,3 che schiarisce l'immagine)
    %tutto è stato fatto con lo scopo di minimizzare la quantità dei dettagli dello sfondo 
    im = imadjust(im,[],[],0.3);
    %faccio l'inverso dell'immagine schiarita, ottenendo l'immagine buia
    im = ~im;
    %sopprimo le strutture luminose collegate al bordo dell'immagine
    %utilizzando la tecnica di 4-connettività
    im = imclearborder(im,4);
    %applico l'operazione di closing con il disco di raggio 35 
    background = imclose(im, strel('disk', 35));
    %unisco il background e im
    im = imadd(im, background);
    %calcolo la soglia da utilizzare in im2bw
    level = graythresh(im); 
    %trasformo l'immagine in bianco e nero
    bw = im2bw(im, level); 
    %calcolo la trasformata distanza dell'immagine
    out2 = bwdist(~bw);
    %applico l'operazione di closing con il disco di raggio 40
    out3 = imclose(out2,strel("disk",40)); 
    %porto l'output in valori logici
    out = out3>0;
    
    %imshow(out);
end
