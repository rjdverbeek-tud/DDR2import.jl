"""
Sid fileformat

Output dictionary with for each Airport a list of SID names.

See EUROCONTROL NEST Manual for Sid fileformat description

Sid fileformat example
BIKF THORI ALDAN
BIRK THORI ALDAN
DTMB MON.D
DTNH NBA.D
"""
module Sid

export read

function read(file)
    airportsids = Dict{String, Vector{AbstractString}}()
    for line in eachline(file)
        line_elements = split(line, ' ')
        airport_name = line_elements[1]
        airportsids[airport_name] = [sid for sid in line_elements[2:end]]
    end
    return airportsids
end

end # module
