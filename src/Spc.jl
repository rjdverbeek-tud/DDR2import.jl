"""
SPC fileformat
See EUROCONTROL NEST Manual for Spc fileformat description
"""
module Spc

export read

using Format
using CSV
using Dates
# using StaticArrays

const fileformat = Dict(1=>String, 2=>String, 3=>String, 4=>String, 5=>String,
6=>String)

const header_format = ["AorS", "AIRSPACEID", "AIRSPACENAME", "AIRSPACETYPE",
"NSUBAIRSPACE", "AIRSPACECATEGORTY"]

struct Subairspace
    Name::String
    Type::String
end

struct Airspace
    ID::String
    Name::String
    Type::String
    N_subairspace::Int64
    Airspacecategory::String
    Subairspaces::Vector{Subairspace}
end

function read(file)
    csviterator = CSV.File(file, delim=";", types=fileformat,
    header=header_format, datarow=2, silencewarnings=true,
    ignoreemptylines=true)
    return splitintodict(csviterator)
end

function splitintodict(iterator)
    dict = Dict{String, Airspace}()
    subairspaces = Vector{Subairspace}(undef, 0)
    j = 1
    n_subairspace = j+2
    airspacename = ""
    airspaceid = ""
    airspacecategory = ""
    airspacetype = ""
    for (i, row) in enumerate(iterator)
        if row.AorS == "S"
            subairspaces = vcat(subairspaces, Subairspace(row.AIRSPACEID,
            row.AIRSPACENAME))
            if n_subairspace == j
                dict[airspaceid] = Airspace(airspaceid, airspacename,
                airspacetype, n_subairspace, airspacecategory, subairspaces)
            end
            j += 1
        elseif row.AorS == "A" # "A"
            airspaceid = row.AIRSPACEID === missing ? "" : row.AIRSPACEID
            airspacename = row.AIRSPACENAME === missing ? "" : row.AIRSPACENAME
            airspacetype = row.AIRSPACETYPE === missing ? "" : row.AIRSPACETYPE
            n_subairspace = parse(Int64, row.NSUBAIRSPACE)
            airspacecategory = row.AIRSPACECATEGORTY === missing ? "" : row.AIRSPACECATEGORTY
            subairspaces = Vector{Subairspace}(undef, 0)
            j = 1
        else
        end
    end
    return dict
end

end # module"
