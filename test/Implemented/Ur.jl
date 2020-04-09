using Dates

@testset "Ur.jl" begin
    filename = "data\\test.ur"
    dc = DDR2import.Ur.read(filename)
    @test Dates.day(dc["EB"].start_date) == 1
    @test Dates.month(dc["ED"].end_date) == 2
    @test dc["EE"].unitrate == 31.51
    @test dc["EG"].valutaconversion == 0.848504
    @test dc["EG"].valuta == "GBP"
    @test dc["EH"].country == "Netherlands"
    #LAST
    @test dc["UG"].unitrate == 28.30
end
