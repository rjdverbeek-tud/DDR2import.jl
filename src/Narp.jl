"""
NARP fileformat
See EUROCONTROL NEST Manual for NARP fileformat description

Example Narp file format
8214
AGGA;AUKI/GWAUNARU'U;-8.6983333333;160.6783333333;0;0;0;0
AGGE;BALALAE;-6.9833333333;155.8850000000;0;0;0;0
AGGH;HONIARA/HENDERSON;-9.4316666667;160.0533333333;0;0;0;0
AGGJ;AVU AVU;-9.8683333333;160.4100000000;0;0;0;0
AGGK;KIRA KIRA;-10.4500000000;161.8966666667;0;0;0;0
AGGL;GRACIOSA BAY;-10.7233333333;165.7800000000;0;0;0;0
AGGM;MUNDA;-8.3250000000;157.2633333333;0;0;0;0
AGGN;GIZO/NUSATAPE;-8.1016666667;156.8350000000;0;0;0;0
AGGP;PARASI;-9.6416666667;161.4252777778;0;0;0;82
"""
module Narp

export read

using Format
using CSV
using Dates
using DataFrames

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
    df[:,:TEMP] = string2int.(df[:,:TIS])
    select!(df, Not(:TIS))
    df[:,:TIS] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = string2int.(df[:,:TRS])
    select!(df, Not(:TRS))
    df[:,:TRS] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = string2int.(df[:,:TAXITIME])
    select!(df, Not(:TAXITIME))
    df[:,:TAXITIME] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = string2int.(df[:,:ALTITUDE_FL])
    select!(df, Not(:ALTITUDE_FL))
    df[:,:ALTITUDE_FL] =  df[:,:TEMP]
    select!(df, Not(:TEMP))
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
