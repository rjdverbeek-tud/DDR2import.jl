"""
Country fileformat

Create the link between the country code and the country name

Example:
#;COUNTRY;2;446;20181206;20190102;307;EAR_P
AG;Solomon Islands;N
AN;Nauru;N
AY;Papua New Guinea;N
BG;Greenland (Denmark);N
BI;Iceland;Y
"""
module Country

export read

struct CountryDc
    name::String
    member::Bool
    CountryDc(name, member) = new(name, member=="Y")
    # Country(name::AbstractString, member::Bool) = new(name, member)
end

function read(file)
    countries = Dict{String, CountryDc}()
    for line in eachline(file)
        line_elements = split(line, ';')
        if length(line_elements) == 3
            countries[line_elements[1]] = CountryDc(line_elements[2],
            line_elements[3])
        end
    end
    return countries
end

end # module
