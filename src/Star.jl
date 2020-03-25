"""
Star fileformat

Output dictionary with for each Airport a list of STAR names.

See EUROCONTROL NEST Manual for Star fileformat description

Star fileformat example
BIKF THORI METIL ASTAM KEF CELLO
BIRK THORI METIL ASTAM KEF CELLO
DTMB MON.A
DTNH NBA.A
"""
module Star

export read

function read(file)
    airportstars = Dict{String, Vector{AbstractString}}()
    for line in eachline(file)
        line_elements = split(line, ' ')
        airport_name = line_elements[1]
        airportstars[airport_name] = [star for star in line_elements[2:end]]
    end
    return airportstars
end

end # module
