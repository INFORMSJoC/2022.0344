function [matrix_name,matrix_store]=process_matrix(pool,matrix_name,matrix_store)
pool(pool==1)=-1;
[m,n]=size(matrix_name);
for i=m:-1:1
    max_number=max(sum(pool==matrix_name(i,:),2));
    if max_number<n-1
        matrix_name(i,:)=[];
        matrix_store(i)=[];
        break;
    end
end
end