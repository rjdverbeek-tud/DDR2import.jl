# using Dates

@testset "Frp.jl" begin
    filename = "data\\Free_Route_1713_Points.frp"
    dc = DDR2import.Frp.read(filename)
    # @test dc["BIRD"].ID == "BIRD"
end
