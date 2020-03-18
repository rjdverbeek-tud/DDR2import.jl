using Dates

@testset "Allftplus.jl" begin
    filename = "data\\20171215_from_NEST.ALL_FT+"
    df = DDR2import.Allftplus.read(filename)
    #EXP
    @test df[2,:departureAerodromeIcaoId_0] == "LFST"
    @test df[2,:arrivalAerodromeIcaoId_1] == "EHAM"
    @test df[2,:aircraftId_2] == "AFR27FK"
    @test df[2,:aircraftOperatorIcaoId_3] == "AFR"
    @test df[2,:aircraftTypeIcaoId_4] == "E145"
    @test Dates.year(df[2,:aobt_5]) == 2017
    @test Dates.minute(df[2,:aobt_5]) == 46
    @test df[2,:ifpsId_6] == "AA70843154"
    @test df[2,:aircraftTypeIcaoId_4] == "E145"
    @test df[2,:iobt_7] === missing
    @test df[2,:originalFlightDataQuality_8] === missing
    @test df[2,:flightDataQuality_9] === missing
    @test df[2,:source_10] == "UNK"
    @test df[2,:exemptionReasonType_11] == "NEXE"
    @test df[2,:exemptionReasonDistance_12] == "NEXE"
    @test df[2,:lateFiler_13] === missing
    @test df[2,:lateUpdater_14] === missing
    @test df[2,:northAtlanticFlight_15] === missing
    @test Dates.month(df[2,:cobt_16]) == 12
    @test Dates.hour(df[2,:cobt_16]) == 5
    @test Dates.day(df[2,:eobt_17]) == 15
    @test Dates.minute(df[2,:eobt_17]) == 45
    @test df[2,:lobt_18] === missing
    @test df[2,:flightState_19] == "NE"
    @test df[2,:previousToActivationFlightState_20] == "NE"
    @test df[2,:suspensionStatus_21] == "NS"
    @test df[2,:tactId_22] == 512256
    @test Dates.year(df[2,:samCtot_23]) == 2017
    @test df[2,:samSent_24] === missing
    @test Dates.day(df[2,:sipCtot_24]) == 15
    # @test df[2,:aircraftTypeIcaoId_4] == "E145"
end
