"""
GAR fileformat
See EUROCONTROL NEST Manual for Gar fileformat description

Dictionary with point list (latitude + longitude [deg]) for each airblock ID (key)
"""
module Gar

export read

using Format
using CSV
using Dates
# using StaticArrays

const fileformat = Dict(1=>String, 2=>String, 3=>String)

const header_format = ["AorP", "LAT_DEG", "LON_DEG"]

function read(file)
    csviterator = CSV.File(file, delim=";", types=fileformat, header=header_format,
    datarow=2)
    return splitintodict(csviterator)
end

function splitintodict(iterator)
    dict = Dict{String, Matrix{Float64}}()
    points = Matrix{Float64}(undef, 0, 2)
    j = 1
    n_points = 1000
    airblockname = ""
    for (i, row) in enumerate(iterator)
        if row.AorP == "P"
            points = vcat(points,[parse(Float64, row.LAT_DEG) parse(Float64, row.LON_DEG)])
            if j == n_points
                dict[airblockname] = points
            end
            j += 1
        elseif row.AorP == "A"
            airblockname = row.LAT_DEG
            n_points = parse(Int64, row.LON_DEG)
            points = Matrix{Float64}(undef, 0, 2)
            j = 1
        else
        end
    end
    return dict
end

end # module
