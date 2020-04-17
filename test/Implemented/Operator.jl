using Dates

@testset "Country.jl" begin
    filename = "data\\test.operator"
    dc = DDR2import.Operator.read(filename)
    @test dc["AAA"].name == "ANSETT AUSTRALIA HOLDINGS LTD"
    @test dc["AAB"].callsign == "ABG"
    @test dc["AAC"].countryid == "GB"
    @test dc["AAD"].country == "CANADA"
    @test Dates.day(dc["AAE"].startdate) == 1
    @test Dates.month(dc["AAG"].enddate) == 12
end
