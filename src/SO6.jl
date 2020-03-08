"""
SO6 fileformat
See EUROCONTROL NEST Manual for SO6 fileformat description
"""
module SO6

export read

using Format
using CSV
using Dates

const fileformat = Dict(1=>String, 2=>String, 3=>String, 4=>String, 5=>String,
6=>String, 7=>Int64, 8=>Int64, 9=>String, 10=>String, 11=>String, 12=>String,
13=>Float64, 14=>Float64, 15=>Float64, 16=>Float64, 17=>Int64, 18=>Int64,
19=>Float64, 20=>Int64)

const header_format = ["SEGMENT_ID", "ADEP", "ADES", "ACTYPE",
"TIMEBEGINSEGMENT", "TIMEENDSEGMENT", "FLBEGINSEGMENT", "FLENDSEGMENT",
"STATUS", "CALLSIGN", "DATEBEGINSEGMENT", "DATEENDSEGMENT", "LATBEGINSEGMENT_DEG",
"LONBEGINSEGMENT_DEG", "LATENDSEGMENT_DEG", "LONENDSEGMENT_DEG", "FLIGHT_ID",
"SEQUENCE", "SEGMENT_LENGTH_M", "SEGMENT_PARITY"]

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
    #Date conversion
    df[:,:TIMEBEGINSEGMENT] = format_time.(df[:,:TIMEBEGINSEGMENT], hhmmss)
    df[:,:TIMEENDSEGMENT] = format_time.(df[:,:TIMEENDSEGMENT], hhmmss)
    df[:,:DATEBEGINSEGMENT] = format_date.(df[:,:DATEBEGINSEGMENT], yymmdd,
    addyear=year2000)
    df[:,:DATEENDSEGMENT] = format_date.(df[:,:DATEENDSEGMENT], yymmdd,
    addyear=year2000)
    df[:,:LATBEGINSEGMENT_DEG] = df[:,:LATBEGINSEGMENT_DEG] / 60.0
    df[:,:LONBEGINSEGMENT_DEG] = df[:,:LONBEGINSEGMENT_DEG] / 60.0
    df[:,:LATENDSEGMENT_DEG] = df[:,:LATENDSEGMENT_DEG] / 60.0
    df[:,:LONENDSEGMENT_DEG] = df[:,:LONENDSEGMENT_DEG] / 60.0
    df[:,:SEGMENT_LENGTH_M] = df[:,:SEGMENT_LENGTH_M] * 1852.0
end

end # module
