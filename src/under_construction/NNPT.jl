"""
NNPT fileformat
See EUROCONTROL NEST Manual for NNPT fileformat description
"""
module NNPT

export read

using Format
using CSV
using Dates

const fileformat = Dict(1=>String, 2=>String, 3=>Float64, 4=>Float64, 5=>String)

const header_format = ["NAV_ID", "NAV_TYPE", "LAT_DEG", "LON_DEG", "NAV_NAME"]

function read(file)
    df = CSV.read(file, delim=";", types=fileformat, header=header_format,
    copycols=true, datarow=2)
    reformat!(df)
    return df
end

function reformat!(df)
    df[:,:NAV_NAME] = stringreformat.(df[:,:NAV_NAME])
end

function stringreformat(str::String)
    if str == "_"
        return missing
    else
        return str
    end
end

end # module
