# compiler-demo
# Function: 
Input a chemical formula to calculate the relative mass.

(Some uncommon elements are not supported, like those after Line 6 on the periodic table)

# Compile and Run:

environment: Ubuntu 20.04 

dependencies: flex, bison

# Input Rules:
1. Supported characters include alphabets(A-Za-z), digits, underscore(_), joint mark(-), brackets, square brackets; Ignore spaces and line breakers;
2. All subscript numbers should go after an underscore character;
3. Use a semicolon to finish your formula; Input "exit" to terminate the process;
4. Warning "unrecognized word" means encountering illegal element names; Warning "syntax error" means errors in format;

# Example 
For $CuSO_4·5H_2O$, input "CuSO_4-5H_2O"; 

For $[Co(H_2O)_6]$ $(ClO_4)_2$, input [Co(H_2O)_6] (ClO_4)_2;

![image](https://github.com/XiaozhuYv/compiler-demo/assets/65002203/e7cd0ab9-cf5a-4d46-9d23-0a6c3f7b6b61)




