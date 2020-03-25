# using Dates

@testset "Frp.jl" begin
    filename = "data\\Free_Route_1713_Points.frp"
    dc = DDR2import.Frp.read(filename)
    @test dc["ALBANIA"].freeroutepoints[1].type == "EX"
    @test dc["ALBANIA"].freeroutepoints[2].name == "DOBAR"
    @test dc["ALBANIA"].freeroutepoints[3].point.lat_deg ≈ 40.59833333 atol = 0.001
    @test dc["ALBANIA"].freeroutepoints[4].point.lon_deg ≈ 20.530 atol = 0.001
    @test dc["ALBANIA"].freerouteairports[1].type == "A"
    @test dc["ALBANIA"].freerouteairports[2].name == "DIRES"
    @test dc["ALBANIA"].freerouteairports[3].airports[1] == "LATI"
    @test isempty(dc["BIRD_DOMESTIC"].freerouteairports[2].airports) == true
    @test dc["EI_FRA"].freerouteairports[15].airports[2] == "EINN"
end
