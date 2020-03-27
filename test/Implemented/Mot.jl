using Dates

@testset "Mot.jl" begin
    filename = "data\\Free_Route_1713_Time.mot"
    dc = DDR2import.Mot.read(filename)
    @test Dates.hour(dc["NAT1"].onlytimes[1].begintime) == 0
    @test Dates.second(dc["NAT1"].onlytimes[1].endtime) == 59
    @test dc["UKOV_FRA"].timetypes[1].type == "EX"
end
