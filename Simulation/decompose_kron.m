function [decompose_kron] = decompose_kron(h)

  

                 
 P = [1;
      0];  % |0>

 Q = [0;
      1];  % |1> 



  
  t = 0;
  l = size(h);  
  check = l(1);
  
    for i=1:l(1)
        if (h(i)==1) 
            t = i;
        end
    end
    
    ch1 = char(dec2bin(l(1)-1));
    ch2 = char(dec2bin(t-1,length(ch1)));
    
    j = length(ch1);
    for k = 1:j
        check = check/2;
        if(str2num(ch2(j)) == 0) 
            decompose_kron{k} = P;
        else decompose_kron{k} = Q;
        end
    end
    
    if (check ~= 1)
        fprintf('Error in decomposition of the kronecker product\n');
    end
end
  