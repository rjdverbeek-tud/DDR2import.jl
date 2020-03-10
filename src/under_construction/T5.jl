"""
T5 fileformat
See EUROCONTROL NEST Manual for T5 fileformat description
"""
module T5

export read

using Format
using CSV
using Dates

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
    df[:,:ENTRY_DATETIME] = unix2datetime.(df[:,:ENTRY_DATETIME])
    df[:,:EXIT_DATETIME] = unix2datetime.(df[:,:EXIT_DATETIME])
    df[:,:ENTRY_DISTANCE_M] = df[:,:ENTRY_DISTANCE_M] * 1852.0
    df[:,:EXIT_DISTANCE_M] = df[:,:EXIT_DISTANCE_M] * 1852.0
    df[:,:TOT_DISTANCE_IN_SEGMENT_M] = df[:,:TOT_DISTANCE_IN_SEGMENT_M] * 1852.0
end

end # module
