using Dates

@testset "Exp2.jl" begin
    filename = "data\\20171215_from_NEST.exp2"
    df = DDR2import.Exp2.read(filename)
    #EXP
    @test df[2,:ADEP] == "EHAM"
    @test df[2,:ADES] == "UUEE"
    @test df[2,:ACTYPE] == "A321"
    @test df[2,:RFL] == 350
    @test df[2,:ZONE_ORIG] == "EHAM"
    @test df[2,:ZONE_DEST] == "UUEE"
    @test df[2,:FLIGHT_ID] == 213793846
    @test Dates.year(df[2,:ETD_DATETIME]) == 2017
    @test Dates.month(df[2,:ETD_DATETIME]) == 12
    @test Dates.day(df[2,:ETD_DATETIME]) == 15
    @test Dates.hour(df[2,:ETD_DATETIME]) == 21
    @test Dates.minute(df[2,:ETD_DATETIME]) == 49
    @test df[2,:ETA_DATETIME] === missing
    @test Dates.day(df[1,:ETA_DATETIME]) == 15
    @test Dates.minute(df[1,:ETA_DATETIME]) == 0
    @test Dates.day(df[3,:ETA_DATETIME]) == 15
    @test Dates.minute(df[3,:ETA_DATETIME]) == 0
    @test df[2,:CALLSIGN] == "AFL2193"
    @test df[2,:COMPANY] == "AFL"

    #UUID
    @test df[2,:UUID] == "AFL2193-EHAM-UUEE-20171215213500"
    @test df[2,:FIPS_CLONED] == "N"

    #FLF
    #TODO test FLIGHT_SAAM_ID
    #TODO test FLIGHT_SAMAD_ID
    @test df[2,:TACT_ID] == 512114
    #TODO test SSR_CODE
    #TODO test REGISTRATION
    @test Dates.year(df[2,:PTD_DATETIME]) == 2017
    @test Dates.minute(df[2,:PTD_DATETIME]) == 35
    @test df[2,:ATFM_DELAY] == 0
    #TODO test REROUTING_STATE
    @test df[2,:MOST_PEN_REG] == "X"
    #TODO test TYPE_OF_FLIGHT
    #TODO test EQUIPMENT
    #TODO test ICAO_EQUIP
    #TODO test COM_EQUIP
    #TODO test NAV_EQUIP
    #TODO test SSR_EQUIP
    #TODO test SURVIVAL_EQUIP
    #TODO test PERSONS_ON_BOARD
    #TODO test TOP_FL
    @test df[2,:MAX_RFL] == 350
    #TODO test FLT_PLN_SOURCE

    #ALLFT
    @test Dates.minute(df[2,:AOBT]) == 40
    @test df[2, :IFPSID] == "AA70883446"
    #TODO test IOBT
    #TODO test ORIGFLIGHTDATAQUALITY
    #TODO test FLIGHTDATAQUALITY
    #TODO test SOURCE
    @test df[2, :EXEMPTREASON] == "NEXE"
    @test df[2, :EXEMPTREASONDIST] == "NEXE"
    #TODO test LATEFILER
    #TODO test LATEUPDATER
    #TODO test NORTHATLANTIC
    @test df[2, :COBT] === missing
    #TODO test COBT
    @test Dates.minute(df[2,:EOBT]) == 35
    #TODO test FLIGHTSTATE
    #TODO test PREV2ACTIVATIONFLIGHTSTATE
    #TODO test SUSPENSIONSTATUS
    #TODO test SAMCTOT
    #TODO test SAMSENT
    #TODO test SIPCTOT
    #TODO test SIPSENT
    #TODO test SLOTFORCED
    #TODO test MOSTPENALIZINGREGID
    #TODO test REGAFFECTEDBYNROFINST
    #TODO test EXCLFROMNROFINST
    #TODO test LASTRECEIVEDATFMMESSAGETITLE
    #TODO test LASTRECEIVEDMESSAGETITLE
    #TODO test LASTSENTATFMMESSAGETITLE
    #TODO test MANUALEXEMPREASON
    #TODO test SENSITIVEFLIGHT
    #TODO test READYFORIMPROVEMENT
    #TODO test READYFORDEP
    @test df[2, :REVISEDTAXITIME] == 840
    #TODO test TIS
    #TODO test TRS
    #TODO test TOBESENTSLOTMESSAGE
    #TODO test TOBESENTPROPMESSAGETITLE
    #TODO test LASTSENTSLOTMESSAGETITLE
    #TODO test LASTSENTPROPMESSAGETITLE
    #TODO test LASTSENTSLOTMESSAGE
    #TODO test LASTSENTPROPMESSAGE
    #TODO test FLIGHTCOUNTOPTION
    #TODO test NORMALFLIGHTTACT_ID
    #TODO test PROPFLIGHTTACT_ID
    @test df[2, :OPERATINGACOPERICAOID] == "AFL"
    #TODO test REROUTINGWHY
    #TODO test REROUTINGLFIGHTSTATE
    #TODO test RVR
    #TODO test FTFMAIRAC
    #TODO test FTFMENVBASELINENUM
    #TODO test RTFMAIRAC
    #TODO test RTFMENVBASELINENUM
    #TODO test CTFMAIRAC
    #TODO test CTFMENVBASELINENUM
    #TODO test LASTRECEIVEDPROGRESSMESSAGE
end
