function [B,F1,F2]=iterationNew(M,A,S,B,F1,F2,belta,alpha,k)
    lossPre=realmax;
    lossCur=lossPre-(lossPre*1e-6);
    min=1e-10;

    lossPMI=0.001;
    times=20;
    
    i1=0;
    while(lossPMI>1e-10) && i1<times
        i1=i1+1;
        
        adj=(B*F2)';
        D=sum(adj,2);
        m=sum(sum(D))/2;
        
        X=(2*m*M)./max(min,(repmat(D,[1,size(D,1)]).*repmat(D',[size(D,1),1])));
        M=max(log(X)-log(k),0);
        
        i=1;
        while (abs(lossPre-lossCur)/lossPre)>1e-100 && i<times
            %update matrix F1,F2,B;
            F1=F1.*((B'*M)./max(min,B'*B*F1));
            F2=belta*F2.*((B'*S)./max(min,B'*B*F2));
            B=B.*((M*F1'+belta*S*F2')./max(min,alpha*B+belta*B*F2*F2'+B*F1*F1'));
            lossPre=lossCur;
            lossCur=lossCompute(M,S,B,F1,F2,belta);
            i=i+1;
        end

    end
end


function loss=lossCompute(M,S,B,F1,F2,belta)
        L1=norm((M-B*F1),'fro')^2;
        L2=belta*norm((S-B*F2),'fro')^2;
        L3=sum(sum(B));
        loss=L1+L2+L3;
end