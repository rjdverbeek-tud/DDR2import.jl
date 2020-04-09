"""
Spc fileformat
Described how elementary sectors can be collapsed. Can also contain descriptions
of other bigger airspaces (like ACC...)
See EUROCONTROL NEST Manual for Spc fileformat description

Output:
* name      Airspace name/description   String
* type      Airspace tuype              String  CS, CRSA, AUA, CLUS, NAS, AREA, AUAG, CRAS, REG, UNK
* sectors

Sub-airspace struct with the following elements:
* name      Sub-airspace name
* type      Sub-airspace type

Spc fileformat example
#;AIRSPACE;2;383;20140206;20140305;4082;EAR_P
A;BENELUX;EB/EH;AREA;2
S;EB;NAS
S;EH;NAS
A;BG;GREENLAND (DENMARK);NAS;1
S;BGGLFIR;FIR
A;BI;ICELAND;NAS;3
S;BIFAROER;FIR
S;BIRD;FIR
S;ENJA;FIR
A;BICC;ICELAND AUAG;AUAG;6
S;BIRDCTA;AUA
S;BIRDICTA;AUA
S;BIRDTMA;AUA
S;BIRDTOCA;AUA
S;EKVGCTR;AUA
S;ENJACTR;AUA
"""
module Spc

export read

struct Sector
    name::String
    type::String
end

struct Airspace
    name::String
    type::String
    sectors::Vector{Sector}
end

function read(file)
    airspaces = Dict{String, Airspace}()
    id = ""
    aname = ""
    type = ""
    sectors = Vector{Sector}()
    for line in eachline(file)
        line_elements = split(line, ';')
        if line_elements[1] == "A"
            if id != ""
                airspaces[id] = Airspace(aname, type, sectors)
            end
            id = line_elements[2]
            aname = line_elements[3]
            type = line_elements[4]
            sectors = Vector{Sector}()
        elseif line_elements[1] == "S"
            sname = line_elements[2]
            stype = line_elements[3]
            sector = Sector(sname, stype)
            sectors = vcat(sectors, sector)
        end
    end
    airspaces[id] = Airspace(aname, type, sectors)
    return airspaces
end

end # module
