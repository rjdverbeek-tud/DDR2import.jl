"""
Import SO6 fileformat as a DataFrame

See EUROCONTROL NEST Manual for original SO6 fileformat description

SO6 DataFrame Column Names

#                   Field                   Type    Size    Comment
:SEGMENT_ID          segment identifier      String          first point name "_" last point name (see note)
:ADEP                origin of flight        String  4       ICAO code
:ADES                destination of flight   String  4       ICAO code
:ACTYPE              aircraft type           String  4
:DATETIMEBEGINSEGMENT                        DateTime
:DATETIMEENDSEGMENT                          DateTime
:FLBEGINSEGMENT      FL begin segment        Int64   1-3
:FLENDSEGMENT        FL begin segment        Int64   1-3
:STATUS              flight status           Int64   1       0=climb, 1=descent, 2=cruise
:CALLSIGN                                    String
:LATBEGINSEGMENT_DEG Latitude of begin of segment in degrees     Float64
:LONBEGINSEGMENT_DEG Longitude of begin of segment in degrees    Float64
:LATENDSEGMENT_DEG   Latitude of begin of segment in degrees     Float64
:LONENDSEGMENT_DEG   Longitude of begin of segment in degrees Float64
:FLIGHT_ID           Flight identifier       Int64           Unique ID
:SEQUENCE            Sequence number         Int64           Start at 1 for new flight
:SEGMENT_LENGTH_M    Segment length in m     Float64         In meters
:SEGMENT_PARITY      Segment parity          Int64           * see below

* Segment parity
0=NO
1=ODD
2=EVEN
3=ODD_LOW
4=EVEN_LOW
5=ODD_HIGH
6=EVEN_HIGH
7 =General Purpose
8=General Purpose
9=General Purpose

Example SO6 file format
EHAM_*AM80 EHAM UUEE A321 214900 214926 0 10 0 AFL2193 171214 171214 3138.483333 285.850000 3137.483333 284.183333 213765625 1 1.427867 0
*AM80_!AAEW EHAM UUEE A321 214926 215004 10 25 0 AFL2193 171214 171214 3137.483333 284.183333 3135.833333 284.033333 213765625 2 1.652550 0
!AAEW_!AAEX EHAM UUEE A321 215004 215026 25 35 0 AFL2193 171214 171214 3135.833333 284.033333 3134.166667 283.883333 213765625 3 1.669195 0
!AAEX_*AM46 EHAM UUEE A321 215026 215047 35 45 0 AFL2193 171214 171214 3134.166667 283.883333 3133.066667 283.783333 213765625 4 1.101704 0
"""
module SO6

export read

include("utility.jl")
using CSV
using Dates
using DataFrames

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
const yymmddhhmmss = DateFormat("YYmmddHHMMSS")
const year2000 = Year(2000)

function read(file)
    df = CSV.read(file, delim=" ", types=fileformat, header=header_format,
    copycols=true)
    reformat!(df);
    return df
end

function format_status(str::Union{String, Missing})
    if str === missing
        return missing
    end
    maybeint = tryparse(Int64, str)
    if maybeint == nothing
        return missing
    else
        return parse(Int64, str)
    end
end

function reformat!(df)
    #Date/Time conversion
    df[:,:DATETIMEBEGINSEGMENT] = format_datetime.(df[:,:DATEBEGINSEGMENT] .*
    df[:,:TIMEBEGINSEGMENT], yymmddhhmmss, addyear=year2000)

    df[:,:DATETIMEENDSEGMENT] = format_datetime.(df[:,:DATEENDSEGMENT] .*
    df[:,:TIMEENDSEGMENT], yymmddhhmmss, addyear=year2000)

    select!(df, Not(:TIMEBEGINSEGMENT))
    select!(df, Not(:TIMEENDSEGMENT))
    select!(df, Not(:DATEBEGINSEGMENT))
    select!(df, Not(:DATEENDSEGMENT))

    df[:,:TEMP] = format_status.(df[:,:STATUS])
    select!(df, Not(:STATUS))
    df[:,:STATUS] = df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:LATBEGINSEGMENT_DEG] = df[:,:LATBEGINSEGMENT_DEG] / 60.0
    df[:,:LONBEGINSEGMENT_DEG] = df[:,:LONBEGINSEGMENT_DEG] / 60.0
    df[:,:LATENDSEGMENT_DEG] = df[:,:LATENDSEGMENT_DEG] / 60.0
    df[:,:LONENDSEGMENT_DEG] = df[:,:LONENDSEGMENT_DEG] / 60.0
    df[:,:SEGMENT_LENGTH_M] = df[:,:SEGMENT_LENGTH_M] * 1852.0

    select!(df,[:SEGMENT_ID, :ADEP, :ADES, :ACTYPE, :DATETIMEBEGINSEGMENT,
    :DATETIMEENDSEGMENT, :FLBEGINSEGMENT, :FLENDSEGMENT, :STATUS, :CALLSIGN,
    :LATBEGINSEGMENT_DEG, :LONBEGINSEGMENT_DEG, :LATENDSEGMENT_DEG,
    :LONENDSEGMENT_DEG, :FLIGHT_ID, :SEQUENCE, :SEGMENT_LENGTH_M,
    :SEGMENT_PARITY])
end

end # module
