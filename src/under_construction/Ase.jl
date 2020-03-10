"""
Ase fileformat
See EUROCONTROL NEST Manual for Ase fileformat description
"""
module Ase

export read

using Format
using CSV
using Dates

const fileformat = Dict(1=>Float64, 2=>Int64, 3=>Int64, 4=>Float64,
5=>Float64, 6=>Float64, 7=>Float64, 8=>String)

const header_format = ["FLIGHTCOUNT", "SEGMENTPARITY", "SEGMENTTYPE",
"LATBEGINSEGMENT", "LONBEGINSEGMENT", "LATENDSEGMENT", "LONENDSEGMENT",
"SEGMENTNAME"]

function read(file)
    return CSV.read(file, delim=" ", types=fileformat, header=header_format,
    copycols=true)
end

end # module
