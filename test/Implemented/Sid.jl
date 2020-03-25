# using Dates

@testset "Sid.jl" begin
    filename = "data\\VST_1713_SID.sid"
    dc = DDR2import.Sid.read(filename)
    @test dc["EEEI"][1] == "BALTI"
    @test dc["EEEI"][end] == "TLL"
end
