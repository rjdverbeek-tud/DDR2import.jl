"""
Ase fileformat
ASCII Segment File
Described as route network. Each line represents a route segment

See EUROCONTROL NEST Manual for Ase fileformat description

Ase DataFrame Column Names
#   Field           Type        Size    Comment
1   :FLIGHTCOUNT    Float64             normally number of flights using this route segment, could be a load
2   :SEGMENTPARITY  Int64               0=NO, 1=ODD, 2=EVEN, 3=ODD_LOW, 4=EVEN_LOW, 5=ODD_HIGH, 6=EVEN_HIGH
3   :SEGMENTTYPE    Int64               0=NO, 1=NORMAL, 2=ARRIVAL, 3=DEPARTURE (permanent rte segment)
                                        20=NO, 21=NORMAL, 22=ARRIVAL, 23=DEPARTURE (CDR Generic)
                                        40=NO, 41=NORMAL, 42=ARRIVAL, 43=DEPARTURE (CDR 1 )
                                        60=NO, 61=NORMAL, 62=ARRIVAL, 63=DEPARTURE (CDR 2)
                                        80=NO, 81=NORMAL, 82=ARRIVAL, 83=DEPARTURE (CDR 3)
                                        100=NO, 101=NORMAL, 102=ARRIVAL, 103=DEPARTURE (CDR 1+2)
                                        120=NO, 121=NORMAL, 122=ARRIVAL, 123=DEPARTURE (CDR 1+3)
4   :LATBEGINSEGMENT_DEG Float64
5   :LONBEGINSEGMENT_DEG Float64
6   :LATENDSEGMENT_DEG   Float64
7   :LONENDSEGMENT_DEG   Float64
8   :SEGMENTNAME    String      11      routePointNameBegin_routePointNameEnd (separator '_')

%% = TBD
%  = TBD
*  = TBD
"""
module Ase

export read

using Format
using CSV
using Dates

const fileformat = Dict(1=>Float64, 2=>Int64, 3=>Int64, 4=>Float64,
5=>Float64, 6=>Float64, 7=>Float64, 8=>String)

const header_format = ["FLIGHTCOUNT", "SEGMENTPARITY", "SEGMENTTYPE",
"LATBEGINSEGMENT_DEG", "LONBEGINSEGMENT_DEG", "LATENDSEGMENT_DEG", "LONENDSEGMENT_DEG",
"SEGMENTNAME"]

function read(file)
    df = CSV.read(file, delim=" ", types=fileformat, header=header_format,
    copycols=true)
    reformat!(df)
    return df
end

function reformat!(df)
    df[:,:LATBEGINSEGMENT_DEG] = df[:,:LATBEGINSEGMENT_DEG] / 60.0
    df[:,:LONBEGINSEGMENT_DEG] = df[:,:LONBEGINSEGMENT_DEG] / 60.0
    df[:,:LATENDSEGMENT_DEG] = df[:,:LATENDSEGMENT_DEG] / 60.0
    df[:,:LONENDSEGMENT_DEG] = df[:,:LONENDSEGMENT_DEG] / 60.0
end

end # module
