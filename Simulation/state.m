function [state_in_matrix] = state(i,len)

state_in_matrix = zeros(len,1);
    
if(i<0 || i>len-1)
  fprintf('State should be between 0 and 2 power of the lenght of the bits \n');
else
   state_in_matrix(i+1,1) = 1;
end


end