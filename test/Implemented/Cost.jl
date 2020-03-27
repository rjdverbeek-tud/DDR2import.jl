@testset "Cost.jl" begin
    filename = "data\\Test.cost"
    df = DDR2import.Cost.read(filename)
    @test df[1, :FLIGHTID] == 139729486
    @test df[2, :COUNTRYCODE] == "LB"
    @test df[3, :COST] == 86.7351
end
