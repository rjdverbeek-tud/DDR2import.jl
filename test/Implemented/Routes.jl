@testset "Routes.jl" begin
    filename = "data\\test.routes"
    dc = DDR2import.Routes.read(filename)
    @test dc["ABESI8TLIME"].type == "DP"
    @test dc["ABDIL1ALFMD"].route[2].wp == "TUPOX"
    @test dc["ABDIL1ALFTZ"].route[3].location_type == "SP"
    @test dc["ABIRO2DGMTT"].route[2].wp == "ABIRO"
end
