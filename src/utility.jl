# module NestFormat
#
# export format_date, format_datetime, format_time
#
using Dates

function format_date(str::Union{String, Missing}, format; addyear = Year(0))
    if str === missing
        return missing
    end
    maybedate = tryparse(Date, str, format)
    if maybedate == nothing
        return missing
    elseif maybedate > Date(1, 1, 1)
        return Date(str, format) + addyear
    else
        return missing
    end
end

function format_datetime(str::Union{String, Missing}, format; addyear = Year(0))
    if str === missing
        return missing
    end
    maybedatetime = tryparse(DateTime, str, format)
    if maybedatetime == nothing
        return missing
    elseif maybedatetime > DateTime(1, 1, 1, 0, 0, 0)
        return DateTime(str, format) + addyear
    else
        return missing
    end
end

function format_time(str::Union{String, Missing}, format)
    if str === missing
        return missing
    end
    maybetime = tryparse(Time, str, format)
    if maybetime == nothing
        return missing
    else
        if str == ""
            return missing
        else
            return Time(str, format)
        end
    end
end