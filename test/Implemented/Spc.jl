# using Dates

@testset "Spc.jl" begin
    filename = "data\\test.spc"
    dc = DDR2import.Spc.read(filename)
    @test dc["AFI"].name == "AFRICA"
    @test dc["AFI"].type == "AREA"
    @test dc["AFI"].sectors[1].name == "DA"
    @test dc["AFI"].sectors[2].type == "NAS"
end
