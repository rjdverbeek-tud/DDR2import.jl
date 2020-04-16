"""
Crco fileformat
See EUROCONTROL NEST Manual for Crco fileformat description

Example CRCO fileformat
ED N182QS B737 1523 3217.8167 599.3000 3018.8009 726.39836 396.03131430 090500 020322 0.000 095918 020322 270.000
LK N182QS B737 1523 3018.8009 726.3983 3019.0000 726.9864 0.78728520 095918 020322 270.000 095922 020322 270.000
LK N182QS B737 1523 3018.8009 726.3983 3019.0000 726.9864 0.78728520 111918 020322 270.000 111922 020322 270.000
ED N182QS B737 1523 3019.0000 726.9864 3217.8167 599.3000 395.93214016 111922 020322 270.000 121700 020322 0.000
"""
module Crco

export read

# include("utility.jl")
using ..util  # new
using Format
using CSV
using Dates
using DataFrames

const fileformat = Dict(1=>String, 2=>String, 3=>String, 4=>Int64, 5=>Float64,
6=>Float64, 7=>Float64, 8=>Float64, 9=>Float64, 10=>String, 11=>String,
12=>Float64, 13=>String, 14=>String, 15=>Float64)

const header_format = ["COUNTRYNAME", "CALLSIGN", "ACTYPE", "FLIGHTID",
"LATENTRY_DEG", "LONENTRY_DEG", "LATEXIT_DEG", "LONEXIT_DEG", "DISTANCE_M",
"TIMEENTRY", "DATEENTRY", "ENTRYFL", "TIMEEXIT", "DATEEXIT", "EXITFL"]

const yymmddhhmmss = DateFormat("YYmmddHHMMSS")
const year2000 = Year(2000)

function read(file)
    df = CSV.read(file, types=fileformat, header=header_format,
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

    df[:,:DATETIMEENTRY] = format_datetime.(df[:,:DATEENTRY] .* df[:,:TIMEENTRY],
    yymmddhhmmss, addyear=year2000)
    df[:,:DATETIMEEXIT] = format_datetime.(df[:,:DATEEXIT] .* df[:,:TIMEEXIT],
    yymmddhhmmss, addyear=year2000)

    select!(df, Not(:TIMEENTRY))
    select!(df, Not(:TIMEEXIT))
    select!(df, Not(:DATEENTRY))
    select!(df, Not(:DATEEXIT))
end

end #module
