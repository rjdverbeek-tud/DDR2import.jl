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
using CSV
using Dates
using DataFrames

const yyyymmdd = DateFormat("yyyy/mm/dd")

const fileformat = Dict(1=>String, 2=>String, 3=>String, 4=>Float64, 5=>Float64,
6=>String, 7=>String)

const header_format = ["SECTOR", "STARTDATE", "ENDDATE", "UNITRATE",
"VALUTACONVERSION", "VALUTA", "COUNTRY"]

function read(file)
    df = CSV.read(file, types=fileformat, header=header_format,
    copycols=true)
    reformat!(df)
    return df
end

function reformat!(df)
    df[:,:UNITRATE] = df[:,:UNITRATE] / 100.0

    df[:,:TEMP] = format_date.(df[:,:STARTDATE], yyyymmdd)
    select!(df, Not(:STARTDATE))
    df[:,:STARTDATE] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_date.(df[:,:ENDDATE], yyyymmdd)
    select!(df, Not(:ENDDATE))
    df[:,:ENDDATE] =  df[:,:TEMP]
    select!(df, Not(:TEMP))
end

end # module
