#TODO ftfmEetFirList_73
#TODO ftfmEetPtList_75
#TODO ftfmReqFlightlevelSpeedList_81

"""
ALL_FT+ fileformat

Defines a list of flight trajectories (planned/actual/etc) for a given day

See EUROCONTROL NEST Manual Section 9.7.5 for ALL_FT+ fileformat description
"""
module Allftplus

export read

include("utility.jl")
using Format
using CSV
using Dates
using DataFrames

const fileformat = Dict(1=>String, 2=>String, 3=>String, 4=>String, 5=>String,
6=>String, 7=>String, 8=>String, 9=>String, 10=>String, 11=>String, 12=>String,
13=>String, 14=>String, 15=>String, 16=>String, 17=>String, 18=>String,
19=>String, 20=>String, 21=>String, 22=>String, 23=>Int64, 24=>String,
25=>String, 26=>String, 27=>String, 28=>String, 29=>String, 30=>Int64,
31=>Int64, 32=>String, 33=>String, 34=>String, 35=>String, 36=>String,
37=>String, 38=>String, 39=>Int64, 40=>Int64, 41=>Int64, 42=>String,
43=>String, 44=>String, 45=>String, 46=>String, 47=>String, 48=>String,
49=>String, 50=>String, 51=>String, 52=>Int64, 53=>Int64, 54=>Int64,
55=>Int64, 56=>String, 57=>String, 58=>String, 59=>String, 60=>String,
61=>String, 62=>String, 63=>String, 64=>String, 65=>String, 66=>String,
67=>String, 68=>Int64, 69=>String, 70=>String, 71=>String, 72=>String,
73=>Int64, 74=>String, 75=>Int64, 76=>String, 77=>Int64, 78=>Int64,
79=>String, 80=>String, 81=>Int64, 82=>String, 83=>Int64, 84=>Int64,
85=>String, 86=>String, 87=>Int64, 88=>String, 89=>String, 90=>String,
91=>String, 92=>String, 93=>String, 94=>String, 95=>Int64, 96=>String,
97=>Int64, 98=>Int64, 99=>Int64, 100=>String, 101=>Int64, 102=>String,
103=>String, 104=>String, 105=>String, 106=>String, 107=>String, 108=>String,
109=>Int64, 110=>String, 111=>Int64, 112=>Int64, 113=>Int64, 114=>String,
115=>Int64, 116=>String, 117=>String, 118=>String, 119=>String, 120=>String,
121=>String, 122=>String, 123=>String, 124=>String, 125=>String, 126=>String,
127=>String, 128=>String, 129=>String, 130=>String, 131=>String, 132=>String,
133=>String, 134=>String, 135=>String, 136=>String, 137=>String, 138=>String,
139=>String, 140=>String, 141=>String, 142=>String, 143=>String, 144=>String,
145=>String, 146=>String, 147=>String, 148=>String, 149=>String, 150=>String,
151=>String, 152=>String, 153=>String, 154=>String, 155=>String, 156=>String,
157=>String, 158=>String, 159=>String, 160=>String, 161=>String, 162=>String,
163=>String, 164=>String, 165=>String, 166=>String, 167=>String, 168=>String,
169=>String, 170=>String, 171=>String, 172=>String, 173=>String, 174=>String,
175=>String, 176=>String, 177=>String, 178=>String, 179=>String, 180=>String)

