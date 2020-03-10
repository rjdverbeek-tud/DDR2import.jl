"""
Cost fileformat
See EUROCONTROL NEST Manual for Cost fileformat description
"""
module Cost

export read

using Format
using CSV
using Dates

const fileformat = Dict(1=>Int64, 2=>String, 3=>Float64)

const header_format = ["FLIGHTID", "COUNTRYCODE", "COST"]

function read(file)
    return CSV.read(file, delim=" ", types=fileformat, header=header_format,
    copycols=true)
end

end # module
