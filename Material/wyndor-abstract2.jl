using JuMP, GLPK

include("wyndor-data2.jl")

model = Model(with_optimizer(GLPK.Optimizer))
# x[j]: how many batches of product j should we make per week
@variable(model, x[j=1:n] >= 0 )

@objective(model, Max, sum(p[j]*x[j] for j=1:n) )
@constraint(model, [i=1:m], sum(a[i,j]*x[j] for j=1:n) <= b[i] )

print(model)

optimize!(model)

println("Objective value: ", JuMP.objective_value(model))
println("x = ", JuMP.value.(x))
