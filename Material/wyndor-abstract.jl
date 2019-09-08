using JuMP, GLPK

m = 3 # number of plants
n = 2 # number of products
b = [4 12 18] # hours available on plant i per week
p =[3 5 ] # profit per batch of product
a = [   1 0;
        0 2;
        3 2]

model = Model(with_optimizer(GLPK.Optimizer))
# x[j]: how many batches of product j should we make per week
@variable(model, x[j=1:n] >= 0 )

@objective(model, Max, sum(p[j]*x[j] for j=1:n) )
@constraint(model, [i=1:m], sum(a[i,j]*x[j] for j=1:n) <= b[i] )

print(model)

optimize!(model)

println("Objective value: ", JuMP.objective_value(model))
println("x = ", JuMP.value.(x))
