@testset "Nnpt.jl" begin
    filename = "data\\NavPoint_1713.nnpt"
    df = DDR2import.Nnpt.read(filename)
    @test df[1, :NAV_ID] == "%%BRU"
    @test df[2, :LAT_DEG] == 48.6246363000
    @test df[3, :LON_DEG] == 9.2302974333
end
