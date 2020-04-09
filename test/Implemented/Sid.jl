# using Dates

@testset "Sid.jl" begin
    filename = "data\\test.sid"
    dc = DDR2import.Sid.read(filename)
    @test dc["EEEI"][1] == "BALTI"
    @test dc["EEEI"][end] == "TLL"
    @test dc["BIBL"][1] == "RH"
end
