"""
ARE fileformat

Newmaxo ASCII Region file

Example:
14 2799 925 0 0 660 0 0 0 0 0 0 0 0 0 LJ
2.799.925
2792 932
2797 943
2785.91 954.62
2780 942
2774 947
2781 957
2784 964
2784 975
2784 977
2790 974
2794 982
2790 992
2799 925

See EUROCONTROL NEST Manual sectino 9.7.6 for Are fileformat description
"""
module Are

export read

using Format
using CSV
using Dates
# using StaticArrays

# const fileformat = Dict(1=>String, 2=>String, 3=>String)
#
# const header_format = ["AorP", "LAT_DEG", "LON_DEG"]

struct Airspace
    nb_point::Int64
    bottom_fl::Float64
    top_fl::Float64
    surface::Float64
    sector_num::Float64
    points::Matrix{Float64}
end

function read(filename)
    dict = Dict{String, Airspace}()
    open(filename) do file
        j = 1
        nb_point = 3
        name = ""
        points = Matrix{Float64}(undef, 0, 2)
        bottom_fl = 0.0
        top_fl = 0.0
        surface = 0.0
        sector_num = 0.0
        for (i, ln) in enumerate(eachline(file))
            splitline = split(ln, " ")
            if length(splitline) == 2
                lat = parse(Float64, splitline[1]) / 60.0
                lon = parse(Float64, splitline[2]) / 60.0
                points = vcat(points, [lat lon])
                if j == nb_point
                    dict[name] = Airspace(nb_point, bottom_fl, top_fl, surface,
                    sector_num, points)
                end
                j += 1
            elseif length(splitline) == 15
                nb_point = parse(Int64, splitline[1])
                bottom_fl = parse(Float64, splitline[5])
                top_fl = parse(Float64, splitline[6])
                surface = parse(Float64, splitline[7])
                sector_num = parse(Float64, splitline[8])
                name = splitline[15]
                points = Matrix{Float64}(undef, 0, 2)
                j = 1
            else
            end

        end
    end
    return dict
end


# function read(file)
#     csviterator = CSV.File(file, delim=";", types=fileformat, header=header_format,
#     datarow=2)
#     return splitintodict(csviterator)
# end
#
# function splitintodict(iterator)
#     dict = Dict{String, Matrix{Float64}}()
#     points = Matrix{Float64}(undef, 0, 2)
#     j = 1
#     n_points = 1000
#     airblockname = ""
#     for (i, row) in enumerate(iterator)
#         if row.AorP == "P"
#             points = vcat(points,[parse(Float64, row.LAT_DEG) parse(Float64, row.LON_DEG)])
#             if j == n_points
#                 dict[airblockname] = points
#             end
#             j += 1
#         elseif row.AorP == "A" # "A"
#             airblockname = row.LAT_DEG
#             n_points = parse(Int64, row.LON_DEG)
#             points = Matrix{Float64}(undef, 0, 2)
#             j = 1
#         else
#         end
#     end
#     return dict
# end

end # module
