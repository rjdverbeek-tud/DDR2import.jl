# using Dates

@testset "Are.jl" begin
    filename = "data\\DCTNight_1713_Areas.are"
    dc = DDR2import.Are.read(filename)
    @test dc["AZ"].nb_point == 48
    @test dc["AZ"].bottom_fl == 0.0
    @test dc["AZ"].top_fl == 0.0
    @test dc["AZ"].surface == 0.0
    @test dc["AZ"].sector_num == 0.0
    @test dc["AZ"].points[5,1] == 45.0
    @test dc["AZ"].points[4,2] == -40.0
end
