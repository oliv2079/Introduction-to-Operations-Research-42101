%Initialization: ------------------------------

%Row 0: non-basic variables as negative values:
c=[-2, 2, -1];

%Non-Basic Variables (Not currently used as rows, RHS=0)
A=[-2 2 1; 1 -1 0; 1 -1 3];

%Basic Variables (currently used as rows)
I=[1 0 0; 0 1 0; 0 0 1];  
zeroR=zeros(1, size(I, 1)) %0 row vector
zeroC=zeros(size(I, 2), 1) %0 column vector

%RHS (not including row 0)
b=[5; 5; 14]
%----------------------------------------------

%If we know what the entering variables are we can compute the resulting tableau:

%Choose the basic variables:
B=[2 0 0; -1 1 0; -1 0 1]

%Row 0 of basic variables (negative relative to tableau):
cB=transpose([2, 0, 0])

#--------------------------------------------------------------------------------

#Optimality test:
cB*inv(B)*A-c #c