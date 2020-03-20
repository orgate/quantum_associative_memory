%function [pattern_search] = pattern_search(pattern_cells_range,marked_pattern_cell,step_by_step_mode)
clear all;



                 
 P = [1;
      0];  % |0>

 Q = [0;
      1];  % |1> 


  
  
  
quam = input('Do you want to implement Quantum Associative Memory or just pattern store and recall? If quam, enter "1", else enter "0"\n','s');





if (str2num(quam)~=1)
pattern_cells_range = input('Please enter the cell range below, corresponding to the patterns to be stored from patterns.xlsx (for example "A3:A20" (without quotes)): \n','s');

marked_pattern_cell_range = input('Please enter the cell address of the marked pattern below(for example "A16" (without quotes)): \n','s');

step_by_step_mode_string = input('Please enter "1" below to see the graphs of phi at each stage, else enter "0" to just see the graphs for every grover iteration alone: \n','s');
step_by_step_mode = str2num(step_by_step_mode_string);

%pattern_search=1;
pattern_set = xlsread('patterns.xlsx',pattern_cells_range);
%marked_pattern = xlsread('patterns.xlsx',char([marked_pattern_cell,':',marked_pattern_cell]));
marked_pattern_set = xlsread('patterns.xlsx',marked_pattern_cell_range);

pattern_set_size=size(pattern_set);
pattern_max=max(pattern_set);
pattern_size=length(char(dec2bin(pattern_max)));

for a=1:pattern_set_size(1)
    z{a}=char(dec2bin(pattern_set((pattern_set_size(1)-a+1),1),pattern_size));
end

    z{pattern_set_size(1)+1}=char(dec2bin(0,pattern_size));

    
    
marked_pattern_set_size=size(marked_pattern_set);
%marked_pattern_max=max(marked_pattern_set);
marked_pattern_size=length(char(dec2bin(pattern_max)));

for a=1:marked_pattern_set_size(1)
    beta{a}=char(dec2bin(marked_pattern_set((marked_pattern_set_size(1)-a+1),1),marked_pattern_size));
end







else
    pattern_cells_range = input('Please enter the cell range below, corresponding to the patterns to be stored from QuAM.xlsx (for example "A3:A20" (without quotes)): \n','s');
    marked_pattern = input('Please enter some  < n bits of the pattern to be searched for from the set\n','s');
    
    step_by_step_mode_string = input('Please enter "1" below to see the graphs of phi at each stage, else enter "0" to just see the graphs for every grover iteration alone: \n','s');
step_by_step_mode = str2num(step_by_step_mode_string);
pattern_set = xlsread('QuAM.xlsx',pattern_cells_range);
pattern_set_size=size(pattern_set);
pattern_max=max(pattern_set);
pattern_size=length(char(dec2bin(pattern_max)));

for a=1:pattern_set_size(1)
    z{a}=char(dec2bin(pattern_set((pattern_set_size(1)-a+1),1),pattern_size));
end

    z{pattern_set_size(1)+1}=char(dec2bin(0,pattern_size));

    
 for b=1:pattern_size      

     for i=1:length(marked_pattern)
            if  (str2num(marked_pattern(i)) == 0)
                 M{i} = P;
            else M{i} = Q;
            end
     end
     
     for j=1:pattern_size-length(marked_pattern)
                 M{length(marked_pattern)+j} = P;
     end
     
 end

   
     
 for c=1:pattern_size      

     for i=1:length(marked_pattern)
            if  (str2num(marked_pattern(i)) == 0)
                 N{i} = P;
            else N{i} = Q;
            end
     end
     
     for j=1:pattern_size-length(marked_pattern)
                 N{length(marked_pattern)+j} = Q;
     end
     
 end

 
 beta_state_quam1 = zeros((2^pattern_size),1);
    
