"""
FRP fileformat

Used for generating Free Route segments

See EUROCONTROL NEST Manual for Frp fileformat description

Output:
TBD

Frp fileformat example
ALBANIA EX DIMIS N400421 E0203541
ALBANIA EX DOBAR N411958 E0202941
ALBANIA EX GOKEL N403554 E0190000
ALBANIA EX MAVAR N414012 E0203148
ALBANIA EX PAPIZ N405330 E0185706
ALBANIA EX PINDO N402851 E0205721
ALBANIA EX RETRA N421342 E0192006
ALBANIA EX RODON N412730 E0190600
ALBANIA E PETAK N414631 E0191850
ALBANIA A PETAK LATI
ALBANIA E AKIKA N423203 E0193614
ALBANIA E NIKRO N393957 E0200712
ALBANIA E TUMBO N400402 E0202822
ALBANIA E VJOSA N395855 E0202329
ALBANIA X ALELU N422845 E0195102
ALBANIA X EBELA N411136 E0185432
ALBANIA X PITAS N395400 E0195040
ALBANIA I DIRES N410328 E0191133
ALBANIA AD DIRES LATI
ALBANIA I DITAN N405644 E0191813
ALBANIA AD DITAN LATI
ALBANIA I ELBAK N405151 E0200452
ALBANIA AD ELBAK LATI
ALBANIA I INLOT N415847 E0192711
ALBANIA AD INLOT LATI
ALBANIA I ODRAS N413335 E0201027
ALBANIA AD ODRAS LATI
ALBANIA I RINAV N415901 E0194718
ALBANIA D RINAV LATI
ALBANIA I ADDER N403126 E0201817
ALBANIA I GRIBA N402830 E0193712
ALBANIA I MAGGI N411103 E0192236
ALBANIA I NURSO N403956 E0203217
ALBANIA I OVVER N403230 E0200046
ALBANIA I TR N412748 E0194251
ALBANIA I UMRES N412610 E0192553
ALBANIA I UNASA N412642 E0191801
ALBANIA I UNDER N410405 E0195651
ALBANIA I VALIN N411104 E0194600
ALBANIA I VOLBI N413855 E0194122
"""
module Frp

export read

struct Point
    Lat_deg::Float64
    Lon_deg::Float64
end

struct FreeRoutePoint
    Type::AbstractString
    Name::AbstractString
    Point::Union{Point, Missing}
end

struct FreeRouteAirports
    Type::AbstractString
    Name::AbstractString
    Airports::Vector{String}
end

struct FreeRouteArea
    freeroutepoints::Vector{FreeRoutePoint}
    freerouteairports::Vector{FreeRouteAirports}
end

function latlon(str::AbstractString)
    if length(str) == 15
        sign_lat = str[1] == 'N' ? 1 : -1
        lat_h = parse(Float64, str[2:3])
        lat_m = parse(Float64, str[4:5])
        lat_s = parse(Float64, str[6:7])
        sign_lon = str[8] == 'E' ? 1 : -1
        lon_h = parse(Float64, str[9:11])
        lon_m = parse(Float64, str[12:13])
        lon_s = parse(Float64, str[14:15])
    else
        return missing
    end
    return Point(sign_lat*(lat_h + lat_m/60.0 + lat_s/3600.0),
    sign_lon*(lon_h + lon_m/60.0 + lon_s/3600.0))
end

function read(file)
    freerouteareas = Dict{String, FreeRouteArea}()
    freerouteareaname = ""
    freeroutepoints = Vector{FreeRoutePoint}()
    freerouteairports = Vector{FreeRouteAirports}()
    for line in eachline(file)
        line_elements = split(line, ' ')
        if line_elements[1] != freerouteareaname  # new freeroutearea
            if freerouteareaname != ""
                freerouteareas[freerouteareaname] = FreeRouteArea(
                freeroutepoints, freerouteairports)
                println(freerouteareaname)
            end
            freerouteareaname = line_elements[1]
            freeroutepoints = Vector{FreeRoutePoint}()
            freerouteairports = Vector{FreeRouteAirports}()
        end

        if line_elements[2] in ["E", "X", "EX", "I", "EI", "XI", "EXI"]
            point_type = convert(String, line_elements[2])
            point_name = convert(String, line_elements[3])
            point = latlon(line_elements[4] * line_elements[5])
            freeroutepoints = vcat(freeroutepoints, FreeRoutePoint(point_type,
            point_name, point))
        elseif line_elements[2] in ["D", "A", "AD"]
            point_type = convert(String, line_elements[2])
            point_name = convert(String, line_elements[3])
            airports = Vector{String}()
            if length(line_elements) ≤ 3
                # if line_elements[1] == "EI_FRA"
                #     println(line)
                #     println(airports)
                # end
            elseif length(line_elements) == 4
                airports = [convert(String, line_elements[4])]
                # if line_elements[1] == "EI_FRA"
                #     println(line)
                #     println(airports)
                # end
            else
                # println(line_elements)
                for airport in line_elements[4:end]
                    airports = vcat(airports, convert(String, airport))
                end
                # if line_elements[1] == "EI_FRA"
                #     println(line)
                #     println(airports)
                # end
            end
            freerouteairports = vcat(freerouteairports, FreeRouteAirports(point_type,
            point_name, airports))
        else

        end
    end
    return freerouteareas
end

end # module
