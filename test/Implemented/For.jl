@testset "For.jl" begin
    filename = "data\\test.for"
    df = DDR2import.For.read(filename)
    @test df[1,:RANK] == "Base"
    @test df[2,:Dep] == "ALANDISLANDS"
    @test df[3,:Des] == "ESTONIA"
    @test df[4,Symbol("2017")] == 2.536986301
    @test df[5,Symbol("2024")] == 0.013151227
end
