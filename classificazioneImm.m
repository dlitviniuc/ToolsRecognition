%la funzione riceve un'immagine in input
function label = classificazioneImm(im)
%carico il file dell'albero di decisione
    class = load('risorse/trt2.mat');
    %inizializzo il vettore dei descrittori
    desc = [];    
    %calcolo i descrittori desc in ordine
    desc = [desc descrittori(im)];
    desc = [desc compute_lbp(im)];
    desc = [desc compute_qhist(im)];
    %controllo nell'albero di decisione a cosa coincidono i descrittori
    %label = predict(class.c, desc);
    label = class.trt2.predictFcn(desc);
end