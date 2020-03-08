"""
GSL fileformat
See EUROCONTROL NEST Manual for Gsl fileformat description
"""
module Gsl

export read

using Format
using CSV
using Dates
# using StaticArrays

const fileformat = Dict(1=>String, 2=>String, 3=>String, 4=>String, 5=>String, 6=>String)

const header_format = ["SorA", "AIRBLOCKNAME", "OPERATION", "LOWERFL", "UPPERFL", "SECTORTYPE"]

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
    N_airbocks::Int64
    AirblockNames::Vector{Airblock}
end

function read(file)
    csviterator = CSV.File(file, delim=";", types=fileformat, header=header_format,
    datarow=2, silencewarnings=true, ignoreemptylines=true)
    return splitintodict(csviterator)
end

function splitintodict(iterator)
    dict = Dict{String, Sector}()
    airblocks = Vector{Airblock}(undef, 0)
    j = 1
    n_airblocks = 1000
    sectorname = ""
    sectorid = ""
    sectorcategory = ""
    sectortype = ""
    for (i, row) in enumerate(iterator)
        if row.SorA == "A"
            airblocks = vcat(airblocks, Airblock(row.AIRBLOCKNAME,
            parse(Int64, row.LOWERFL), parse(Int64, row.UPPERFL)))
            if n_airblocks == j
                dict[sectorname] = Sector(sectorid, sectorname, sectorcategory,
                sectortype, n_airblocks, airblocks)
            end
            j += 1
        elseif row.SorA == "S" # "A"
            sectorname = row.OPERATION === missing ? "" : row.OPERATION
            sectorid = row.AIRBLOCKNAME === missing ? "" : row.AIRBLOCKNAME
            sectorcategory = row.UPPERFL === missing ? "" : row.UPPERFL
            sectortype = row.SECTORTYPE === missing ? "" : row.SECTORTYPE
            n_airblocks = parse(Int64, row.LOWERFL)
            airblocks = Vector{Airblock}(undef, 0)
            j = 1
        else
        end
    end
    return dict
end

end # module"
