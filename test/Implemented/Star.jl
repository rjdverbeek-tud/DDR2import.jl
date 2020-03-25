# using Dates

@testset "Star.jl" begin
    filename = "data\\VST_1713_STAR.star"
    dc = DDR2import.Star.read(filename)
    @test dc["EEKA"][1] == "NEBSI"
    @test dc["EEKA"][end] == "TEVNA"
end
