# using Dates

@testset "Star.jl" begin
    filename = "data\\test.star"
    dc = DDR2import.Star.read(filename)
    @test dc["EEKA"][1] == "NEBSI"
    @test dc["EEKA"][end] == "TEVNA"
end
