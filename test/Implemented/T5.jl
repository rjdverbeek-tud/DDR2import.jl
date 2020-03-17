import Dates

@testset "T5.jl" begin
    filename = "data\\20171215_Initial_From_NEST.t5"
    df = DDR2import.T5.read(filename)
    @test df[2,:FLIGHT_ID] == 213765625
    @test df[2,:SECTOR_NAME] == "EHAAFIR"
    @test Dates.year(df[2,:ENTRY_DATETIME]) == 2017
    @test Dates.day(df[2,:ENTRY_DATETIME]) == 14
    @test Dates.minute(df[2,:ENTRY_DATETIME]) == 49
    @test Dates.month(df[2,:EXIT_DATETIME]) == 12
    @test Dates.hour(df[2,:EXIT_DATETIME]) == 22
    @test Dates.second(df[2,:EXIT_DATETIME]) == 0
    @test df[2,:ENTRY_FL] == 0.0
    @test df[2,:EXIT_FL] == 255.0
    @test df[2,:ENTRY_SEGMENT_NAME] == "EHAM_*AM80"
    @test df[2,:EXIT_SEGMENT_NAME] == "!AAEb_SONEB"
    @test df[2,:TOT_DISTANCE_IN_SEGMENT_M] == 84.060844 * 1852.0
    @test df[2,:TOT_TIME_IN_SEGMENT_S] == 840.0
end
