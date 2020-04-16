module util

export Point, Point3D, extract_lat, extract_lon, latlon, format_date,
format_datetime, format_time, Point_deg

import Base:(convert)
using Dates
using Navigation: Point_deg, Point_rad

"Point type with latitude `lat` [deg] and longitude `lon` [deg]"
struct Point{T<:Float64}
    lat::T
    lon::T
end

"Point type with latitude `lat` [deg], longitude `lon` [deg] and altitude [m]"
struct Point3D{T<:Float64}
    lat::T
    lon::T
    alt::T
end

Base.:convert(type::Type{Point_deg}, x::Point) = Point_deg(x.lat, x.lon)
Base.:convert(type::Type{Point_rad}, x::Point) = Point_rad(deg2rad(x.lat), deg2rad(x.lon))
Base.:convert(type::Type{Point}, x::Point_deg) = Point(x.ϕ, x.λ)
Base.:convert(type::Type{Point}, x::Point_rad) = Point(rad2deg(x.ϕ), rad2deg(x.λ))

function extract_lat(str::AbstractString)
    if length(str) > 2
        if str[1] in ['N', 'S']
            sign_lat = str[1] == 'N' ? 1 : -1
            relative = 1
        elseif str[end] in ['N', 'S']
            sign_lat = str[end] == 'N' ? 1 : -1
            relative = 0
        else
            return NaN
        end
    else
        return NaN
    end

    lat_h = parse(Float64, str[relative+1:relative+2])
    lat_m = 0.0
    lat_s = 0.0
    if length(str) > 3
        lat_m = parse(Float64, str[relative+3:relative+4])
    end
    if length(str) > 5
        lat_s = parse(Float64, str[relative+5:end+relative-1])
    end
    return sign_lat*(lat_h + lat_m/60.0 + lat_s/3600.0)
end

function extract_lon(str::AbstractString)
    if length(str) > 3
        if str[1] in ['E', 'W']
            sign_lon = str[1] == 'E' ? 1 : -1
            relative = 1
        elseif str[end] in ['E', 'W']
            sign_lon = str[end] == 'E' ? 1 : -1
            relative = 0
        else
            return NaN
        end
    else
        return NaN
    end

    lon_h = parse(Float64, str[relative+1:relative+3])
    lon_m = 0.0
    lon_s = 0.0
    if length(str) > 4
        lon_m = parse(Float64, str[relative+4:relative+5])
    end
    if length(str) > 6
        lon_s = parse(Float64, str[relative+6:end+relative-1])
    end
    return sign_lon*(lon_h + lon_m/60.0 + lon_s/3600.0)
end

function latlon(str_lat::AbstractString, str_lon::AbstractString)
    lat = extract_lat(str_lat)
    lon = extract_lon(str_lon)
    if !isnan(lat*lon)
        # return Point(lat, lon)
        return Point_deg(lat, lon)
    else
        return NaN
    end
end

function latlon(str::AbstractString)
    nors = "S"
    if occursin("S", str)
        nors = "S"
    else
        nors = "N"
    end

    split_str = split(str, nors)
    str_lat = split_str[1]*nors
    str_lon = split_str[2]
    return latlon(str_lat, str_lon)
end

function format_date(str::Union{AbstractString, Missing}, format; addyear = Year(0))
    if str === missing
        return missing
    elseif str == "!!!!"
        return missing
    end
    maybedate = tryparse(Date, str, format)
    if maybedate == nothing
        return missing
    elseif maybedate > Date(1, 1, 1)
        return Date(str, format) + addyear
    else
        return missing
    end
end

function format_datetime(str::Union{AbstractString, Missing}, format; addyear = Year(0))
    if str === missing
        return missing
    elseif occursin("!!!!", str)
        return missing
    end
    maybedatetime = tryparse(DateTime, str, format)
    if maybedatetime == nothing
        return missing
    elseif maybedatetime > DateTime(1, 1, 1, 0, 0, 0)
        return DateTime(str, format) + addyear
    else
        return missing
    end
end

function format_time(str::Union{AbstractString, Missing}, format)
    if str === missing
        return missing
    end

    # handling special case of 2400 hours used in ATM to indicate 0000 24 hours later
    if str == "2400"
        str = "235959"
        format = DateFormat("HHMMSS")
    end

    maybetime = tryparse(Time, str, format)
    if maybetime == nothing
        return missing
    else
        if str == ""
            return missing
        else
            return Time(str, format)
        end
    end
end

end  #Module
