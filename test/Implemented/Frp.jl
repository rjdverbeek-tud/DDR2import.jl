# using Dates

@testset "Frp.jl" begin
    filename = "data\\test1.frp"
    dc = DDR2import.Frp.read(filename)
    @test dc["ALBANIA"].freeroutepoints[1].type == "E"
    @test dc["ALBANIA"].freeroutepoints[2].name == "NIKRO"
    # @test dc["ALBANIA"].freeroutepoints[3].point.lat ≈ 41.775277777777774 atol = 0.001
    # @test dc["ALBANIA"].freeroutepoints[4].point.lon ≈ 20.472777777777775 atol = 0.001
    @test dc["ALBANIA"].freeroutepoints[3].point.ϕ ≈ 41.775277777777774 atol = 0.001
    @test dc["ALBANIA"].freeroutepoints[4].point.λ ≈ 20.472777777777775 atol = 0.001
    @test dc["ALBANIA"].freerouteairports[1].type == "A"
    @test dc["ALBANIA"].freerouteairports[2].name == "DIRES"
    @test dc["ALBANIA"].freerouteairports[3].airports[1] == "LATI"
    @test isempty(dc["BIRD_DOMESTIC"].freerouteairports[3].airports) == true
    @test dc["EI_FRA"].freerouteairports[18].airports[2] == "EINN"
    #LAST
    @test dc["FRAC"].freerouteairports[1].type == "A"

    filename2 = "data\\test2.frp"
    dc2 = DDR2import.Frp.read(filename2)
    @test dc2["NAT4"].freeroutepoints[1].name == "*1847"
    # @test dc2["NAT4"].freeroutepoints[1].point.lat == 18.0
    # @test dc2["NAT4"].freeroutepoints[1].point.lon == -47.5
    @test dc2["NAT4"].freeroutepoints[1].point.ϕ == 18.0
    @test dc2["NAT4"].freeroutepoints[1].point.λ == -47.5
    # @test dc2["NEFRA"].freeroutepoints[1129].point.lat ≈ 58.1456667 atol = 0.00001
    # @test dc2["SEEN_FRA_NORTH"].freeroutepoints[184].point.lon ≈ 18.35583333 atol = 0.00001
    @test dc2["NEFRA"].freeroutepoints[1129].point.ϕ ≈ 58.1456667 atol = 0.00001
    @test dc2["SEEN_FRA_NORTH"].freeroutepoints[184].point.λ ≈ 18.35583333 atol = 0.00001

end
