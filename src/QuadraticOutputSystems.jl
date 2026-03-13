module QuadraticOutputSystems

using LinearAlgebra, ControlSystemsBase, MatrixEquations

export QuadraticOutputStateSpace, qoss
export h2norm, h2inner

include("types/QuadraticOutputStateSpace.jl")
include("convert.jl")
include("gramians.jl")
include("analysis.jl")
include("timeresp.jl")

end
