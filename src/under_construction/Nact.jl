"""
NACT fileformat
See EUROCONTROL NEST Manual for Nact fileformat description
"""
module Nact

export read

using Format
using CSV
using Dates
# using StaticArrays

const fileformat = Dict(1=>String, 2=>String, 3=>String)

const header_format = ["NAME", "TYPE", "ACTIVATION"]

struct Activation
    AirspaceOrTv::Bool # Airspace = true / Tv = false
    Activated::Bool # Activated = true / Non activated = false
end

function read(file)
    csviterator = CSV.File(file, delim=";", types=fileformat,
    header=header_format, silencewarnings=false, ignoreemptylines=true)
    return splitintovector(csviterator)
end

function splitintovector(iterator)
    dict = Dict{String, Activation}()
    for row in iterator
        airspaceortv = row.TYPE == "AS"
        activation = row.ACTIVATION == "A"
        dict[row.NAME] = Activation(airspaceortv, activation)
    end
    return dict
end

end # module"
