using JuMP, GLPK

###Question 1###

#Exercise 1

m = Model(with_optimizer(GLPK.Optimizer))
@variable(m, x1>=0, Int)
@variable(m, x2>=0, Int)
@variable(m, x3>=0, Int)
@variable(m, x4>=0, Int)
@variable(m, x5>=0, Int)
@variable(m, x6>=0, Int)
@variable(m, x7>=0, Int)

@objective(m, Max, 920*x1+530*x2+515*x3+720*x4+1127*x5+730*x6+1020*x7)
@constraint(m, 10*x1+8*x2+6*x3+9*x4+15*x5+10*x6+12*x7 <= 1500)
@constraint(m, x1<=12)
@constraint(m, x2<=31)
@constraint(m, x3<=20)
@constraint(m, x4<=25)
@constraint(m, x5<=50)
@constraint(m, x6<=40)
@constraint(m, x7<=60)

optimize!(m)

println("Objective value: ", JuMP.objective_value(m))
println("x1 = ", JuMP.value(x1))
println("x2 = ", JuMP.value(x2))
println("x3 = ", JuMP.value(x3))
println("x4 = ", JuMP.value(x4))
println("x5 = ", JuMP.value(x5))
println("x6 = ", JuMP.value(x6))
println("x7 = ", JuMP.value(x7))


#Exercise 3

m = Model(with_optimizer(GLPK.Optimizer))
@variable(m, x1>=6, Int)
@variable(m, x2>=16, Int)
@variable(m, x3>=10, Int)
@variable(m, x4>=13, Int)
@variable(m, x5>=25, Int)
@variable(m, x6>=20, Int)
@variable(m, x7>=30, Int)

@objective(m, Max, 920*x1+530*x2+515*x3+720*x4+1127*x5+730*x6+1020*x7)
@constraint(m, 10*x1+8*x2+6*x3+9*x4+15*x5+10*x6+12*x7 <= 1500)
@constraint(m, x1<=12)
@constraint(m, x2<=31)
@constraint(m, x3<=20)
@constraint(m, x4<=25)
@constraint(m, x5<=50)
@constraint(m, x6<=40)
@constraint(m, x7<=60)

optimize!(m)

println("Objective value: ", JuMP.objective_value(m))
println("x1 = ", JuMP.value(x1))
println("x2 = ", JuMP.value(x2))
println("x3 = ", JuMP.value(x3))
println("x4 = ", JuMP.value(x4))
println("x5 = ", JuMP.value(x5))
println("x6 = ", JuMP.value(x6))
println("x7 = ", JuMP.value(x7))


#Exercise 4

m = Model(with_optimizer(GLPK.Optimizer))
@variable(m, x1>=0, Int)
@variable(m, x2>=0, Int)
@variable(m, x3>=0, Int)
@variable(m, x4>=0, Int)
@variable(m, x5>=0, Int)
@variable(m, x6>=0, Int)
@variable(m, x7>=0, Int)
@variable(m, y[0:6], Bin)

@objective(m, Max, 920*x1+530*x2+515*x3+720*x4+1127*x5+730*x6+1020*x7-300*y[0]-160*y[1]-240*y[2]-400*y[3]-600*y[4]-250*y[5]-280*y[6])
@constraint(m, 10*x1+8*x2+6*x3+9*x4+15*x5+10*x6+12*x7 <= 1500)
@constraint(m, x1<=12*y[0])
@constraint(m, x2<=31*y[1])
@constraint(m, x3<=20*y[2])
@constraint(m, x4<=25*y[3])
@constraint(m, x5<=50*y[4])
@constraint(m, x6<=40*y[5])
@constraint(m, x7<=60*y[6])

optimize!(m)

println("Objective value: ", JuMP.objective_value(m))
println("x1 = ", JuMP.value(x1))
println("x2 = ", JuMP.value(x2))
println("x3 = ", JuMP.value(x3))
println("x4 = ", JuMP.value(x4))
println("x5 = ", JuMP.value(x5))
println("x6 = ", JuMP.value(x6))
println("x7 = ", JuMP.value(x7))
println("y = ", JuMP.value.(y))



###Question 2###

#Exercise 1

struct Activity
    start::Int32
    finish::Int32
end

activities = [Activity(480, 555), Activity(540, 720), Activity(555, 660), Activity(630, 800), Activity(600, 645), Activity(645, 720), Activity(690, 810), Activity(750, 840), Activity(795, 900), Activity(825, 855), Activity(870, 900), Activity(840, 960), Activity(840, 870), Activity(930, 1020), Activity(960, 1020)]

m = Model(with_optimizer(GLPK.Optimizer))


n=length(activities)
@variable(m, x[activities], Bin)
@objective(m, Max, sum(x[a] for a in activities))

for i=1:n-1
    for j=i+1:n
        ai = activities[i]
        aj = activities[j]
        if(!(ai.finish <= aj.start || aj.finish <= ai.start))
            @constraint(m, x[ai]+x[aj]<=1)
        end
    end
end

optimize!(m)

println("Objective Value: ", JuMP.objective_value(m))
println("Variable Values: ", JuMP.value.(x))


#Exercise 2

struct Activity
    start::Int32
    finish::Int32
end

activities = [Activity(480, 555), Activity(540, 720), Activity(555, 660), Activity(630, 800), Activity(600, 645), Activity(645, 720), Activity(690, 810), Activity(750, 840), Activity(795, 900), Activity(825, 855), Activity(870, 900), Activity(840, 960), Activity(840, 870), Activity(930, 1020), Activity(960, 1020)]

m = Model(with_optimizer(GLPK.Optimizer))


n=length(activities)
@variable(m, x[activities], Int)
@objective(m, Min, maximum(x))

for i=1:n-1
    for j=i+1:n
        ai = activities[i]
        aj = activities[j]
        if(!(ai.finish <= aj.start || aj.finish <= ai.start))
            @constraint(m, x[ai]!=x[aj])
        end
    end
end

optimize!(m)

println("Objective Value: ", JuMP.objective_value(m))
println("Variable Values: ", JuMP.value.(x))


#Exercise 3


struct Activity
    start::Int32
    finish::Int32
end

activities = [Activity(480, 555), Activity(540, 720), Activity(555, 660), Activity(630, 800), Activity(600, 645), Activity(645, 720), Activity(690, 810), Activity(750, 840), Activity(795, 900), Activity(825, 855), Activity(870, 900), Activity(840, 960), Activity(840, 870), Activity(930, 1020), Activity(960, 1020)]

while activities!=[]


    m = Model(with_optimizer(GLPK.Optimizer))


    n=length(activities)
    @variable(m, x[activities], Bin)
    @objective(m, Max, sum(x[a] for a in activities))

    for i=1:n-1
        for j=i+1:n
            ai = activities[i]
            aj = activities[j]
            if(!(ai.finish <= aj.start || aj.finish <= ai.start))
                @constraint(m, x[ai]+x[aj]<=1)
            end
        end
    end

    optimize!(m)

    println("Objective Value: ", JuMP.objective_value(m))
    println("Variable Values: ", JuMP.value.(x))

    activities=filter((x) -> x == 0, activities)
    findall(x->x==0, JuMP.value.(x))




