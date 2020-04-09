"""
NTFV fileformat
See EUROCONTROL NEST Manual for Ntfv fileformat description

Example Ntfv fileformat
#;TRAFFIC_VOLUME;2;383;20140206;20140305;7799;EAR_P
T;ABSON;ABSON FLOWS;_;UKLVCTA;AS;G;5
F;BUK>AB;IN
F;BUK>AG;IN
F;DIB>AB;IN
F;INR>AB;IN
F;INR>AG;IN
T;AERODS1;EDNY ARRS VIA EDGGADS;_;EDGGADS;AS;G;1
F;>EDNY;IN
T;AERODS2;EDNY DEPS VIA EDGGADS;_;EDGGADS;AS;G;1
F;EDNY>;IN
;EX
"""
module Ntfv
#TODO Last element is not correctly read. Correction needed.
export read

struct Airblock
    name::String
    upperFL::String
end

struct Trafficvolume
    name::String
    category::String
    reflocname::String
    refloctype::String
    reflocrole::String
    airblocks::Vector{Airblock}
end

function read(file)
    trafficvolumes = Dict{String, Trafficvolume}()
    airblocks = Vector{Airblock}()
    tv_id = ""
    tv_name = ""
    category = ""
    reflocname = ""
    refloctype = ""
    reflocrole = ""

    for line in eachline(file)
        line_elements = split(line, ';')
        if line_elements[1] == "T"
            if tv_id != ""
                trafficvolumes[tv_id] = Trafficvolume(tv_name, category,
                reflocname, refloctype, reflocrole, airblocks)
                airblocks = Vector{Airblock}()
            end
                tv_id = line_elements[2]
                tv_name = line_elements[3]
                category = line_elements[4]
                reflocname = line_elements[5]
                refloctype = line_elements[6]
                reflocrole = line_elements[7]
        elseif line_elements[1] == "F"
            airblocks = vcat(airblocks, Airblock(line_elements[2],
            line_elements[3]))
        end
    end
    return trafficvolumes
end
#
# function splitintodict(iterator)
#     dict = Dict{String, Trafficvolume}()
#     airblocks = Vector{Airblock}(undef, 0)
#     j = 1
#     n_flowelements = j+2
#     trafficvolumeid = ""
#     trafficvolumename = ""
#     trafficvolumecategory = ""
#     reflocname = ""
#     refloctype = ""
#     reflocrole = ""
#     for (i, row) in enumerate(iterator)
#         if row.TorF == "F"
#             airblocks = vcat(airblocks, Airblock(row.ID, row.NAME))
#             if n_flowelements == j
#                 dict[trafficvolumeid] = Trafficvolume(trafficvolumeid,
#                 trafficvolumename, trafficvolumecategory, reflocname,
#                 refloctype, reflocrole, n_flowelements, airblocks)
#             end
#             j += 1
#         elseif row.TorF == "T"
#             trafficvolumeid = row.ID === missing ? "" : row.ID
#             trafficvolumename = row.NAME === missing ? "" : row.NAME
#             trafficvolumecategory = row.CATEGORY === missing ? "" : row.CATEGORY
#             reflocname = row.REFLOCNAME === missing ? "" : row.REFLOCNAME
#             refloctype = row.REFLOCTYPE === missing ? "" : row.REFLOCTYPE
#             reflocrole = row.REFLOCROLE === missing ? "" : row.REFLOCROLE
#             n_flowelements = parse(Int64, row.N_FLOWELEMENTS)
#             airblocks = Vector{Airblock}(undef, 0)
#             j = 1
#         else
#         end
#     end
#     return dict
# end

end # module"
