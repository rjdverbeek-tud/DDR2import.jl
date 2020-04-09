@testset "Narp.jl" begin
    filename = "data\\test.narp"
    df = DDR2import.Narp.read(filename)
    @test df[1, :AIRPORT_ID] == "AGGA"
    @test df[2, :AIRPORT_NAME] == "BALALAE"
    @test df[3, :LAT_DEG] == -9.4316666667
    @test df[3, :LON_DEG] == 160.0533333333
    @test df[9, :TIS] == 0
    @test df[9, :TRS] == 0
    @test df[9, :TAXITIME] == 0
    @test df[9, :ALTITUDE_FL] == 82
    #LAST
    @test df[13, :AIRPORT_ID] == "AGGV"
end
