using DDR2import
using Test

@testset "DDR2import.jl" begin
    # tests = ["Implemented\\SO6", "Implemented\\T5", "Implemented\\Exp2",
    # "Implemented\\Allftplus", "Implemented\\Ase", "Implemented\\Are",
    # "Implemented\\Gar", "Implemented\\Gsl", "Implemented\\Frp"]
    tests = ["Implemented\\Frp"]

    for t in tests
        include("$(t).jl")
    end
end
