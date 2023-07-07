close all;
clear all;
%carico i descrittori
load('risorse/pers');
load('risorse/qhist');
load('risorse/lbp');
%leggo le due liste
[images, labels]= readlists();
%separo il dataset in due parti, mantenendo 20% per testing
cv = cvpartition(labels,'Holdout',0.2);
%test classificazione con albero di decisione semplice su descrittori
%personalizzato
[tr1, ts1] = test_classifier(pers,labels,cv)
%test classificazione con albero di decisione semplice su descrittori lbp
[tr2, ts2] = test_classifier(lbp,labels,cv)
%test classificazione con albero di decisione semplice su descrittori qhist
[tr4, ts4] = test_classifier(qhist,labels,cv)
%unisco i tre descrittori
comb6 = [pers lbp qhist];
%salvo i descrittori uniti per utilizzo futuro, specialmente in
%classification learner
save("risorse/comb6", "comb6");
%faccio il training usando l'insieme dei classificatori usando bagged
%trees, questa funzione è stata generata da classification learner
[trt2, tst2] = trainClassifierEnsamble(comb6,labels);
%salvo il classificatore per uso futuro, specificatamente per classificare
save("risorse/trt2", "trt2");
%mostro a console la validation accuracy del classificatore
tst2


