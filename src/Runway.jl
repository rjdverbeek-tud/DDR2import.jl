"""
Runway fileformat

Example:
#;RUNWAY;2;446;20181206;20190102;241483;EAR_P
06/12/2018;BIAR;01;0000;2359;Y;5;1;1;T
06/12/2018;BIAR;19;0000;2359;N;5;1;1;T
06/12/2018;BIBA;03;0000;2359;N;10;10;5;T
06/12/2018;BIBA;12;0000;2359;Y;10;10;5;T
06/12/2018;BIBA;21;0000;2359;N;10;10;5;T
06/12/2018;BIBA;30;0000;2359;N;10;10;5;T
06/12/2018;BIBD;04;0000;2359;Y;10;10;5;T
06/12/2018;BIBD;22;0000;2359;N;10;10;5;T
06/12/2018;BIBF;18;0000;2359;N;10;10;5;T
06/12/2018;BIBF;36;0000;2359;Y;10;10;5;T
06/12/2018;BIBL;03;0000;2359;Y;10;10;5;T
06/12/2018;BIBL;21;0000;2359;N;10;10;5;T
"""
module Runway

export read

using ..util
using CSV
using Dates
using DataFrames

const ddmmYYYY = DateFormat("dd/mm/YYYY")
const hhmm = DateFormat("HHMM")

const fileformat = Dict(1=>String, 2=>String, 3=>String, 4=>String,
5=>String, 6=>String, 7=>Int64, 8=>Int64, 9=>Int64, 10=>String)

const header_format = ["DATEACTIVE", "AIRPORT", "RWY", "TIMEOPEN",
"TIMECLOSED", "YN", "NUM1", "NUM2", "NUM3", "T"]

function read(file)
    df = CSV.read(file, delim=';', types=fileformat, header=header_format,
    copycols=true, datarow=2)
    reformat!(df)
    return df
end

function reformat!(df)
    df[:,:TEMP] = format_date.(df[:,:DATEACTIVE], ddmmYYYY)
    select!(df, Not(:DATEACTIVE))
    df[:,:DATEACTIVE] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_time.(df[:,:TIMEOPEN], hhmm)
    select!(df, Not(:TIMEOPEN))
    df[:,:TIMEOPEN] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_time.(df[:,:TIMECLOSED], hhmm)
    select!(df, Not(:TIMECLOSED))
    df[:,:TIMECLOSED] =  df[:,:TEMP]
    select!(df, Not(:TEMP))
end

end # module
