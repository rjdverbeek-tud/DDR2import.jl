"""
EXP2 fileformat
See EUROCONTROL NEST Manual for EXP2 fileformat description
"""
module Exp2

export read

using Format
using CSV
using Dates

const exp2_fileformat = Dict(1=>String, 2=>String, 3=>String, 4=>String,
5=>Int64, 6=>String, 7=>String, 8=>Int64, 9=>String, 10=>String, 11=>String,
12=>String, 13=>String, 14=>Int64, 15=>String, 16=>String, 17=>Int64,
18=>Int64, 19=>Int64, 20=>Int64, 21=>String, 22=>String, 23=>String,
24=>String, 25=>Int64, 26=>String, 27=>String, 28=>String, 29=>String,
30=>String, 31=>String, 32=>String, 33=>String, 34=>String, 35=>Int64,
36=>Int64, 37=>Int64, 38=>String, 39=>Int64, 40=>String, 41=>String, 42=>String,
43=>String, 44=>String, 45=>String, 46=>String, 47=>String, 48=>String,
49=>String, 50=>String, 51=>String, 52=>String, 53=>String, 54=>String, 55=>String,
56=>Int64, 57=>String, 58=>String, 59=>String, 60=>String, 61=>String, 62=>String,
63=>Int64, 64=>Int64, 65=>String, 66=>String, 67=>String, 68=>String, 69=>String,
70=>String, 71=>String, 72=>Int64, 73=>Int64, 74=>Int64, 75=>String, 76=>String,
77=>String, 78=>String, 79=>String, 80=>String, 81=>String, 82=>Int64, 83=>Int64,
84=>String, 85=>String, 86=>String, 87=>Int64, 88=>Int64, 89=>Int64, 90=>Int64,
91=>Int64, 92=>Int64, 93=>Int64, 94=>String, 95=>Int64)

const header_format = ["ADEP", "ADES", "NOT_USED1", "ACTYPE", "RFL",
"ZONE_ORIG", "ZONE_DEST", "FLIGHT_ID", "DEP_DATE", "DEP_TIME",
"ARR_TIME", "CALLSIGN", "COMPANY", "SEPARATOR1", "UUID",
"FIPS_CLONED", "SEPARATOR2", "FLIGHT_SAAM_ID", "FLIGHT_SAMAD_ID", "TACT_ID",
"SSR_CODE", "REGISTRATION", "PLAN_DEP_DATE", "PLAN_DEP_TIME", "ATFM_DELAY",
"REROUTING_STATE", "MOST_PEN_REG", "TYPE_OF_FLIGHT", "EQUIPMENT", "ICAO_EQUIP",
"COM_EQUIP", "NAV_EQUIP", "SSR_EQUIP", "SURVIVAL_EQUIP", "PERSONS_ON_BOARD",
"TOP_FL", "MAX_RFL", "FLT_PLN_SOURCE", "SEPARATOR3", "AOBT",
"IFPSID", "IOBT", "ORIGFLIGHTDATAQUALITY", "FLIGHTDATAQUALITY", "SOURCE",
"EXEMPTREASON", "EXEMPTREASONDIST", "LATEFILER", "LATEUPDATER", "NORTHATLANTIC",
"COBT", "EOBT", "FLIGHTSTATE", "PREV2ACTIVATIONFLIGHTSTATE", "SUSPENSIONSTATUS",
"TACT_ID_DUPLICATE", "SAMCTOT", "SAMSENT", "SIPCTOT", "SIPSENT",
"SLOTFORCED", "MOSTPENALIZINGREGID", "REGAFFECTEDBYNROFINST", "EXCLFROMNROFINST",
"LASTRECEIVEDATFMMESSAGETITLE",
"LASTRECEIVEDMESSAGETITLE", "LASTSENTATFMMESSAGETITLE", "MANUALEXEMPREASON",
"SENSITIVEFLIGHT", "READYFORIMPROVEMENT",
"READYFORDEP", "REVISEDTAXITIME", "TIS", "TRS", "TOBESENTSLOTMESSAGE",
"TOBESENTPROPMESSAGETITLE", "LASTSENTSLOTMESSAGETITLE",
"LASTSENTPROPMESSAGETITLE", "LASTSENTSLOTMESSAGE", "LASTSENTPROPMESSAGE",
"FLIGHTCOUNTOPTION", "NORMALFLIGHTTACT_ID", "PROPFLIGHTTACT_ID",
"OPERATINGACOPERICAOID", "REROUTINGWHY",
"REROUTINGLFIGHTSTATE", "RVR", "FTFMAIRAC", "FTFMENVBASELINENUM", "RTFMAIRAC",
"RTFMENVBASELINENUM", "CTFMAIRAC", "CTFMENVBASELINENUM",
"LASTRECEIVEDPROGRESSMESSAGE", "SEPARATOR4"]

const yymmdd = DateFormat("YYmmdd")
const hhmm = DateFormat("HHMM")
const yyyymmddhhmmss = DateFormat("YYYYmmddHHMMSS")
const year2000 = Year(2000)

function read(file)
    df = CSV.read(file, delim=";", types=exp2_fileformat, header=header_format,
    copycols=true)
    reformat!(df);
    return df
end

function reformat!(df)
    #Date conversion
    df[:,:DEP_DATE] = format_date.(df[:,:DEP_DATE], yymmdd, addyear=year2000)
    df[:,:DEP_TIME] = format_time.(df[:,:DEP_TIME], hhmm)
    df[:,:PLAN_DEP_DATE] = format_date.(df[:,:PLAN_DEP_DATE], yymmdd,
    addyear=year2000)
    df[:,:PLAN_DEP_TIME] = format_time.(df[:,:PLAN_DEP_TIME], hhmm)
    df[:,:AOBT] = format_datetime.(df[:,:AOBT], yyyymmddhhmmss)
    df[:,:IOBT] = format_datetime.(df[:,:IOBT], yyyymmddhhmmss)
    df[:,:COBT] = format_datetime.(df[:,:COBT], yyyymmddhhmmss)
    df[:,:EOBT] = format_datetime.(df[:,:EOBT], yyyymmddhhmmss)
    df[:,:SAMCTOT] = format_datetime.(df[:,:SAMCTOT], yyyymmddhhmmss)
    df[:,:SIPCTOT] = format_datetime.(df[:,:SIPCTOT], yyyymmddhhmmss)
    df[:,:LASTSENTSLOTMESSAGE] = format_datetime.(df[:,:LASTSENTSLOTMESSAGE],
    yyyymmddhhmmss)
    df[:,:LASTSENTPROPMESSAGE] = format_datetime.(df[:,:LASTSENTPROPMESSAGE],
    yyyymmddhhmmss)
end

end # module
