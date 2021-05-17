function D=similarity(S,select)
[n,~]=size(S);
D=zeros(n,n);
if strcmp(select,'Kendall')
    D=corr(S','type','Kendall'); 
end 

if strcmp(select,'Pearson')
    D=corr(S','type','Pearson'); 
end

if strcmp(select,'Spearman')
 D=corr(S','type','Spearman'); 
end 

if strcmp(select,'Jaccard')
 D=1-pdist(S,'jaccard');%corr(S','type','Jaccard'); 
 D=squareform(D);
end 

D(isnan(D))=0;
D=abs(D);
