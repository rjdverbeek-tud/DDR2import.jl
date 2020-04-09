# using Dates

@testset "Ase.jl" begin
    filename = "data\\test.ase"
    df = DDR2import.Ase.read(filename)
    @test df[1,:FLIGHTCOUNT] == 0.0
    @test df[1,:SEGMENTPARITY] == 1
    @test df[1,:SEGMENTTYPE] == 41
    @test df[1,:LATBEGINSEGMENT_DEG] ≈ 48.7580 atol = 0.0001
    @test df[1,:LONBEGINSEGMENT_DEG] ≈ 10.8534 atol = 0.0001
    @test df[1,:LATENDSEGMENT_DEG] ≈ 48.6956 atol = 0.0001
    @test df[1,:LONENDSEGMENT_DEG] ≈ 10.9489 atol = 0.0001
    @test df[1,:SEGMENTNAME] == "%%BRU_BURAM"
    #LAST TEST
    @test df[3,:SEGMENTNAME] == "%%EDH_WSN"
end
