"""
GSL fileformat

Describes how elementary sectors are built from airblocks (GAR)

See EUROCONTROL NEST Manual for Gsl fileformat description

Output:
Sectors dictionary with the following elements:
* ID        Sector ID           String
* Name      Sector name         String
* Category  Airspace category   String  Single character
* Type      Sectory typeassert  String  FIR=Flight Information Region,
                                        ERSA=Elementary Restricted Airspace,
                                        ES=Elementary Sector
                                        ERAS=Elementary Regulated Airspace
                                        UNK=Unknown type
* Airblocks                      Vector{Airblock}

Airblocks struct with the following elements:
* Name      Airblock name
* LowerFL   Lower flight level  Int64
* UpperFL   Upper flight level  Int64

GSL fileformat example
4
S;BALTIC;;1;_;ES
A;BALTIC;+;0;999
S;BGGLFIR;SONDRESTROM FIR;1;_;FIR
A;002BG;+;0;999
S;BIFAROER;FAEROER CTA;1;_;FIR
A;011BI;+;0;200
S;BIRD;_;9;_;FIR
A;001BI;+;0;999
A;002BI;+;0;999
A;003BI;+;0;999
A;004BI;+;0;999
A;011BI;+;200;999
A;100BI;+;0;999
A;104BI;+;0;999
A;107BI;+;0;999
A;108BI;+;0;999

"""
module Gsl

#TODO Last Sector is not read correctly. Correction needed and test.

export read

struct Airblock
    Name::String
    LowerFL::Int64
    UpperFL::Int64
end

struct Sector
    ID::String
    Name::String
    Category::String
    Type::String
    Airblocks::Vector{Airblock}
end

function read(file)
    sectors = Dict{String, Sector}()
    id = ""
    sname = ""
    category = 0
    type = ""
    airblocks = Vector{Airblock}()
    for line in eachline(file)
        line_elements = split(line, ';')
        if line_elements[1] == "S"
            if id != ""
                sectors[id] = Sector(id, sname, category, type, airblocks)
            end
            id = line_elements[2]
            sname = line_elements[3]
            category = line_elements[5]
            type = line_elements[6]
            airblocks = Vector{Airblock}()
        elseif line_elements[1] == "A"
            aname = line_elements[2]
            lowerfl = parse(Int64, line_elements[4])
            upperfl = parse(Int64, line_elements[5])
            airblock = Airblock(aname, lowerfl, upperfl)
            airblocks = vcat(airblocks, airblock)
        end
    end
    return sectors
end

end # module
