function [mod_grover_beta_iterate] = mod_grover_search(phi,beta)

%m = size(beta);
m_temp = size(beta);
m = m_temp(2);
l_temp = size(beta{1});
l = l_temp(2);
n_temp = size(phi);
n = n_temp(1);


                 
 P = [1;
      0];  % |0>

 Q = [0;
      1];  % |1> 

beta_state = zeros((2^l),1);
  
for p=1:m

    beta_char = beta{p};
    
 for i=1:l
            if  (str2num(beta_char(i)) == 0)
                 Y{i} = P;
            else Y{i} = Q;
            end  
 end
    
beta_temp = Y{1};
 
 for j=2:l
        
     beta_temp = kron(beta_temp, Y{j});
        
 end
 
 beta_state = beta_state + beta_temp;
    
end

beta_state = sqrt(1/m)*beta_state;

% beta_state = beta_temp;
 
%beta_state = state(beta-1);
 phi0 = (sqrt(1/(2^l))*ones((2^l),1));

%phi = zeros(256,1);
% j=0;
% for i=1:256
%     if mod(i,8)==0
%         phi(i) = 1;
%         j=j+1;
%     end
% end
% 
% 
% 
% phi = sqrt(1/j)*phi;
% 
oracle = eye(2^l) - 2*beta_state*beta_state';

%HIH = 2*phi0*phi0' - eye(2^l);

H = sqrt(1/2)*[1, 1;
               1, -1];

Hn = sqrt(1/2)*[1, 1;
               1, -1];

           
I = 2*state(0,(2^l))*state(0,(2^l))' - eye(2^l);


for h=1:l-1
    Hn = kron(Hn, H);
end



HIH = Hn*I*Hn;
oracle1 = eye(2^l) - 2*phi*phi';

%grover_beta_iterate = zeros(256, 20); % info about grover_beta after every iteration

mod_grover_beta = phi;
mod_grover_beta = oracle*mod_grover_beta;
mod_grover_beta = HIH*mod_grover_beta;

fprintf('grover iterations begin\n');
bar(abs(mod_grover_beta(2:(2^l))));
pause;


mod_grover_beta = oracle1*mod_grover_beta;
mod_grover_beta = HIH*mod_grover_beta;


bar(abs(mod_grover_beta(2:(2^l))));
pause;
    
    
r = ((pi/4)*(sqrt(n/m)));

%grover iterations approximately r times
for i=1:floor((pi/4)*sqrt(n/m)+10)
    mod_grover_beta = oracle*mod_grover_beta;
    mod_grover_beta = HIH*mod_grover_beta;
    mod_grover_beta_iterate(:,i) = abs(mod_grover_beta);
    
    bar(abs(mod_grover_beta(2:(2^l))));
    pause;
end

end