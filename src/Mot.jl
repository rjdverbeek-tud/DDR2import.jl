"""
Mot fileformat

Militairy opening times for usage with route choices

See EUROCONTROL NEST Manual for Mot fileformat description

Output:



Mot fileformat example
1 MIL1 1000 1200
1 MIL1 1400 1700
1 MIL2 0900 1300
1 MIL3 1100 1300
1 MIL4 0900 1800

2 MIL1 1000 1200 055 245
2 MIL1 1400 1700 085 285
2 MIL2 0900 1300 000 600
2 MIL3 1100 1300 125 245
2 MIL4 0900 1800 000 285

3 ED 2200 0500 EX
3 LF 2300 0600 EX
3 LI 2200 0500 E
"""
module Mot

using ..util
using Dates

export read

const hhmm = DateFormat("HHMM")

struct OnlyTime
    begintime::Union{Time, Missing}
    endtime::Union{Time, Missing}
end

struct TimeLevel
    begintime::Union{Time, Missing}
    endtime::Union{Time, Missing}
    lowerFL::Int64
    upperFL::Int64
end

struct TimeType
    begintime::Union{Time, Missing}
    endtime::Union{Time, Missing}
    type::String
end

struct OpeningTimes
    onlytimes::Vector{OnlyTime}
    timelevels::Vector{TimeLevel}
    timetypes::Vector{TimeType}
end

function read(file)
    militairyzones = Dict{String, OpeningTimes}()
    onlytimes = Vector{OnlyTime}()
    timelevels = Vector{TimeLevel}()
    timetypes = Vector{TimeType}()
    for line in eachline(file)
        line_elements = split(line)
        if length(line_elements) > 3
            begintime = format_time.(line_elements[3], hhmm)
            endtime = format_time.(line_elements[4], hhmm)
            if haskey(militairyzones, line_elements[2])
                openingtimes  = militairyzones[line_elements[2]]
                onlytimes = openingtimes.onlytimes
                timelevels = openingtimes.timelevels
                timetypes = openingtimes.timetypes
            else
                onlytimes = Vector{OnlyTime}()
                timelevels = Vector{TimeLevel}()
                timetypes = Vector{TimeType}()
            end

            if line_elements[1] == "1"
                onlytimes = vcat(onlytimes, OnlyTime(begintime, endtime))
            elseif line_elements[1] == "2"
                lowerFL = parse(Int64, line_elements[5])
                upperFL = parse(Int64, line_elements[6])
                timelevels = vcat(timelevels, TimeLevel(begintime, endtime, lowerFL, upperFL))
            elseif line_elements[1] == "3"
                timetypes = vcat(timetypes, TimeType(begintime, endtime, line_elements[5]))
            else
            end
            militairyzones[line_elements[2]] = OpeningTimes(onlytimes, timelevels, timetypes)
        end
    end
    return militairyzones
end

end # module
