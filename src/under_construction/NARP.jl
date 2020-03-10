"""
NARP fileformat
See EUROCONTROL NEST Manual for NARP fileformat description
"""
module NARP

export read

using Format
using CSV
using Dates

const fileformat = Dict(1=>String, 2=>String, 3=>Float64, 4=>Float64,
5=>String, 6=>String, 7=>String, 8=>String)

const header_format = ["AIRPORT_ID", "AIRPORT_NAME", "LAT_DEG", "LON_DEG",
"TIS", "TRS", "TAXITIME", "ALTITUDE_FL"]

function read(file)
    df = CSV.read(file, delim=";", types=fileformat, header=header_format,
    copycols=true, datarow=2)
    reformat!(df)
    return df
end

function reformat!(df)
    #Date conversion
    df[:,:TIS] = string2int.(df[:,:TIS])
    df[:,:TRS] = string2int.(df[:,:TRS])
    df[:,:TAXITIME] = string2int.(df[:,:TAXITIME])
    df[:,:ALTITUDE_FL] = string2int.(df[:,:ALTITUDE_FL])
end

function string2int(str::String)
    maybeint = tryparse(Int, str)
    if maybeint == nothing
        return missing
    elseif str == ""
        return missing
    else
        return maybeint
    end
end

end # module
