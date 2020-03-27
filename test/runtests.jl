using DDR2import
using Test

@testset "DDR2import.jl" begin
    tests = ["Implemented\\SO6", "Implemented\\T5", "Implemented\\Exp2",
    "Implemented\\Allftplus", "Implemented\\Ase", "Implemented\\Are",
    "Implemented\\Gar", "Implemented\\Gsl", "Implemented\\Frp",
    "Implemented\\Sls", "Implemented\\Sid", "Implemented\\Star",
    "Implemented\\Spc", "Implemented\\Mot"]
    # tests = ["Implemented\\Mot"]

    for t in tests
        include("$(t).jl")
    end
end
