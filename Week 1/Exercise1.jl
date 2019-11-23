using JuMP, GLPK

#Exercise 1
m = Model(with_optimizer(GLPK.Optimizer))

@variable(m,x1>=0)
@variable(m,x2>=0)
@variable(m,x3>=0)

@objective(m, Max, 20*x1 + 20*x2 + 70*x3)

@constraint(m, 2*x1 + x2 + 3*x3 <= 22)
@constraint(m, 1*x2+2*x2+4*x3<=20)
@constraint(m, x1+x2+x3<=100)

status = optimize!(m)

println("Objective value: ", JuMP.objective_value(m))
println("x1 = ",JuMP.value(x1))
println("x2 = ",JuMP.value(x2))
println("x2 = ",JuMP.value(x3))


#Exercise 2
m = Model(with_optimizer(GLPK.Optimizer))

@variable(m,x1>=0)
@variable(m,x2>=0)

@objective(m, Max, x1 + 2*x2)

@constraint(m,   x1 + 3*x2 <= 200)
@constraint(m, 2*x1 + 2*x2 <= 300)
@constraint(m,          x2 <=60)

status = optimize!(m)

println("Objective value: ", JuMP.objective_value(m))
println("x1 = ",JuMP.value(x1))
println("x2 = ",JuMP.value(x2))


#Exercise 3
m = Model(with_optimizer(GLPK.Optimizer))

@variable(m,x1>=0)
@variable(m,x2>=0)

@objective(m, Max, 4500*x1 + 4500*x2)

@constraint(m, 5000*x1 + 4000*x2 <= 6000)
@constraint(m,  400*x1 +  500*x2 <= 600)

status = optimize!(m)

println("Objective value: ", JuMP.objective_value(m))
println("x1 = ",JuMP.value(x1))
println("x2 = ",JuMP.value(x2))


#Exercise 4
m = Model(with_optimizer(GLPK.Optimizer))

@variable(m,x1>=0)
@variable(m,x2>=0)

@objective(m, Min, 4*x1 + 2*x2)

@constraint(m,  5*x1 + 15*x2 >= 50)
@constraint(m, 20*x1 +  5*x2 >= 40)
@constraint(m, 15*x1 +  2*x2 <= 60)

status = optimize!(m)

println("Objective value: ", JuMP.objective_value(m))
println("x1 = ",JuMP.value(x1))
println("x2 = ",JuMP.value(x2))


