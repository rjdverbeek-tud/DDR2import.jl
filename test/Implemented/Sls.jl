@testset "Sls.jl" begin
    filename = "data\\Free_Route_1713_Areas.sls"
    df = DDR2import.Sls.read(filename)
    @test df[2,:SECTORNAME] == "ARMFRA"
    @test df[3,:VOLUMENAME] == "BIRD_DOMESTIC"
    @test df[36,:VOLUMEBOTTOMLEVEL] == 275
    @test df[37,:VOLUMETOPLEVEL] == 660
end