const header_format = ["departureAerodromeIcaoId_0", "arrivalAerodromeIcaoId_1",
"aircraftId_2", "aircraftOperatorIcaoId_3", "aircraftTypeIcaoId_4", "aobt_5",
"ifpsId_6", "iobt_7", "originalFlightDataQuality_8", "flightDataQuality_9",
"source_10", "exemptionReasonType_11", "exemptionReasonDistance_12", "lateFiler_13",
"lateUpdater_14", "northAtlanticFlight_15", "cobt_16", "eobt_17", "lobt_18",
"flightState_19", "previousToActivationFlightState_20", "suspensionStatus_21",
"tactId_22", "samCtot_23", "samSent_24", "sipCtot_25", "sipSent_26", "slotForced_27",
"mostPenalizingRegulationId_28", "regulationsAffectedByNrOfInstances_29",
"excludedFromNrOfInstances_30", "lastReceivedAtfmMessageTitle_31",
"lastReceivedMessageTitle_32", "lastSentAtfmMessageTitle_33",
"manualExemptionReason_34", "sensitiveFlight_35", "readyForImprovement_36",
"readyToDepart_37", "revisedTaxiTime_38", "tis_39", "trs_40",
"toBeSentSlotMessageTitle_41", "toBeSentProposalMessageTitle_42",
"lastSentSlotMessageTitle_43", "lastSentProposalMessageTitle_44",
"lastSentSlotMessage_45", "lastSentProposalMessage_46", "flightCountOption_47",
"normalFlightTactId_48", "proposalFlightTactId_49",
"operatingAircraftOperatorIcaoId_50", "reroutingWhy_51", "reroutedFlightState_52",
"runwayVisualRange_53", "numberIgnoredErrors_54", "arcAddrSource_55", "arcAddr_56",
"ifpsRegistrationMark_57", "flightType_58", "aircraftEquipment_59", "cdmStatus_60",
"cdmEarlyTtot_61", "cdmAoTtot_62", "cdmAtcTtot_63", "cdmSequencedTtot_64",
"cdmTaxiTime_65", "cdmOffBlockTimeDiscrepancy_66", "cdmDepartureProcedureId_67",
"cdmAircraftTypeId_68", "cdmRegistrationMark_69", "cdmNoSlotBefore_70",
"cdmDepartureStatus_71", "ftfmEetFirNrOfInstances_72", "ftfmEetFirList_73",
"ftfmEetPtNrOfInstances_74", "ftfmEetPtList_75", "ftfmAiracCycleReleaseNumber_76",
"ftfmEnvBaselineNumber_77", "ftfmDepartureRunway_78", "ftfmArrivalRunway_79",
"ftfmReqFlightlevelSpeedNrOfInstances_80", "ftfmReqFlightlevelSpeedList_81",
"82ftfmConsumedFuel", "83ftfmRouteCharges", "84ftfmAllFtPointNrOfInstances",
"85ftfmAllFtPointProfile", "86ftfmAllFtAirspaceNrOfInstances",
"87ftfmAllFtAirspaceProfile", "88ftfmAllFtCircleIntersectionsNrOfInstances",
"89ftfmAllFtCircleIntersections", "90rtfmAiracCycleReleaseNumber",
"91rtfmEnvBaselineNumber", "92rtfmDepartureRunway", "93rtfmArrivalRunway",
"94rtfmReqFlightlevelSpeedNrOfInstances", "95rtfmReqFlightlevelSpeedList",
"96rtfmConsumedFuel", "97rtfmRouteCharges", "98rtfmAllFtPointNrOfInstances",
"99rtfmAllFtPointProfile", "100rtfmAllFtAirspaceNrOfInstances",
"101rtfmAllFtAirspaceProfile", "102rtfmAllFtCircleIntersectionsNrOfInstances",
"103rtfmAllFtCircleIntersections", "104ctfmAiracCycleReleaseNumber",
"105ctfmEnvBaselineNumber", "106ctfmDepartureRunway", "107ctfmArrivalRunway",
"108ctfmReqFlightlevelSpeedNrOfInstances", "109ctfmReqFlightlevelSpeedList",
"110ctfmConsumedFuel", "111ctfmRouteCharges", "112ctfmAllFtPointNrOfInstances",
"113ctfmAllFtPointProfile", "114ctfmAllFtAirspaceNrOfInstances",
"115ctfmAllFtAirspaceProfile", "116ctfmAllFtCircleIntersectionsNrOfInstances",
"117ctfmAllFtCircleIntersections", "118noCPGCPFReason", "119scrObt",
"120scrConsumedFuel", "121scrRouteCharges", "122scrAllFtPointNrOfInstances",
"123scrAllFtPointProfile", "124scrAllFtAirspaceNrOfInstances",
"125scrAllFtAirspaceProfile", "126scrAllFtCircleIntersectionsNrOfInstances",
"127scrAllFtCircleIntersections", "128srrObt", "129srrConsumedFuel",
"130srrRouteCharges", "131srrAllFtPointNrOfInstances", "132srrAllFtPointProfile",
"133srrAllFtAirspaceNrOfInstances", "134srrAllFtAirspaceProfile",
"135srrAllFtCircleIntersectionsNrOfInstances", "136srrAllFtCircleIntersections",
"137surObt", "138surConsumedFuel", "139surRouteCharges",
"140surAllFtPointNrOfInstances", "141surAllFtPointProfile",
"142surAllFtAirspaceNrOfInstances", "143surAllFtAirspaceProfile",
"144surAllFtCircleIntersectionsNrOfInstances", "145surAllFtCircleIntersections",
"146dctObt", "147dctConsumedFuel", "148dctRouteCharges",
"149dctAllFtPointNrOfInstances", "150dctAllFtPointProfile",
"151dctAllFtAirspaceNrOfInstances", "152dctAllFtAirspaceProfile",
"153dctAllFtCircleIntersectionsNrOfInstances", "154dctAllFtCircleIntersections",
"155cpfObt", "156cpfConsumedFuel", "157cpfRouteCharges",
"158cpfAllFtPointNrOfInstances", "159cpfAllFtPointProfile",
"160cpfAllFtAirspaceNrOfInstances", "161cpfAllFtAirspaceProfile",
"162cpfAllFtCircleIntersectionsNrOfInstances", "163cpfAllFtCircleIntersections",
"164aircraftidIATA", "165intentionFlight",
"166intentionRelatedRouteAssignmentMethod", "167intentionUID",
"168intentionEditionDate", "169intentionSource", "170associatedIntentions",
"171enrichmentOutput", "172eventID", "173eventTime", "174flightVersionNr",
"175ftfmNrTvProfiles", "176ftfmTvProfile", "177rtfmNrTvProfiles",
"178rtfmTvProfile", "179ctfmNrTvProfiles", "180ctfmTvProfile"]

