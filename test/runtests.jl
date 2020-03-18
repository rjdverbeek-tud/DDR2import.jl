using DDR2import
using Test

@testset "DDR2import.jl" begin
    # tests = ["Implemented\\SO6", "Implemented\\T5", "Implemented\\Exp2",
    # "Implemented\\Allftplus"]
    tests = ["Implemented\\Allftplus"]

    for t in tests
        include("$(t).jl")
    end
end
