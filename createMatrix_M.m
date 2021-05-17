function [Matrix_M]=createMatrix_M(A,k)
    Matrix_D=sum(A);
    D=sum(Matrix_D);
    Matrix_M=A;
    [row,col,weight]=find(A);
    for i=1:length(col)
        %score=log( (weight(i)+S(row(i),col(i)))*D / ( Matrix_D(row(i))*Matrix_D(col(i)) ) )-log(k);
        score=log( (weight(i))*D / ( Matrix_D(row(i))*Matrix_D(col(i)) ) )-log(k);
        if score==inf
            score=0;
        end
        if score<=0
            Matrix_M(row(i),col(i))=0;
        else
            Matrix_M(row(i),col(i))=score;
        end
    end
%           Matrix_M(row(i),col(i))=score;
%     end
%     Matrix_M(isinf(Matrix_M))=min(Matrix_M(~isinf(Matrix_M(:))));
%     Matrix_M=Matrix_M-min(Matrix_M(:));
end
        

        
    

