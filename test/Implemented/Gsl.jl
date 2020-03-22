# using Dates

@testset "Gsl.jl" begin
    filename = "data\\sectors_1713.gsl"
    dc = DDR2import.Gsl.read(filename)
    @test dc["BIRD"].ID == "BIRD"
    @test dc["BIRD"].Name == "_"
    @test dc["BIRD"].Category == "_"
    @test dc["BIRD"].Type == "FIR"
    @test dc["BIRD"].Airblocks[2].Name == "002BI"
    @test dc["BIRD"].Airblocks[2].LowerFL == 0
    @test dc["BIRD"].Airblocks[2].UpperFL == 999
end
