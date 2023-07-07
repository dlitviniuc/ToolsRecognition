%Calcola i descrittori delle immagini e li salva su file.
function create_descriptor_files()
  %leggo il contenuto di due file: images.list e labels.list
  [images, labels] = readlists();
  %numel(images) ritorna il numero degli elementi (nimages) in images
  nimages = numel(images);
  
  %inizializzo i vettori dei descrittori
  pers = [];
  lbp = [];
  qhist = [];

  for n = 1 : nimages
    %disp(n) ritorna il valore della variabile n 
    %senza stampare il nome della variabile
    disp(n);
    im = imread(['dataset/' images{n}]);
    
    pers   = [pers ; descrittori(im)];
    lbp  = [lbp ; compute_lbp(im)];
    qhist = [qhist; compute_qhist(im)];
  end
  
  save('risorse/pers','pers');
  save('risorse/lbp','lbp');
  save('risorse/qhist','qhist');
end