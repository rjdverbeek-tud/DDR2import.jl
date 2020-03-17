"""
T5 fileformat
See EUROCONTROL NEST Manual for T5 fileformat description

T5 DataFrame Column Names

Field               Type    Size    Comment
:FLIGHT_ID           Int64           Flight ID
:SECTOR_NAME         String
:ENTRY_DATETIME      DateTime
:EXIT_DATETIME       DateTime
:ENTRY_FL            Float64         Flight level in decimal
:EXIT_FL             Float64         Flight level in decimal
:ENTRY_SEGMENT_NAME  String          Separator between point name is '_'
                                    '##' as a prefix means that the flight was
                                    already present in the sector before it was
                                    opened
:EXIT_SEGMENT_NAME   String          Separator between point name is '_', might
                                    be different from ENTRY_SEGMENT_NAME
                                    '##' as a prefix means that the flight was
                                    still present in the sector after it was
                                    closed.
:TOT_DISTANCE_IN_SEGMENT_M Float64   For that FLIGHT_ID in that SECTOR_NAME,
                                    expressed in meters.
:TOT_TIME_IN_SEGMENT_S Float64       For that FLIGHT_ID in that SECTOR_NAME,
                                    expressed in seconds.

Example T5 file format
213765625 EHAMCR1 1513288140.000000 1513288226.000000 0.000000 35.000000 0.000000 1.669195 EHAM_*AM80 !AAEW_!AAEX 4.749612 86.000000
213765625 EHAAFIR 1513288140.000000 1513288980.000000 0.000000 255.000000 0.000000 14.478077 EHAM_*AM80 !AAEb_SONEB 84.060844 840.000000
213765625 EHALL 1513288140.000000 1513288980.000000 0.000000 255.000000 0.000000 14.478077 EHAM_*AM80 !AAEb_SONEB 84.060844 840.000000
213765625 EH_DN 1513288140.000000 1513288982.000000 0.000000 255.361450 0.000000 0.247570 EHAM_*AM80 SONEB_OLDOD 84.308411 842.000000
"""
module T5

export read

using Format
using CSV
using Dates
using DataFrames

const fileformat = Dict(1=>Int64, 2=>String, 3=>Float64, 4=>Float64, 5=>Float64,
6=>Float64, 7=>Float64, 8=>Float64, 9=>String, 10=>String, 11=>Float64,
12=>Float64)

const header_format = ["FLIGHT_ID", "SECTOR_NAME", "ENTRY_DATETIME",
"EXIT_DATETIME", "ENTRY_FL", "EXIT_FL", "ENTRY_DISTANCE_M", "EXIT_DISTANCE_M",
"ENTRY_SEGMENT_NAME", "EXIT_SEGMENT_NAME", "TOT_DISTANCE_IN_SEGMENT_M",
"TOT_TIME_IN_SEGMENT_S"]

function read(file)
    df = CSV.read(file, delim=" ", types=fileformat, header=header_format,
    copycols=true)
    reformat!(df);
    return df
end

function reformat!(df)
    #Date conversion
    df[:,:TEMP] = df[:,:ENTRY_DATETIME]
    select!(df, Not(:ENTRY_DATETIME))
    df[:,:ENTRY_DATETIME] =  unix2datetime.(df[:,:TEMP])
    select!(df, Not(:TEMP))

    df[:,:TEMP] = df[:,:EXIT_DATETIME]
    select!(df, Not(:EXIT_DATETIME))
    df[:,:EXIT_DATETIME] =  unix2datetime.(df[:,:TEMP])
    select!(df, Not(:TEMP))

    df[:,:ENTRY_DISTANCE_M] = df[:,:ENTRY_DISTANCE_M] * 1852.0
    df[:,:EXIT_DISTANCE_M] = df[:,:EXIT_DISTANCE_M] * 1852.0
    df[:,:TOT_DISTANCE_IN_SEGMENT_M] = df[:,:TOT_DISTANCE_IN_SEGMENT_M] * 1852.0

    select!(df,[:FLIGHT_ID, :SECTOR_NAME, :ENTRY_DATETIME, :EXIT_DATETIME,
    :ENTRY_FL, :EXIT_FL, :ENTRY_SEGMENT_NAME, :EXIT_SEGMENT_NAME,
    :TOT_DISTANCE_IN_SEGMENT_M, :TOT_TIME_IN_SEGMENT_S])
end

end # module
