using JuMP, GLPK


#Exercise 1
A=[1 2 1; 2 2 3; 3 1 1]
I=[1 0 0; 0 1 0; 0 0 1]
B=[1 2 0; 2 2 1; 3 1 0]
b=[70; 210; 200]
c=transpose([6,7,3])
cB=transpose([6;7;0])
zero=transpose([0,0,0])

cB*inv(B)*A-c
inv(B)*A
cB*inv(B)
inv(B)
cB*inv(B)*b
inv(B)*b


    #Check Answers:
    m = Model(with_optimizer(GLPK.Optimizer))

    @variable(m,x1>=0)
    @variable(m,x2>=0)
    @variable(m,x3>=0)

    @objective(m, Max, 6*x1 + 7*x2 + 3*x3)

    @constraint(m, x1 + 2*x2 + x3 <= 70)
    @constraint(m, 2*x2+2*x2+3*x3<=210)
    @constraint(m, 3*x1+x2+x3<=200)

    status = optimize!(m)

    println("Objective value: ", JuMP.objective_value(m))
    println("x1 = ",JuMP.value(x1))
    println("x2 = ",JuMP.value(x2))
    println("x3 = ",JuMP.value(x3))

#Exercise 2
R0=[-1, -1, -2, 0, 0,  0, -18]
R1=[0 ,  1,  2, 1, 0,  0, 18]
R2=[0 , -2,  1, 0, 1,  0, 3]
R3=[0 , 1,  -2, 0, 0, 1, 2]

R2n=R2/1
R0n=R0+2*R2n
R1n=R1-2*R2n
R3n=R3+2*R2n

R2=R2/1
R0=R0+2*R2n
R1=R1-2*R2n
R3=R3+2*R2n

R1n=R1/5
R0n=R0+5*R1n
R2n=R2+2*R1n
R3n=R3+3*R1n


R0=[-1, -1, -3, 0, 0, 0]
R1=[0, 1, 0, -0.4, 0, 2.4]
R2=[0, 0, 1, 0.2,  0, 7.8]
R3=[0, 0, 0, 0.8, 1, 15.2]

R0+R1+3*R2



#Exercise 3
c=transpose([-2;2;-1])
A=[-2 2 1; 1 -1 0; 1 -1 3]
I=[1 0 0; 0 1 0; 0 0 1]
B=[2 0 0; -1 1 0; -1 0 1]
b=[5; 5; 14]
cB=transpose([2; 0; 0])
zero=transpose([0,0,0])

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



    #Check Answers:
    m = Model(with_optimizer(GLPK.Optimizer))

    @variable(m,x1)
    @variable(m,x2>=-2)

    @objective(m, Max,-2*x1-x2)

    @constraint(m, -2*x1+x2<=3)
    @constraint(m, x1<=5)
    @constraint(m, x1+3*x2<=8)

    status = optimize!(m)

    println("Objective value: ", JuMP.objective_value(m))
    println("x1 = ",JuMP.value(x1))
    println("x2 = ",JuMP.value(x2))
 


#Exercise 3 (revised)
c=[-2 2 -1]
B=[1 0 0; 0 1 0; 0 0 1]
b=[5; 5; 14]
A=[-2 2 1; 1 -1 0; 1 -1 3]
cB=[0 0 0]

cB*inv(B)*A-c #-2 most negative number, x1- is entering the basis

inv(B)*b
inv(B)*A[:,2] #A

B=[2 0 0; -1 1 0; -1 0 1]
cB=[2 0 0]
cB*inv(B)*A-c #c

B=[0 2 0; 0 0 1; 1 2 3]
inv(B)*[1 0; 0 2; 3 2]