"""
ARP fileformat

Defines the geographical location of airports used in the assignment process

Example:
EGSX 3103.267 9.350 EGTT_FIR
EGSY 3203.650 -83.300 EGTT_FIR
EGSZ 3620.000 -102.000 EGPX_FIR
EGTA 3106.883 -56.550 EGTT_FIR
EGTB 3096.700 -48.483 EGTT_FIR

See EUROCONTROL NEST Manual sectino 9.7.7 for Arp fileformat description
"""
module Arp

export read

using CSV

const fileformat = Dict(1=>String, 2=>Float64, 3=>Float64, 4=>String)

const header_format = ["AIRPORT", "LAT_DEG", "LON_DEG", "FIR"]

function read(file)
    df = CSV.read(file, types=fileformat, header=header_format,
    copycols=true)
    reformat!(df)
    return df
end

function reformat!(df)
    df[:,:LAT_DEG] = df[:,:LAT_DEG] / 60.0
    df[:,:LON_DEG] = df[:,:LON_DEG] / 60.0
end

end # module
