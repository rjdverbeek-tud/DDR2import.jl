# using Dates

@testset "Are.jl" begin
    filename = "data\\test.are"
    dc = DDR2import.Are.read(filename)
    @test dc["AZ"].nb_point == 48
    @test dc["AZ"].bottom_fl == 0.0
    @test dc["AZ"].top_fl == 0.0
    @test dc["AZ"].surface == 0.0
    @test dc["AZ"].sector_num == 0.0
    @test dc["AZ"].points[5,1] == 45.0
    @test dc["AZ"].points[4,2] == -40.0
    @test dc["AZ"].box[1,1] == 45.0
    #LAST TEST
    @test dc["EB"].nb_point == 550
    @test dc["EB"].points[550,1] == 51.5
end
