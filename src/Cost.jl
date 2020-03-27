"""
Cost fileformat
See EUROCONTROL NEST Manual for Cost fileformat description

Example cost fileformat
139729486 ED 356.159
139729486 LB 230.25
139729486 LC 86.7351
139729486 LH 148.107
139729486 LO 234.767
139729486 LT 365.319
139729486 LY 190.189
"""
module Cost

export read

using CSV

const fileformat = Dict(1=>Int64, 2=>String, 3=>Float64)

const header_format = ["FLIGHTID", "COUNTRYCODE", "COST"]

function read(file)
    return CSV.read(file, delim=" ", types=fileformat, header=header_format,
    copycols=true)
end

end # module
