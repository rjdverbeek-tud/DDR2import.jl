"""
Crco fileformat
See EUROCONTROL NEST Manual for Crco fileformat description
"""
module Crco

export read

using Format
using CSV
using Dates

const fileformat = Dict(1=>String, 2=>String, 3=>String, 4=>Int64, 5=>Float64,
6=>Float64, 7=>Float64, 8=>Float64, 9=>Float64, 10=>String, 11=>String,
12=>Int64, 13=>String, 14=>String, 15=>Int64)

const header_format = ["COUNTRYNAME", "CALLSIGN", "ACTYPE", "FLIGHTID",
"LATENTRY_DEG", "LONENTRY_DEG", "LATEXIT_DEG", "LONEXIT_DEG", "DISTANCE_M",
"TIMEENTRY", "DATEENTRY", "ENTRYFL", "TIMEEXIT", "DATEEXIT", "EXITFL"]

const yymmdd = DateFormat("YYmmdd")
const hhmmss = DateFormat("HHMMSS")
const year2000 = Year(2000)

function read(file)
    df = CSV.read(file, delim=" ", types=fileformat, header=header_format,
    copycols=true)
    reformat!(df);
    return df
end

function reformat!(df)
    df[:,:LATENTRY_DEG] = df[:,:LATENTRY_DEG] / 60.0
    df[:,:LONENTRY_DEG] = df[:,:LONENTRY_DEG] / 60.0
    df[:,:LATEXIT_DEG] = df[:,:LATEXIT_DEG] / 60.0
    df[:,:LONEXIT_DEG] = df[:,:LONEXIT_DEG] / 60.0
    df[:,:DISTANCE_M] = df[:,:DISTANCE_M] * 1000.0

    df[:,:TIMEENTRY] = format_time.(df[:,:TIMEENTRY], hhmmss)
    df[:,:TIMEEXIT] = format_time.(df[:,:TIMEEXIT], hhmmss)

    df[:,:DATEENTRY] = format_date.(df[:,:DATEENTRY], yymmdd, addyear=year2000)
    df[:,:DATEEXIT] = format_date.(df[:,:DATEEXIT], yymmdd, addyear=year2000)
end