beta_temp_quam1 = M{1};
 
 for j1=2:pattern_size
        
     beta_temp_quam1 = kron(beta_temp_quam1, M{j1});
        
 end
 
 beta_state_quam1 = beta_state_quam1 + beta_temp_quam1;

 beta_temp_quam2 = N{1};
 
 for j2=2:pattern_size
        
     beta_temp_quam2 = kron(beta_temp_quam2, N{j2});
        
 end
 
 beta_state_quam1 = beta_state_quam1 + beta_temp_quam2;
 quam_set = 0;
 quam_count = 1;
 
 for j3 = 1:(2^pattern_size)
     if (beta_state_quam1(j3)==1)
         if (quam_set==1)
         beta_state_quam1(j3)=1;
         quam_set=0;
         quam_count=quam_count+1;
         else
             beta_state_quam1(j3)=1;
             quam_set=1;             
         end
     else
         if (quam_set==1)
             beta_state_quam1(j3)=1;
             quam_count=quam_count+1;
         else
             beta_state_quam1(j3)=0;
             
         end
     end

 end
 
 beta_quam = sqrt(1/quam_count)*beta_state_quam1;

 
end

%beta_state = sqrt(1/m)*beta_state;










%z = {'11111111', '11110000', '10101010', '10010011', '01100110', '01010101', '00011001', '00000000'};
%z = { '1111', '1100', '1001', '0110', '0011', '0000'};
%z = {'111', '101', '110','100', '011', '010', '001', '000'};
% z = {'11', '10', '01', '00'};
% z = {227, 169, 134, 248};
%f = struct('x', [], 'g', [], 'c1', [], 'c2', []);

%wordstruct = struct{ 'violet', 0, 'indigo', 1, 'blue', 2, 'green', 3, 'yellow', 4, 'orange', 5, 'red', 6, 'cyan', 7, 'magenta', 8, 'brown', 9, 'black', 10, 'white', 11, 'pink', 12, 'gray', 13, 'cream', 14, 'purple', 15};



f = struct('coeff', 0, 'x', [], 'g', [], 'c', []);


m_temp = size(z)-1;
m = m_temp(2);
               F0 = [0,1,0,0;
                     1,0,0,0;
                     0,0,1,0;
                     0,0,0,1];

               F1 = [1,0,0,0;
                     0,1,0,0;
                     0,0,0,1;
                     0,0,1,0];



n_temp = size(z{1});
n = n_temp(2);

Y = [];
W = [];
X = [];
G = [];
D = [];
coeff = 0;
D1 = [];
C2 = [];
A = [];
C = [];
kron_temp = [];

phi_matrix = [];
phi = zeros(1,(2^n));

len = 1;
                    
                    
                    
                    
%Initialising register X with zeroes
for i = 1:n
             X{1,i} = P;
end

%Initialising register C with zeroes (tensor product of c1 & c2 qubits)
%C = kron(f.c1,f.c2); 

%Initialising register G with zeroes
for i = 1:n-1
             G{1,i} = P;
end


  
f(1).x = X;
f(1).g = G;
f(1).c{1} = P;
f(1).c{2} = P;
f(1).coeff = 1;


if(step_by_step_mode==1)
    fprintf('phi initialized\n');
    phi = struct_to_phi(f);
    bar(abs(phi(1:(2^n))));
    pause;
end


%Algorithm

for pm = 1:m
    p=m-pm+1;
    for q = 1:len
    %Storing the pth & (p+1)th pattern as a matrix of P & Q matrices
        for i = 1:n
            if  (str2num(z{p}(i)) == 0)
                 Y{i} = P;
            else Y{i} = Q;
            end  
            if  (str2num(z{p+1}(i)) == 0)
                 W{i} = P;
            else W{i} = Q;
            end 
         end
    %Z = Y(1);
    %for k = 2:n
       %Z = kron(Y(i),Z);
    %end
    
    
    
    
    %Steps 3 to 5
        for i = 1:n
            if (Y{i} ~= W{i})
                c2xi = kron(f(q).c{2},f(q).x{i});
            
             c2xi = F0*c2xi; %quantum gate implementation
            
             kron_temp1 = decompose_kron(c2xi);
%            f.c2 = kron_temp(1);

%              fprintf('xj');
%              i
%              kron_temp{2}
              f(q).x{i} = kron_temp1{2};
