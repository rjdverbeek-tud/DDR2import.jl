"""
ALL_FT+ fileformat

Defines a list of flight trajectories (planned/actual/etc) for a given day

See EUROCONTROL NEST Manual Section 9.7.5 for ALL_FT+ fileformat description

The headers of the DataFrame follow the naming convention from the EUROCONTROL
NEST Manual + '_' + index_number from manual.
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
49=>Int64, 50=>Int64, 51=>String, 52=>String, 53=>String, 54=>Int64,
55=>Int64, 56=>String, 57=>String, 58=>String, 59=>String, 60=>String,
61=>String, 62=>String, 63=>String, 64=>String, 65=>String, 66=>String,
67=>String, 68=>String, 69=>String, 70=>String, 71=>String, 72=>String,
73=>Int64, 74=>String, 75=>Int64, 76=>String, 77=>Int64, 78=>Int64,
79=>String, 80=>String, 81=>Int64, 82=>String, 83=>Float64, 84=>Float64,
85=>Int64, 86=>String, 87=>Int64, 88=>String, 89=>Int64, 90=>String,
91=>Int64, 92=>Int64, 93=>String, 94=>String, 95=>Int64, 96=>String,
97=>Float64, 98=>Float64, 99=>Int64, 100=>String, 101=>Int64, 102=>String,
103=>Int64, 104=>String, 105=>Int64, 106=>Int64, 107=>String, 108=>String,
109=>Int64, 110=>String, 111=>Float64, 112=>Float64, 113=>Int64, 114=>String,
115=>Int64, 116=>String, 117=>Int64, 118=>String, 119=>String, 120=>String,
121=>Float64, 122=>Float64, 123=>Int64, 124=>String, 125=>Int64, 126=>String,
127=>Int64, 128=>String, 129=>String, 130=>Float64, 131=>Float64, 132=>Int64,
133=>String, 134=>Int64, 135=>String, 136=>Int64, 137=>String, 138=>String,
139=>Float64, 140=>Float64, 141=>Int64, 142=>String, 143=>Int64, 144=>String,
145=>Int64, 146=>String, 147=>String, 148=>Float64, 149=>Float64, 150=>Int64,
151=>String, 152=>Int64, 153=>String, 154=>Int64, 155=>String, 156=>String,
157=>Float64, 158=>Float64, 159=>Int64, 160=>String, 161=>Int64, 162=>String,
163=>Int64, 164=>String, 165=>String, 166=>String, 167=>String, 168=>Int64,
169=>String, 170=>String, 171=>String, 172=>String, 173=>String, 174=>String,
175=>Int64, 176=>Int64, 177=>String, 178=>Int64, 179=>String, 180=>Int64,
181=>String)

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
"ftfmConsumedFuel_82", "ftfmRouteCharges_83", "ftfmAllFtPointNrOfInstances_84",
"ftfmAllFtPointProfile_85", "ftfmAllFtAirspaceNrOfInstances_86",
"ftfmAllFtAirspaceProfile_87", "ftfmAllFtCircleIntersectionsNrOfInstances_88",
"ftfmAllFtCircleIntersections_89", "rtfmAiracCycleReleaseNumber_90",
"rtfmEnvBaselineNumber_91", "rtfmDepartureRunway_92", "rtfmArrivalRunway_93",
"rtfmReqFlightlevelSpeedNrOfInstances_94", "rtfmReqFlightlevelSpeedList_95",
"rtfmConsumedFuel_96", "rtfmRouteCharges_97", "rtfmAllFtPointNrOfInstances_98",
"rtfmAllFtPointProfile_99", "rtfmAllFtAirspaceNrOfInstances_100",
"rtfmAllFtAirspaceProfile_101", "rtfmAllFtCircleIntersectionsNrOfInstances_102",
"rtfmAllFtCircleIntersections_103", "ctfmAiracCycleReleaseNumber_104",
"ctfmEnvBaselineNumber_105", "ctfmDepartureRunway_106", "ctfmArrivalRunway_107",
"ctfmReqFlightlevelSpeedNrOfInstances_108", "ctfmReqFlightlevelSpeedList_109",
"ctfmConsumedFuel_110", "ctfmRouteCharges_111", "ctfmAllFtPointNrOfInstances_112",
"ctfmAllFtPointProfile_113", "ctfmAllFtAirspaceNrOfInstances_114",
"ctfmAllFtAirspaceProfile_115", "ctfmAllFtCircleIntersectionsNrOfInstances_116",
"ctfmAllFtCircleIntersections_117", "noCPGCPFReason_118", "scrObt_119",
"scrConsumedFuel_120", "scrRouteCharges_121", "scrAllFtPointNrOfInstances_122",
"scrAllFtPointProfile_123", "scrAllFtAirspaceNrOfInstances_124",
"scrAllFtAirspaceProfile_125", "scrAllFtCircleIntersectionsNrOfInstances_126",
"scrAllFtCircleIntersections_127", "srrObt_128", "srrConsumedFuel_129",
"srrRouteCharges_130", "srrAllFtPointNrOfInstances_131", "srrAllFtPointProfile_132",
"srrAllFtAirspaceNrOfInstances_133", "srrAllFtAirspaceProfile_134",
"srrAllFtCircleIntersectionsNrOfInstances_135", "srrAllFtCircleIntersections_136",
"surObt_137", "surConsumedFuel_138", "surRouteCharges_139",
"surAllFtPointNrOfInstances_140", "surAllFtPointProfile_141",
"surAllFtAirspaceNrOfInstances_142", "surAllFtAirspaceProfile_143",
"surAllFtCircleIntersectionsNrOfInstances_144", "surAllFtCircleIntersections_145",
"dctObt_146", "dctConsumedFuel_147", "dctRouteCharges_148",
"dctAllFtPointNrOfInstances_149", "dctAllFtPointProfile_150",
"dctAllFtAirspaceNrOfInstances_151", "dctAllFtAirspaceProfile_152",
"dctAllFtCircleIntersectionsNrOfInstances_153", "dctAllFtCircleIntersections_154",
"cpfObt_155", "cpfConsumedFuel_156", "cpfRouteCharges_157",
"cpfAllFtPointNrOfInstances_158", "cpfAllFtPointProfile_159",
"cpfAllFtAirspaceNrOfInstances_160", "cpfAllFtAirspaceProfile_161",
"cpfAllFtCircleIntersectionsNrOfInstances_162", "cpfAllFtCircleIntersections_163",
"aircraftidIATA_164", "intentionFlight_165",
"intentionRelatedRouteAssignmentMethod_166", "intentionUID_167",
"intentionEditionDate_168", "intentionSource_169", "associatedIntentions_170",
"enrichmentOutput_171", "eventID_172", "eventTime_173", "flightVersionNr_174",
"ftfmNrTvProfiles_175", "ftfmTvProfile_176", "rtfmNrTvProfiles_177",
"rtfmTvProfile_178", "ctfmNrTvProfiles_179", "ctfmTvProfile_180"]

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

struct FlightlevelSpeed
    FL::Int64
    Spd::String
    Value::Int64
    function FlightlevelSpeed(x::AbstractString)
        flspdvalue = split(x, ':')
        FL = parse(Int64, flspdvalue[1][2:end])
        Spd = flspdvalue[2]
        Value = parse(Int64, flspdvalue[3])
        new(FL, Spd, Value)
    end
end

function reqFlightlevelSpeedList(items::Union{AbstractString, Missing})
    if items === missing
        return missing
    else
        return [FlightlevelSpeed(item) for item in split(items)]
    end
end

struct AllFtPointProfile
    datetime::Union{DateTime, Missing}
    point::AbstractString
    route::AbstractString
    FL::Union{Int64, Missing}
    pointDistance::Union{Int64, Missing}
    pointType::AbstractString
    geoPointId::Union{Point, AbstractString}
    ratio::Union{Int64, Missing}
    isVisible::Bool  # Y indicated IFR/GAT/IFPSTART, N indicates VFR/OAT/IFPSTOP/STAY
    function AllFtPointProfile(x::AbstractString)
        items = split(x, ':')
        datetime = items[1] == "" ? missing : format_datetime(items[1], yyyymmddhhmmss)
        point = items[2]
        route = items[3]
        FL = items[4] == "" ? missing : parse(Int64, items[4])
        pointDistance = items[5] == "" ? missing : parse(Int64, items[5])
        pointType = items[6]
        geoPointId = occursin(r"\d{6}[NS]\d{7}[EW]", items[7]) ? latlon(items[7]) : items[7]
        ratio = items[8] == "" ? missing : parse(Int64, items[8])
        isVisible = items[9] == "Y" ? true : false
        new(datetime, point, route, FL, pointDistance, pointType, geoPointId,
        ratio, isVisible)
    end
end

function latlon(str::AbstractString)
    lat_h = parse(Float64, str[1:2])
    lat_m = parse(Float64, str[3:4])
    lat_s = parse(Float64, str[5:6])
    sign_lat = str[7] == 'N' ? 1 : -1
    lon_h = parse(Float64, str[8:10])
    lon_m = parse(Float64, str[11:12])
    lon_s = parse(Float64, str[13:14])
    sign_lon = str[15] == 'E' ? 1 : -1
    return Point(sign_lat*(lat_h + lat_m/60.0 + lat_s/3600.0),
    sign_lon*(lon_h + lon_m/60.0 + lon_s/3600.0))
end

function AllFtPointProfileList(items::Union{AbstractString, Missing})
    if items === missing
        return missing
    else
        return [AllFtPointProfile(item) for item in split(items)]
    end
end

struct AllFtAirspaceProfile
    entry_datetime::Union{DateTime, Missing}
    sector::AbstractString
    exit_datetime::Union{DateTime, Missing}
    fir::AbstractString
    entry_geoPointId::Union{Point, AbstractString}
    exit_geoPointId::Union{Point, AbstractString}
    entry_FL::Union{Int64, Missing}
    exit_FL::Union{Int64, Missing}
    entry_pointDistance::Union{Int64, Missing}
    exit_pointDistance::Union{Int64, Missing}
    function AllFtAirspaceProfile(x::AbstractString)
        items = split(x, ':')
        entry_datetime = items[1] == "" ? missing : format_datetime(items[1], yyyymmddhhmmss)
        sector = items[2]
        exit_datetime = items[3] == "" ? missing : format_datetime(items[3], yyyymmddhhmmss)
        fir = items[4]
        entry_geoPointId = occursin(r"\d{6}[NS]\d{7}[EW]", items[5]) ? latlon(items[5]) : items[5]
        exit_geoPointId = occursin(r"\d{6}[NS]\d{7}[EW]", items[6]) ? latlon(items[6]) : items[6]
        entry_FL = items[7] == "" ? missing : parse(Int64, items[7])
        exit_FL = items[8] == "" ? missing : parse(Int64, items[8])
        entry_pointDistance = items[9] == "" ? missing : parse(Int64, items[9])
        exit_pointDistance = items[10] == "" ? missing : parse(Int64, items[10])
        new(entry_datetime, sector, exit_datetime, fir, entry_geoPointId,
        exit_geoPointId, entry_FL, exit_FL, entry_pointDistance,
        exit_pointDistance)
    end
end

function AllFtAirspaceProfileList(items::Union{AbstractString, Missing})
    if items === missing
        return missing
    else
        return [AllFtAirspaceProfile(item) for item in split(items)]
    end
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

    df[:,:TEMP] = format_time.(df[:,:cdmTaxiTime_65], mmmmss)
    select!(df, Not(:cdmTaxiTime_65))
    df[:,:cdmTaxiTime_65] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_datetime.(df[:,:cdmNoSlotBefore_70], yyyymmddhhmmss)
    select!(df, Not(:cdmNoSlotBefore_70))
    df[:,:cdmNoSlotBefore_70] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_datetime.(df[:,:scrObt_119], yyyymmddhhmmss)
    select!(df, Not(:scrObt_119))
    df[:,:scrObt_119] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_datetime.(df[:,:srrObt_128], yyyymmddhhmmss)
    select!(df, Not(:srrObt_128))
    df[:,:srrObt_128] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_datetime.(df[:,:surObt_137], yyyymmddhhmmss)
    select!(df, Not(:surObt_137))
    df[:,:surObt_137] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_datetime.(df[:,:dctObt_146], yyyymmddhhmmss)
    select!(df, Not(:dctObt_146))
    df[:,:dctObt_146] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_datetime.(df[:,:eventTime_173], yyyymmddhhmmss)
    select!(df, Not(:eventTime_173))
    df[:,:eventTime_173] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

end

end # module
