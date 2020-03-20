function [phi_vector] = struct_to_phi( input )


temp_f=input;
len_temp=size(temp_f);
len=len_temp(2);

n_temp = size(temp_f(1).x);
n = n_temp(2);

phi_vector = zeros(1,(2^n));

for r=1:len
    phi_temp = temp_f(r).x{1};
    
    for s=2:n
        phi_temp = kron(phi_temp, temp_f(r).x{s});
        
    end
    
    phi_matrix(r,:) = phi_temp;
    phi_vector = phi_vector + temp_f(r).coeff*phi_matrix(r,:);      
end

end