%               print(f(q).x(i));
            
%             if (X(i)==P && f.c2==P) 
%                 X(i) = Q;
%             end
%             if (X(i)==Q && f.c2==P) 
%                 X(i) = P;
%             end
            end
        end
%     
%     fprintf('phi after 5th step\n');
%     phi = struct_to_phi(f);
%     bar(abs(phi(1:(2^n))));
%     pause;
% 
%         
        
    %Step 6
%    C = F*C1;

             c2c1 = kron(f(q).c{2},f(q).c{1});
             
%            f(q).c{1}
            c2c1 = F0*c2c1; %quantum gate implementation
            
            kron_temp2 = decompose_kron(c2c1);
%            f.c2 = kron_temp(1);
            f(q).c{1} = kron_temp2{2};
%            q
%            fprintf('fqc1');
%            f(q).c{1}
    end
   
%     fprintf('phi after 6th step, i.e. after FLIP\n');
%     phi = struct_to_phi(f);
%     bar(abs(phi(1:(2^n))));
%     pause;

    
if(step_by_step_mode==1)
    fprintf('phi after 6th step, i.e. after FLIP\n');
    phi = struct_to_phi(f);
    bar(abs(phi(1:(2^n))));
    pause;
end

    
    
    
    %Step 7
    for q=1:len
    S =[1,0,0,0;
        0,1,0,0;
        0,0,sqrt((p-1)/p), -1/sqrt(p);
        0,0,1/sqrt(p),sqrt((p-1)/p)];

    c1c2 = f(q).coeff*kron(f(q).c{1},f(q).c{2});
%    c1c2
    
    c1c2 = S*c1c2;
%    c1c2

%     fprintf('phi after S\n');
%     phi = struct_to_phi(f);
%     bar(abs(phi(1:(2^n))));
%     pause;
% 
%     
    
    for r=1:4
        if (c1c2(r)~=0)
          switch(r)
              case 1
                  f(q).coeff = c1c2(r);
%                   f.c{1} = P;
%                   f.c{2} = P;
              case 2 
                  f(q).coeff = c1c2(r);
%                   f.c{1} = P;
%                   f.c{2} = Q;
              case 3
%                  f(q).c{2}
                  if (f(q).c{2} ~= P)
%                     c1c2 
                     if (c1c2(4)==0)
                          f(q).coeff = c1c2(r);
                          f(q).c{1} = Q;
                          f(q).c{2} = P;
                      else
                          f(len+1).coeff = c1c2(r);
                          f(len+1).c{1} = Q;
                          f(len+1).c{2} = P;
                          f(len+1).x = f(q).x;
                          f(len+1).g = f(q).g;
                          len = len+1;
                          f(len).coeff;
                          f(len).x;
                          f(len).g;
%                          len
                      end
                   else
                      f(q).coeff = c1c2(r);
                      f(q).coeff;
                  end
              case 4
%                  f(q).c{2}
                  if (f(q).c{2} ~= Q)
%                      c1c2
                      if (c1c2(3)==0)
                          f(q).coeff = c1c2(r);
                          f(q).c{1} = Q;
                          f(q).c{2} = Q;
                      else
                          f(len+1).coeff = c1c2(r);
                          f(len+1).c{1} = Q;
                          f(len+1).c{2} = Q;
                          f(len+1).x = f(q).x;
                          f(len+1).g = f(q).g;
                          len = len+1;
                          f(len).x;
                          f(len).g;
                          f(len).coeff;
%                          len
                      end
                  else
                      f(q).coeff = c1c2(r);
                  end
            end
      
        end
    end
    
    
%     
%     fprintf('phi after adding extra states if required\n');
%     phi = struct_to_phi(f);
%     bar(abs(phi(1:(2^n))));
%     pause;
% 
%     
    end
    
%     
%     fprintf('phi after 7th step\n');
%     phi = struct_to_phi(f);
%     bar(abs(phi(1:(2^n))));
%     pause;

       
if(step_by_step_mode==1)
    fprintf('phi after 7th step, i.e. after applying S\n');
    phi = struct_to_phi(f);
    bar(abs(phi(1:(2^n))));
    pause;
