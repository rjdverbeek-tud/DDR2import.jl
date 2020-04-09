@testset "Ntfv.jl" begin
    filename = "data\\test.ntfv"
    dc = DDR2import.Ntfv.read(filename)
    @test dc["ABSON"].name == ""
    @test dc["ALASO"].category == "_"
    @test dc["AERODS1"].reflocname == "EDGGADS"
    @test dc["AERODS2"].refloctype == "AS"
    @test dc["AEROMN"].reflocrole == "G"
    @test dc["ALGERIA"].airblocks[1].name == "ELI>GC"
    @test dc["ALGERIA"].airblocks[2].upperFL == "IN"
end
