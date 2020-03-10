using DDR2import
using Test

@testset "DDR2import.jl" begin
    tests = ["Implemented\\SO6"]

    for t in tests
        include("$(t).jl")
    end
