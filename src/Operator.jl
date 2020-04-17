"""
Operator fileformat

Create the link between the ICAO operator code, the operator name, and
the country of origin

Example:
#;OPERATOR;1;446;20181206;20190102;6478;EAR_P
AAA;ANSETT AUSTRALIA HOLDINGS LTD;ANSETT;AU;AUSTRALIA;19000101;21001231
AAB;ABELAG AVIATION;ABG;BE;BELGIUM;19000101;21001231
AAC;ARMY AIR CORPS;ARMYAIR;GB;UNITED KINGDOM;19000101;21001231
AAD;AERO AVIATION CENTRE LTD.;SUNRISE;CA;CANADA;19000101;21001231
AAE;EXPRESS AIR, INC.  (PHOENIX, AZ);ARIZONA;US;UNITED STATES;19000101;21001231
AAF;AIGLE AZUR;AIGLE AZUR;FR;FRANCE;19000101;21001231
AAG;AIR ATLANTIQUE;ATLANTIC;GB;UNITED KINGDOM;20150101;21001231
"""
module Operator

export read

using Dates

struct OperatorICAO
    name::String
    callsign::String
    countryid::String
    country::String
    startdate::Date
    enddate::Date
    function OperatorICAO(name, callsign, countryid, country, startdate, enddate)
        sd = Date(startdate, "YYYYmmdd")
        ed = Date(enddate, "YYYYmmdd")
        new(name, callsign, countryid, country, sd, ed)
    end
end

function read(file)
    operators = Dict{String, OperatorICAO}()
    for line in eachline(file)
        line_elements = split(line, ';')
        if length(line_elements) == 7
            operators[line_elements[1]] = OperatorICAO(line_elements[2],
            line_elements[3], line_elements[4], line_elements[5],
            line_elements[6], line_elements[7])
        end
    end
    return operators
end

end # module
