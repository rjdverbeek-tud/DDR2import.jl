# using Dates

@testset "Gar.jl" begin
    filename = "data\\test.gar"
    dc = DDR2import.Gar.read(filename)
    @test dc["000EG"][5,1] == 57.0
    @test dc["000EG"][6,2] ≈ -13.8213888889 atol = 0.00001
end
