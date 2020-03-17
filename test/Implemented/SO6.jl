using Dates

@testset "SO6.jl" begin
    filename = "data\\20171215_Initial_From_NEST.so6"
    df = DDR2import.SO6.read(filename)
    @test df[2,:SEGMENT_ID] == "*AM80_!AAEW"
    @test df[2,:ADEP] == "EHAM"
    @test df[2,:ADES] == "UUEE"
    @test df[2,:ACTYPE] == "A321"
    @test df[2,:FLBEGINSEGMENT] == 10
    @test df[2,:FLENDSEGMENT] == 25
    @test df[2,:STATUS] == 0
    @test df[2,:CALLSIGN] == "AFL2193"
    @test df[2,:LATBEGINSEGMENT_DEG] == 3137.483333 / 60.0
    @test df[2,:LONBEGINSEGMENT_DEG] == 284.183333 / 60.0
    @test df[2,:LATENDSEGMENT_DEG] == 3135.833333 / 60.0
    @test df[2,:LONENDSEGMENT_DEG] == 284.033333 / 60.0
    @test df[2,:FLIGHT_ID] == 213765625
    @test df[2,:SEQUENCE] == 2
    @test df[2,:SEGMENT_LENGTH_M] == 1.652550 * 1852.0
    @test df[2,:SEGMENT_PARITY] == 0
    @test Dates.year(df[2,:DATETIMEBEGINSEGMENT]) == 2017
    @test Dates.hour(df[2,:DATETIMEBEGINSEGMENT]) == 21
    @test Dates.second(df[2,:DATETIMEBEGINSEGMENT]) == 26
    @test Dates.day(df[2,:DATETIMEENDSEGMENT]) == 14
    @test Dates.minute(df[2,:DATETIMEENDSEGMENT]) == 50
end
