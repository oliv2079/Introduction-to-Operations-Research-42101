using JuMP, GLPK

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

