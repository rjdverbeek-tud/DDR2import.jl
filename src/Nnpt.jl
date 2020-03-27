"""
NNPT fileformat
See EUROCONTROL NEST Manual for NNPT fileformat description

Example NNPT file format
17189
*01BP;DB;47.6513888888889;19.1944444444444;_
*01DC;DB;47.57;21.7191666666667;_
*01RD;DB;52.1555555555556;4.78694444444444;_
*02BP;DB;47.3927777777778;19.5241666666667;_
*02DC;DB;47.3327777777778;21.5022222222222;_
*03BP;DB;47.1725;19.6636111111111;_
*03DC;DB;47.3191666666667;21.6580555555556;_
*03RD;DB;52.0022222222222;4.57416666666667;_
*04BP;DB;47.2441666666667;19.7613888888889;_
*04DC;DB;47.3402777777778;21.7294444444444;_
*04RD;DB;51.8711111111111;4.55694444444444;_
*05BP;DB;47.7327777777778;18.7886111111111;_
"""
module Nnpt

export read

using Format
using CSV
using Dates
using DataFrames

const fileformat = Dict(1=>String, 2=>String, 3=>Float64, 4=>Float64, 5=>String)

const header_format = ["NAV_ID", "NAV_TYPE", "LAT_DEG", "LON_DEG", "NAV_NAME"]

function read(file)
    df = CSV.read(file, delim=";", types=fileformat, header=header_format,
    copycols=true, datarow=2)
    reformat!(df)
    return df
end

function reformat!(df)
    df[:,:TEMP] = stringreformat.(df[:,:NAV_NAME])
    select!(df, Not(:NAV_NAME))
    df[:,:NAV_NAME] =  df[:,:TEMP]
    select!(df, Not(:TEMP))
end

function stringreformat(str::String)
    if str == "_"
        return missing
    else
        return str
    end
end

end # module
