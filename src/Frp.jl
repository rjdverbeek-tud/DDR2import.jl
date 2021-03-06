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

using ..util

struct FreeRoutePoint
    type::AbstractString
    name::AbstractString
    # point::Union{Point, AbstractString, Missing}
    point::Union{Point_deg, AbstractString, Missing}
end

struct FreeRouteAirports
    type::AbstractString
    name::AbstractString
    airports::Vector{String}
end

struct FreeRouteArea
    freeroutepoints::Vector{FreeRoutePoint}
    freerouteairports::Vector{FreeRouteAirports}
end

function read(file)
    freerouteareas = Dict{String, FreeRouteArea}()
    freerouteareaname = ""
    freeroutepoints = Vector{FreeRoutePoint}()
    freerouteairports = Vector{FreeRouteAirports}()

    lines = sort(readlines(file))

    for line in lines
        line_elements = split(line, ' ')
        if line_elements[1] != freerouteareaname  # new freeroutearea
            if freerouteareaname != ""
                freerouteareas[freerouteareaname] = FreeRouteArea(
                freeroutepoints, freerouteairports)
            end
            freerouteareaname = line_elements[1]
            freeroutepoints = Vector{FreeRoutePoint}()
            freerouteairports = Vector{FreeRouteAirports}()
        end

        if line_elements[2] in ["E", "X", "EX", "I", "EI", "XI", "EXI"]
            point_type = convert(String, line_elements[2])
            point_name = convert(String, line_elements[3])
            if length(line_elements) > 4
                point = latlon(line_elements[4], line_elements[5])
            elseif length(line_elements) > 3
                # println(line_elements)
                point = line_elements[4]
            else
                # println(line_elements)
                point = missing
            end
            freeroutepoints = vcat(freeroutepoints, FreeRoutePoint(point_type,
            point_name, point))
        elseif line_elements[2] in ["D", "A", "AD"]
            point_type = convert(String, line_elements[2])
            point_name = convert(String, line_elements[3])
            airports = Vector{String}()
            if length(line_elements) ≤ 3
            elseif length(line_elements) == 4
                airports = [convert(String, line_elements[4])]
            else
                for airport in line_elements[4:end]
                    airports = vcat(airports, convert(String, airport))
                end
            end
            freerouteairports = vcat(freerouteairports, FreeRouteAirports(point_type,
            point_name, airports))
        else

        end
    end
    freerouteareas[freerouteareaname] = FreeRouteArea(
    freeroutepoints, freerouteairports)
    return freerouteareas
end

end # module
