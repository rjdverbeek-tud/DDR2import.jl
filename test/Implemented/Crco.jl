using Dates

@testset "Crco.jl" begin
    filename = "data\\test.crco"
    df = DDR2import.Crco.read(filename)
    @test df[1, :COUNTRYNAME] == "ED"
    @test df[2, :CALLSIGN] == "N182QS"
    @test df[3, :ACTYPE] == "B737"
    @test df[4, :FLIGHTID] == 1523
    @test df[1, :LATENTRY_DEG] ≈  53.630278 atol = 0.001
    @test df[2, :LONENTRY_DEG] ≈  12.1066383 atol = 0.001
    @test df[3, :LATEXIT_DEG] ≈  50.3166667 atol = 0.001
    @test df[4, :LONEXIT_DEG] ≈  9.98833333 atol = 0.001
    @test df[1, :DISTANCE_M] ≈  396031.3143 atol = 0.1
    @test df[4, :ENTRYFL] ≈  270.0 atol = 0.1
    @test df[1, :EXITFL] ≈  270.0 atol = 0.1
    @test Dates.minute(df[2, :DATETIMEENTRY]) == 59
    @test Dates.second(df[3, :DATETIMEEXIT]) == 22
end
