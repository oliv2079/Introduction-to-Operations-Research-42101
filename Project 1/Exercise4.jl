module test

using JuMP, GLPK

mutable struct Arc
    from::Int64
    to::Int64
    cost::Int64
    UB::Int64
end

# Numbering vertices:
# node 13 is the start node for the flow (corresponding to node 0 on the figure)
# node 14 is the end node for the flow (corresponding to node 6 on the figure)
# node 2i-1 is the start node for trip i=1,...,6
# node 2i is the end node for trip i=1,...,6

# the two functions below return the "id" of the start and end node corresponding to a trip i
function startNode(i)
  return 2*i-1
end

function endNode(i)
    return 2*i
end

m = 14 # 14 nodes in total
# Here we define the arcs
arcs = [
Arc(startNode(1),endNode(1),-10000+320,1),
Arc(startNode(2),endNode(2),-10000+330,1),
Arc(startNode(3),endNode(3),-10000+180,1),
Arc(startNode(4),endNode(4),-10000+300,1),
Arc(startNode(5),endNode(5),-10000+460,1),
Arc(startNode(6),endNode(6),-10000+300,1),


Arc(13,startNode(1), 1300,0),
Arc(13,startNode(2), 1330,0),
Arc(13,startNode(3), 1000,0),
Arc(13,startNode(4), 1000,0),
Arc(13,startNode(5), 1490,0),
Arc(13,startNode(6), 1300,0),

Arc(13,14, 0,0),

Arc(endNode(1),14, 610,0),

Arc(endNode(2),startNode(3), 0 ,0),
Arc(endNode(2),startNode(1), 300 ,0),
Arc(endNode(2),14, 0,0),

Arc(endNode(3),startNode(1), 120 ,0),
Arc(endNode(3),14, 180,0),

Arc(endNode(4),startNode(1), 0 ,0),
Arc(endNode(4),startNode(2), 40 ,0),
Arc(endNode(4),startNode(3), 300 ,0),
Arc(endNode(4),startNode(6), 0 ,0),
Arc(endNode(4),14, 300,0),

Arc(endNode(5),startNode(1), 120 ,0),
Arc(endNode(5),startNode(3), 180 ,0),
Arc(endNode(5),14, 180,0),

Arc(endNode(6),startNode(1), 300 ,0),
Arc(endNode(6),startNode(3), 0 ,0),
Arc(endNode(6),14, 0,0),
]
demands = [0,0,0,0,0,0,0,0,0,0,0,0,5,-5]

model = Model(with_optimizer(GLPK.Optimizer))
@variable(model, x[arcs] >= 0 )

@objective(model, Min, sum(a.cost*x[a] for a in arcs) )
@constraint(model, [i=1:m], sum(x[a] for a in arcs if a.from==i) - sum(x[a] for a in arcs if a.to==i) == demands[i] )
for a in arcs
    if a.UB > 0
        @constraint(model, x[a] <= a.UB )
    end
end

optimize!(model)

println("Objective value: ", JuMP.objective_value(model))
for a in arcs
    println("Flow on arc (",a.from,",",a.to,") is ", JuMP.value.(x[a]))
end

end
