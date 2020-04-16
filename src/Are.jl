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

Returns dictionary with airspace description
Key     Name of Volume

Airspace struct
nb_point    Contains the number of vertices of the volume
bottom_fl   Low level of the volume in flight level (FL). Can be 0.
top_fl      High level of the volume in flight level (FL). Can be 0.
surface     Value 2 (can be negative). Can be 0.
sector_num  Value 3 (can be negative). Can be 0.
points      Matrix with all lat/lon [deg] vertices of the volume (first/last the same)

See EUROCONTROL NEST Manual sectino 9.7.6 for Are fileformat description
"""
module Are

export read

# include("utility.jl")
using ..util
using Format
using CSV
using Dates
using Navigation

struct Airspace
    nb_point::Int64
    bottom_fl::Float64
    top_fl::Float64
    surface::Float64
    sector_num::Float64
    points::Matrix{Float64}
    box::Array{Float64, 2}
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
                    box = box_spherical_polygon(points)
                    dict[name] = Airspace(nb_point, bottom_fl, top_fl, surface,
                    sector_num, points, box)
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

function isinside(are::Airspace, point::Point)
    # test if inside box
    if isinsidebox(are, point)
        #test if inside polygon
        return NaN
    else
        return false
    end
end

function box_spherical_polygon(points::Array{Float64,2})
    box = Array{Float64, 2}(undef, 2, 2)
    lats_max = Array{Float64,1}()
    lats_min = Array{Float64,1}()
    previous_point = Array{Float64,1}()
    for point in eachrow(points)
        if isempty(previous_point)
            previous_point = point
        else
            pos₁ = Point(previous_point[1], previous_point[2])
            pos₂ = Point(point[1], point[2])
            append!(lats_max, maximum(latitude_options(pos₁, pos₂)))
            append!(lats_min, minimum(latitude_options(pos₁, pos₂)))
            previous_point = point
        end
    end
    box[1,1] = maximum(lats_max)
    box[2,1] = minimum(lats_min)

    # Limiting longitudes
    box[1,2] = maximum(points[:,2])
    box[2,2] = minimum(points[:,2])
    return box
end

function latitude_options(pos₁::Point, pos₂::Point)
    pos₁_deg = Navigation.Point_deg(pos₁.lat, pos₁.lon)
    pos₂_deg = Navigation.Point_deg(pos₁.lat, pos₁.lon)
    bearing = Navigation.bearing(pos₁_deg, pos₂_deg)
    closest_point_deg = Navigation.closest_point_to_pole(pos₁_deg, bearing)
    if Navigation.distance(pos₁_deg, pos₂_deg) > Navigation.distance(pos₁_deg,
        closest_point_deg)
        return pos₁.lat, pos₂.lat, closest_point_deg.ϕ
    else
        return pos₁.lat, pos₂.lat
    end
end

function isinsidebox(are::Airspace, point::Point)
    return are.box[2,1] < point.lat < are.box[1,1] && are.box[2,2] < point.lon < are.box[1,2]
end

end # module
