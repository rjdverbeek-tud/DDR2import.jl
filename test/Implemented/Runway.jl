import Dates

@testset "Runway.jl" begin
    filename = "data\\test.runway"
    df = DDR2import.Runway.read(filename)
    @test df[1, :AIRPORT] == "BIAR"
    @test df[2, :RWY] == "19"
    @test Dates.year(df[3, :DATEACTIVE]) == 2018
    @test Dates.minute(df[4, :TIMEOPEN]) == 0
    @test Dates.hour(df[5, :TIMECLOSED]) == 23
end
