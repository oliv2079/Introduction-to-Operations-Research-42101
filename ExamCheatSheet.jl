#INITIALIZATION: ------------------------------

#Row 0: non-basic variables as negative values:
c=transpose([10, 3, 2])

#Non-Basic Variables (Not currently used as rows, RHS=0)
A=[1 3 1; 2 2 1]  

#Basic Variables (currently used as rows)
I=[1 0 0; 0 1 0; 0 0 1]     
zeroR=zeros(1, size(I, 1)) #0 row vector
zeroC=zeros(size(I, 2), 1) #0 column vector

#RHS (not including row 0)
b=[19, 9, 20]
#----------------------------------------------
#If we know what the entering variables are we can compute the resulting tableau:

#Choose the basic variables:
B=[1 0.25 -0.5; 0 0.5 0; 0 -0.25 0.5] 

#Row 0 of basic variables (negative relative to tableau):
cB=transpose([2, 0, 7])
#--------------------------------------------------------------------------------
#Is S* and or y* known? (from final tableau)
S=[1 0.25 -0.5; 0 0.5 0; 0 -0.25 0.5]
y=transpose([-3.5,6.75])
#--------------------------------------------------------------------------------

#CALCULATIONS:

#Sensitivity (feasible region. If optimal region, add delta row to optimal tableau)
delta=[0,0,1]
inv(B)
inv(B)*b #B^-1*b
inv(B)*delta #B^-1*delta
#Then: B^-1*b + B^-1*delta >= zero vector
#Write it up as (#rows in B) equations and figure out the boundaries of delta.
cB*inv(B)*delta #y*
cB*inv(B)*b #Z*
#Objective value is then Z(delta)=Z*+detla*y(elements that had delta)
S*delta

#Fundamental insight
    #Row 0: (Often the only one necessary in exam)
    cB*inv(B)*A-c #c new
    cB*inv(B) #other new
    cB*inv(B)*b #result

    #Other rows:
    inv(B)*A #A new
    inv(B) #I new
    inv(B)*b #b new
#Fundamental insight (Final tableau things are known, like y*, S*)
    #Row 0:
    y*A-c
    cB*S #y*=cB*S
    y*b
    #Other rows:
    S*A
    S
    S*b




#Simplex Metoden /simplex method

R0=transpose([1, -6, -8, -6, 0, 0, 0, 0])
R1=transpose([0,1,2,1,1,0,0,16])
R2=transpose([0,2,1,2,0,1,0,9])
R3=transpose([0,2,1,1,0,0,1,11])

R1n=R1/2
R0n=R0+R1n*8
R2n=R2-R1n
R3n=R3-R1n

R1n=R1
R3n=R3-4*R2n

R0n
R1n
R2n
R3n

#Assignment problem

using JuMP
using GLPK

m = Model(with_optimizer(GLPK.Optimizer))

cost = [5 13 1 6;
        7 12 6 17;
        14 10 19 3;
        3 14 1 2]

n=4

@variable(m, x[1:n,1:n], Bin)
@objective(m, Min, sum(cost[i,j]*x[i,j] for i=1:n for j=1:n))
@constraint(m, [i=1:n], sum(x[i,j] for j=1:n) == 1)
@constraint(m, [j=1:n], sum(x[i,j] for i=1:n) == 1)

optimize!(m)

println("Objective Value: ", JuMP.objective_value(m))
println("Variable values ", JuMP.value.(x))


#APPENDIX-------------------------------------------------------

#Calculate new values 
inv(B)*A #A
inv(B) #I
inv(B)*b #b
cB*inv(B)*A-c #c

cB*inv(B) #z
cB*inv(B)*b #res


B=[1 -2 1; 0 1 0; 0 1 3]
cB=transpose([0; 2; 1])

inv(B)*A #A
inv(B) #I
inv(B)*b #b
cB*inv(B)*A-c #c

cB*inv(B) #z
cB*inv(B)*b #res
