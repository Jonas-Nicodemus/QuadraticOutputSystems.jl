using QuadraticOutputSystems
using Test, Aqua

@testset "QuadraticOutputSystems.jl" begin
    Aqua.test_all(QuadraticOutputSystems)

    include("test_gramians.jl")
    include("test_analysis.jl")
    include("test_timeresp.jl")
end
