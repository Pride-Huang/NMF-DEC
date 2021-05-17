clf;
clear;
clc;

options=[];
options.maxIter=200;
options.error=1e-4;
options.nRepeat=30;
options.minIter=50;
options.meanFitRatio=0.1;
options.rounds=30;
options.kmeans=1;
lamda=0.1;

load Washington.mat 

[S,~,~] = zscore(S');
matrix_sim=similarity(S','Pearson') ;

K=max(gnd);

k=8;
alpha=0.8;
beta=1.0;

Fset=Funcset;

M=createMatrix_M(AdjMtx,k);   
NMIList_alpha=[];

disp(['iteration= ',num2str(k),',',num2str(alpha),',',num2str(beta)]);
[B,F1,F2]=Fset.initialPara(matrix_sim,M,K,options);

disp('compute ......');
[B,F1,F2]=iterationNew(M,AdjMtx,matrix_sim,B,F1,F2,beta,alpha,k);
                
F=[F1',F2'];
[Idx,C,sumD,D]=kmeans(F,K,'Replicates',100);
NMI=compute_NMI(gnd,Idx)

disp([datetime(now,'ConvertFrom','datenum')]);



