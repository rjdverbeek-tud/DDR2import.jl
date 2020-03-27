@testset "Arp.jl" begin
    filename = "data\\test.arp"
    df = DDR2import.Arp.read(filename)
    @test df[1, :AIRPORT] == "EGSX"
    @test df[2, :LAT_DEG] ≈ 53.3941667 atol = 0.001
    @test df[3, :LON_DEG] ≈ -1.7 atol = 0.001
    @test df[4, :FIR] == "EGTT_FIR"
end
