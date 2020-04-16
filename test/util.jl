using Dates

@testset "util.jl" begin
    p1 = DDR2import.util.Point(1.0, 2.0)
    @test p1.lat == 1.0
    @test p1.lon == 2.0

    @test DDR2import.util.extract_lat("S123456") ≈ -12.58222222 atol = 0.0001
    @test DDR2import.util.extract_lat("N123456.0") ≈ 12.58222222 atol = 0.0001
    @test DDR2import.util.extract_lat("123456N") ≈ 12.58222222 atol = 0.0001
    @test DDR2import.util.extract_lat("S1234") ≈ -12.56666666 atol = 0.0001
    @test DDR2import.util.extract_lat("N12") ≈ 12.0 atol = 0.0001
    @test DDR2import.util.extract_lat("1234S") ≈ -12.56666666 atol = 0.0001
    @test DDR2import.util.extract_lat("12N") ≈ 12.0 atol = 0.0001
    @test DDR2import.util.extract_lat("") === NaN

    @test DDR2import.util.extract_lon("W1123456") ≈ -112.58222222 atol = 0.0001
    @test DDR2import.util.extract_lon("E1123456.0") ≈ 112.58222222 atol = 0.0001
    @test DDR2import.util.extract_lon("0123456E") ≈ 12.58222222 atol = 0.0001
    @test DDR2import.util.extract_lon("W01234") ≈ -12.56666666 atol = 0.0001
    @test DDR2import.util.extract_lon("E112") ≈ 112.0 atol = 0.0001
    @test DDR2import.util.extract_lon("11234W") ≈ -112.56666666 atol = 0.0001
    @test DDR2import.util.extract_lon("012E") ≈ 12.0 atol = 0.0001
    @test DDR2import.util.extract_lon("E1") === NaN

    # @test DDR2import.util.latlon("S123456", "012E").lat ≈ -12.58222222 atol = 0.0001
    # @test DDR2import.util.latlon("S123456", "012E").lon ≈ 12.0 atol = 0.0001
    # @test DDR2import.util.latlon("S123456", "E1") === NaN
    #
    # @test DDR2import.util.latlon("S123456E1123456.0").lat ≈ -12.58222222 atol = 0.0001
    # @test DDR2import.util.latlon("S123456E1123456.0").lon ≈ 112.58222222 atol = 0.0001
    # @test DDR2import.util.latlon("S123456W1123456.0").lon ≈ -112.58222222 atol = 0.0001

    @test DDR2import.util.latlon("S123456", "012E").ϕ ≈ -12.58222222 atol = 0.0001
    @test DDR2import.util.latlon("S123456", "012E").λ ≈ 12.0 atol = 0.0001
    @test DDR2import.util.latlon("S123456", "E1") === NaN

    @test DDR2import.util.latlon("123456S1123456.0E").ϕ ≈ -12.58222222 atol = 0.0001
    @test DDR2import.util.latlon("123456S1123456.0E").λ ≈ 112.58222222 atol = 0.0001
    @test DDR2import.util.latlon("123456S1123456.0W").λ ≈ -112.58222222 atol = 0.0001


    yymmdd = DateFormat("YYmmdd")
    testdate = DDR2import.util.format_date("200110", yymmdd, addyear=Year(2000))
    @test Dates.year(testdate) == 2020
    @test Dates.month(testdate) == 1
    @test Dates.day(testdate) == 10

    hhmmss = DateFormat("HHMMSS")
    testtime = DDR2import.util.format_time("102030", hhmmss)
    @test Dates.hour(testtime) == 10
    @test Dates.minute(testtime) == 20
    @test Dates.second(testtime) == 30
    hhmm = DateFormat("HHMM")
    testtime2 = DDR2import.util.format_time("2400", hhmm)
    @test Dates.hour(testtime2) == 23
    @test Dates.minute(testtime2) == 59
    @test Dates.second(testtime2) == 59

    yyyymmddhhmmss = DateFormat("YYYYmmddHHMMSS")
    testdatetime = DDR2import.util.format_datetime("20200110102030", yyyymmddhhmmss)
    @test Dates.year(testdatetime) == 2020
    @test Dates.month(testdatetime) == 1
    @test Dates.day(testdatetime) == 10
    @test Dates.hour(testdatetime) == 10
    @test Dates.minute(testdatetime) == 20
    @test Dates.second(testdatetime) == 30
end
