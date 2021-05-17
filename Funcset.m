function Fset=Funcset
    Fset.initialPara=@initialPara;
    Fset.selectCluNorm=@selectCluNorm;
end


function K=selectCluNorm(W)
    W=double(W);
    [V,D]=eig(W);
    DD=diag(D);
    [Value,I]=sort(DD,'descend');
    VV=V(:,I);
    [n,~]=size(D);
    W_norm=norm(W,'fro');

    for K=1:n
        disp(['K=',num2str(K)]);
        ss=VV(:,1:K)*diag(Value(1:K))*VV(:,1:K)';
        if norm(ss,'fro')/W_norm>0.55
            break;
        end
    end
end

function [B,F1,F2]=initialPara(matrix_sim,M,K,options)
    B=[];
    F1=[];
    F2=[];
    [A1,B1,C1]=svds(matrix_sim,K);
    B=abs(A1*B1^0.5);
    F2=abs(B1^0.5*C1');
    F1=max(pinv(B)*M,0);
end

        
