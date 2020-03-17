using DDR2import
using Test

@testset "DDR2import.jl" begin
    # tests = ["Implemented\\SO6", "Implemented\\T5"]
    tests = ["Implemented\\Exp2"]

    for t in tests
        include("$(t).jl")
    end
end
