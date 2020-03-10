"""
NTFV fileformat
See EUROCONTROL NEST Manual for Ntfv fileformat description
"""
module Ntfv

export read

using Format
using CSV
using Dates
# using StaticArrays

const fileformat = Dict(1=>String, 2=>String, 3=>String, 4=>String, 5=>String,
6=>String, 7=>String, 8=>String)

const header_format = ["TorF", "ID", "NAME", "CATEGORY", "REFLOCNAME",
"REFLOCTYPE", "REFLOCROLE", "N_FLOWELEMENTS"]

struct Airblock
    Name::String
    UpperFL::String
end

struct Trafficvolume
    ID::String
    Name::String
    Category::String
    Reflocname::String
    Refloctype::String
    Reflocrole::String
    N_flowelements::Int64
    Airblocks::Vector{Airblock}
end

function read(file)
    csviterator = CSV.File(file, delim=";", types=fileformat,
    header=header_format, datarow=2, silencewarnings=true,
    ignoreemptylines=true)
    return splitintodict(csviterator)
end

function splitintodict(iterator)
    dict = Dict{String, Trafficvolume}()
    airblocks = Vector{Airblock}(undef, 0)
    j = 1
    n_flowelements = j+2
    trafficvolumeid = ""
    trafficvolumename = ""
    trafficvolumecategory = ""
    reflocname = ""
    refloctype = ""
    reflocrole = ""
    for (i, row) in enumerate(iterator)
        if row.TorF == "F"
            airblocks = vcat(airblocks, Airblock(row.ID, row.NAME))
            if n_flowelements == j
                dict[trafficvolumeid] = Trafficvolume(trafficvolumeid,
                trafficvolumename, trafficvolumecategory, reflocname,
                refloctype, reflocrole, n_flowelements, airblocks)
            end
            j += 1
        elseif row.TorF == "T"
            trafficvolumeid = row.ID === missing ? "" : row.ID
            trafficvolumename = row.NAME === missing ? "" : row.NAME
            trafficvolumecategory = row.CATEGORY === missing ? "" : row.CATEGORY
            reflocname = row.REFLOCNAME === missing ? "" : row.REFLOCNAME
            refloctype = row.REFLOCTYPE === missing ? "" : row.REFLOCTYPE
            reflocrole = row.REFLOCROLE === missing ? "" : row.REFLOCROLE
            n_flowelements = parse(Int64, row.N_FLOWELEMENTS)
            airblocks = Vector{Airblock}(undef, 0)
            j = 1
        else
        end
    end
    return dict
end

end # module"
