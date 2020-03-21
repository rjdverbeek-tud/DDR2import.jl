# using Dates

@testset "Gar.jl" begin
    filename = "data\\sectors_1713.gar"
    dc = DDR2import.Gar.read(filename)
    @test length(dc) == 7509
    @test dc["000EG"][5,1] == 57.0
    @test dc["000EG"][6,2] ≈ -13.8213888889 atol = 0.00001
end
