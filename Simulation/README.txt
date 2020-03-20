NOTE:
1) This folder should contain  19 files.
2) The pattern_search.m is the main file.
3) The excel sheet - patterns.xlsx has the list of inputs that is given to the program where we could mention more marked patterns. You could edit the excel sheet and mention the cell range while runnig the program.
4) The excel sheet - QuAM.xlsx has the list of inputs that is given to the quam part of the program. You could edit the excel sheet and mention the cell range while runnig the program.
5) Please enter values from the same column for the wherever ranges has been asked for both the below instructions.
6) Note that, during the simulation, especially, during the Pattern Store algorithm, we might see sometimes, probabilities of some qubits crossing above 1. The reason for this behaviour is because the probalities corresponding to different f qubits getts added, where the x qubits are identical. This is done while plotting the intermediate state of |phi>, but, it does not affecct the final result. It is also briefly mentioned in the project report.
7) Note, in the file QuAM.xlsx, the columns that have the binary representation of the adjacent decimal numbers can not be used as the cell range, because they are referenced to some other cell in the sheet.



Procedure to run the program:
1) Type in the command prompt of MATLAB: pattern_search.m
2) Now, for the following instructions, that appear on the command prompt of MATLAB, we have ahown using an example:



a) Case for QuAM:
Do you want to implement Quantum Associative Memory or just pattern store and recall? If quam, enter "1", else enter "0"
1

Please enter the cell range below, corresponding to the patterns to be stored from QuAM.xlsx (for example "A3:A20"):
E66:E116

Please enter some  < n bits of the pattern to be searched for from the set
1100

Please enter "1" below to see the graphs of phi at each stage, else enter "0" to just see the graphs for every grover iteration alone:
1




b) Case for many marked patterns:
Do you want to implement Quantum Associative Memory or just pattern store and recall? If quam, enter "1", else enter "0"
0

Please enter the cell range below, corresponding to the patterns to be stored from patterns.xlsx (for example "A3:A20"):
A4:A18

Please enter the cell range of the marked pattern set, below(for example "A16:A16" or "A7:A13"):
A5:A9

Please enter "1" below to see the graphs of phi at each stage, else enter "0" to just see the graphs for every grover iteration alone:
1



The files given in here are:
1)Files belonging to case 1:
a) case1.xlsx, case1_before_grover.xlsx and case1_after_grover.xlsx
b) In this case, we used pattern.xlsx and checked what happens when we have marked patterns out of the pattern set.

2)Files belonging to case 2:
a) case2.xlsx, case2_before_grover.xlsx and case2_after_grover.xlsx
b) In this case, we used pattern.xlsx and checked what happens when we have marked patterns inside the pattern set.

3)Files belonging to case 3:
a) case3.xlsx, case3_before_grover.xlsx and case3_after_grover.xlsx
b) In this case, we used QuAM.xlsx and checked what happens when we have less number of bits for searching a pattern.

4) Main file:
pattern_search.m

5) Function files:
decompose_kron.m, matrix_A.m, mod_grover_search.m, mod_grover_search_quam.m, state.m and struct_to_phi.m

6) Additional files:
patterns.xlsx - Used for reading the pattern set for the case1 and 2, where the pattern set and the marked pattern are given as some cell ranges.
QuAM.xlsx - Used for reading the pattern set for the case 3, where the pattern set is read from this file, whereas the pattern to be marked is mentioned by fewer bits than required for that particular pattern.