struct Point
    lat_deg::Float64
    lon_deg::Float64
end

struct PointProfile
    datetime::DateTime
    geoPointId::String
    FL::Int64
    Position::Point
end

const yymmdd = DateFormat("YYmmdd")
const hhmmss = DateFormat("HHMMSS")
const mmmmss = DateFormat("MMMMSS")
const yyyymmddhhmmss = DateFormat("YYYYmmddHHMMSS")
const year2000 = Year(2000)

function read(file)
    df = CSV.read(file, delim=";", types=fileformat, header=header_format,
    copycols=true, datarow=2)
    # remove_unused!(df)
    reformat!(df)
    return df
end

function reformat!(df)
    #Date conversion
    df[:,:TEMP] = format_datetime.(df[:,:aobt_5], yyyymmddhhmmss)
    select!(df, Not(:aobt_5))
    df[:,:aobt_5] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_datetime.(df[:,:iobt_7], yyyymmddhhmmss)
    select!(df, Not(:iobt_7))
    df[:,:iobt_7] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_datetime.(df[:,:cobt_16], yyyymmddhhmmss)
    select!(df, Not(:cobt_16))
    df[:,:cobt_16] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_datetime.(df[:,:eobt_17], yyyymmddhhmmss)
    select!(df, Not(:eobt_17))
    df[:,:eobt_17] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_datetime.(df[:,:lobt_18], yyyymmddhhmmss)
    select!(df, Not(:lobt_18))
    df[:,:lobt_18] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_datetime.(df[:,:samCtot_23], yyyymmddhhmmss)
    select!(df, Not(:samCtot_23))
    df[:,:samCtot_23] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_datetime.(df[:,:sipCtot_25], yyyymmddhhmmss)
    select!(df, Not(:sipCtot_25))
    df[:,:sipCtot_25] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_datetime.(df[:,:lastSentSlotMessage_45], yyyymmddhhmmss)
    select!(df, Not(:lastSentSlotMessage_45))
    df[:,:lastSentSlotMessage_45] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_datetime.(df[:,:lastSentProposalMessage_46], yyyymmddhhmmss)
    select!(df, Not(:lastSentProposalMessage_46))
    df[:,:lastSentProposalMessage_46] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_datetime.(df[:,:cdmEarlyTtot_61], yyyymmddhhmmss)
    select!(df, Not(:cdmEarlyTtot_61))
    df[:,:cdmEarlyTtot_61] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_datetime.(df[:,:cdmAoTtot_62], yyyymmddhhmmss)
    select!(df, Not(:cdmAoTtot_62))
    df[:,:cdmAoTtot_62] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_datetime.(df[:,:cdmAtcTtot_63], yyyymmddhhmmss)
    select!(df, Not(:cdmAtcTtot_63))
    df[:,:cdmAtcTtot_63] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_datetime.(df[:,:cdmSequencedTtot_64], yyyymmddhhmmss)
    select!(df, Not(:cdmSequencedTtot_64))
    df[:,:cdmSequencedTtot_64] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_datetime.(df[:,:cdmTaxiTime_65], mmmmss)
    select!(df, Not(:cdmTaxiTime_65))
    df[:,:cdmTaxiTime_65] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_datetime.(df[:,:cdmNoSlotBefore_70], yyyymmddhhmmss)
    select!(df, Not(:cdmNoSlotBefore_70))
    df[:,:cdmNoSlotBefore_70] =  df[:,:TEMP]
    select!(df, Not(:TEMP))
    # df[:,:TIMEBEGINSEGMENT] = format_time.(df[:,:TIMEBEGINSEGMENT], hhmmss)
    # df[:,:TIMEENDSEGMENT] = format_time.(df[:,:TIMEENDSEGMENT], hhmmss)
    # df[:,:DATEBEGINSEGMENT] = format_date.(df[:,:DATEBEGINSEGMENT], yymmdd,
    # addyear=year2000)
    # df[:,:DATEENDSEGMENT] = format_date.(df[:,:DATEENDSEGMENT], yymmdd,
    # addyear=year2000)
    # df[:,:LATBEGINSEGMENT_DEG] = df[:,:LATBEGINSEGMENT_DEG] / 60.0
    # df[:,:LONBEGINSEGMENT_DEG] = df[:,:LONBEGINSEGMENT_DEG] / 60.0
    # df[:,:LATENDSEGMENT_DEG] = df[:,:LATENDSEGMENT_DEG] / 60.0
    # df[:,:LONENDSEGMENT_DEG] = df[:,:LONENDSEGMENT_DEG] / 60.0
    # df[:,:SEGMENT_LENGTH_M] = df[:,:SEGMENT_LENGTH_M] * 1852.0
end

# function remove_unused!(df)
#     DataFrames.select!(df, [1,2,3,4,23,
#     79, 80, 81, 82, 83, 84, 85, 86, 87, 88,
#     93, 94, 95, 96, 97, 98, 99, 100, 101, 102,
#     107, 108, 109, 110, 111, 112, 113, 114, 115, 116,
#     165])
# end

function latlonformat(latlon)

end

# function pointdata(pointdata)
#     for i, element in split(pointdata)
#         if i == 1
#             dt = format_datetime(element, yyyymmddhhmmss)
#         elseif i == 2
#             geopoint = element
#         elseif i == 4
#             fl = Int64(element)
#         elseif i == 7
#             pt = Point()
#         end
#     end
#     return PointProfile(dt, geopoint, fl, pt)
# end
#
# function pointprofile(profile)
#     pp = PointProfile[]
#     for pointdata in split(profile, " ")
#         pd = pointdata(pointdata)
#         push!(pp, PointProfile())
#     end
# end

end # module
