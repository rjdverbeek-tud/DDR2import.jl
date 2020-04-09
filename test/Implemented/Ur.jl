using Dates

@testset "Ur.jl" begin
    filename = "data\\test.ur"
    df = DDR2import.Ur.read(filename)
    @test df[1, :SECTOR] == "AZ"
    @test Dates.day(df[2, :STARTDATE]) == 1
    @test Dates.month(df[3, :ENDDATE]) == 2
    @test df[4, :UNITRATE] == 31.51
    @test df[6, :VALUTACONVERSION] == 0.848504
    # @test df[6, :VALUTA] == "GBP"
    # @test df[7, :COUNTRY] == "Netherlands"
end
