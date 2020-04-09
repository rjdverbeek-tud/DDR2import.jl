"""
Ur fileformat
See EUROCONTROL NEST Manual for Ur fileformat description

Example Ur fileformat
AZ	2020/02/01	2020/02/29	791			Portugal S M
EB	2020/02/01	2020/02/29	9114			Belg.-Luxembourg
ED	2020/02/01	2020/02/29	6374			Germany
EE	2020/02/01	2020/02/29	3151			Estonia
EF	2020/02/01	2020/02/29	4366			Finland
EG	2020/02/01	2020/02/29	6512	0.848504	   GBP	United Kingdom
EH	2020/02/01	2020/02/29	6739			Netherlands
EI	2020/02/01	2020/02/29	2461			Ireland
EK	2020/02/01	2020/02/29	5759	7.47133	   DKK	Denmark

Example Ur fileformat
AZ 2017/12/01 2017/12/31 1089
EB 2017/12/01 2017/12/31 6550
ED 2017/12/01 2017/12/31 8268
EF 2017/12/01 2017/12/31 5632
EG 2017/12/01 2017/12/31 9381
EH 2017/12/01 2017/12/31 6709
EI 2017/12/01 2017/12/31 2976
"""
module Ur

export read

include("utility.jl")
using Dates

const yyyymmdd = DateFormat("yyyy/mm/dd")

struct UnitRate
    start_date::Date
    end_date::Date
    unitrate::Float64
    valutaconversion::Float64
    valuta::String
    country::String
    function UnitRate(line::String)
        line_elements = split(line, '\t')
        start_date = format_date(line_elements[2], yyyymmdd)
        end_date = format_date(line_elements[3], yyyymmdd)
        unitrate = parse(Float64, line_elements[4]) / 100.0
        if length(line_elements[5]) > 0
            valutaconversion = parse(Float64, line_elements[5])
            valuta = strip(line_elements[6])
            country = strip(line_elements[7])
        else
            valutaconversion = 1.0
            valuta = "EUR"
            country = strip(line_elements[7])
        end
        new(start_date, end_date, unitrate, valutaconversion, valuta, country)
    end
end

function read(file)
    ur = Dict{String, UnitRate}()
    for line in eachline(file)
        ur[line[1:2]] = UnitRate(line)
    end
    return ur
end

end # module
