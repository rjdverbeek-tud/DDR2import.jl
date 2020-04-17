@testset "Country.jl" begin
    filename = "data\\test.country"
    dc = DDR2import.Country.read(filename)
    @test dc["AG"].name == "Solomon Islands"
    @test dc["EB"].member
    @test !dc["ZY"].member
end