end

 
    
    
    %Step 8 to 14
    %Choosing the suitable A matrix (Fredkin gate) 
    %for the current pattern
 
    for q=1:len
        
    %Step 8 to 10
            Az1z2 = matrix_A(z{p}(1:2));
 %           f
            x1x2g1 = kron(kron(f(q).x{1},f(q).x{2}),f(q).g{1});
            
            x1x2g1 = Az1z2*x1x2g1; %quantum gate implementation
            
            kron_temp3 = decompose_kron(x1x2g1);
%            X(1) = kron_temp(1);
%            X(2) = kron_temp(2);
            f(q).g{1} = kron_temp3{3};
%            f(q).g{1}
% 
%     fprintf('phi after 8th step\n');
%     phi = struct_to_phi(f);
%     bar(abs(phi(1:(2^n))));
%     pause;
% 

        
        for k=3:n
            Azk1 = matrix_A(char([z{p}(k), '1']));
            xkgk2gk1 = kron(kron(f(q).x{k},f(q).g{k-2}),f(q).g{k-1});
            
            xkgk2gk1 = Azk1*xkgk2gk1; %quantum gate implementation
            
            kron_temp4 = decompose_kron(xkgk2gk1);
%            X(1) = kron_temp(1);
%            X(2) = kron_temp(2);
            f(q).g{k-1} = kron_temp4{3};
        end
% 
%     fprintf('phi after 10th step\n');    
%     phi = struct_to_phi(f);
%     bar(abs(phi(1:(2^n))));
%     pause;
% 
%     
%     
    %Step 11 

            gn1c1 = kron(f(q).g{n-1},f(q).c{1});
            
            gn1c1 = F1*gn1c1; %quantum gate implementation
            
            kron_temp5 = decompose_kron(gn1c1);
%            X(1) = kron_temp(1);
            f(q).c{1} = kron_temp5{2};
%            f(q).c{1}

%             
% 
%     fprintf('phi after 11th step\n');    
%     phi = struct_to_phi(f);
%     bar(abs(phi(1:(2^n))));
%     pause;
% 
%            
           %Step 12 to 14

        for k1=3:n
            k=n-k1+3;
            Azk1 = matrix_A(char([z{p}(k), '1']));
            xkgk2gk1 = kron(kron(f(q).x{k},f(q).g{k-2}),f(q).g{k-1});
            
            xkgk2gk1 = Azk1*xkgk2gk1; %quantum gate implementation
            
            kron_temp6 = decompose_kron(xkgk2gk1);
%            X(1) = kron_temp(1);
%            X(2) = kron_temp(2);
            f(q).g{k-1} = kron_temp6{3};
        end
        
%     fprintf('phi after 13th step\n');    
%     phi = struct_to_phi(f);
%     bar(abs(phi(1:(2^n))));
%     pause;
% 
%         
            Az1z2 = matrix_A(z{p}(1:2));
            x1x2g1 = kron(kron(f(q).x{1},f(q).x{2}),f(q).g{1});
            
            x1x2g1 = Az1z2*x1x2g1; %quantum gate implementation
            
            kron_temp7 = decompose_kron(x1x2g1);
%            X(1) = kron_temp(1);
%            X(2) = kron_temp(2);
            f(q).g{1} = kron_temp7{3};

    end
    
%     
%     fprintf('phi after 14th step\n');    
%     phi = struct_to_phi(f);
%     bar(abs(phi(1:(2^n))));
%     pause;

          
if(step_by_step_mode==1)
    fprintf('phi after 14th step, i.e. after SAVE\n');
    phi = struct_to_phi(f);
    bar(abs(phi(1:(2^n))));
    pause;
end



    
end
        
fprintf('phi after before passing to grover\n');    
phi = struct_to_phi(f);
bar(abs(phi(1:(2^n))));
pause;

if (str2num(quam)~=1)
result = mod_grover_search(phi',beta);
else
    result = mod_grover_search_quam(phi',beta_quam);

end
%end