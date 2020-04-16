"""
EXP2 fileformat

See EUROCONTROL NEST Manual for EXP2 fileformat description

Exp2 DataFrame Column Names
#   CellName        Field           Type    Comment
1   :ADEP           origin          String  ICAO code (airport)
2   :ADES           destination     String  ICAO code (airport)
4   :ACTYPE                         String
5   :RFL            RFL             Int64   Requested Flight Level
6   :ZONE_ORIG      zone origin     String  ICAO code (could be the same as airport)
7   :ZONE_DEST      zone destin     String  ICAO code (could be the same as airport)
8   :FLIGHT_ID      flight ID       Int64   SAMAD ID or SAAM ID or ... (must be unique)
9   :ETD_DATETIME                   DateTime Estimated Time and Date of Departure
11  :ETA_DATETIME                   DateTime Estimated Time and Date of Arrival (Not used = !!!!)
12  :CALLSIGN                       String  Char <= 7
13  :COMPANY                        String  Generally the 3 first letters of the callsign
15  :UUID       Universal Unique ID String  CALLSIGN-ADEP-ADES-EOBD-EOBT
16  :FIPS_CLONED    Fips cloned     String  Y/N
18  :FLIGHT_SAAM_ID Flight SAAM ID  Int64   Unique for the day
19  :FLIGHT_SAMAD_ID Flight SAMAD ID Int64  Unique for ever
20  :TACT_ID                        Int64   CFMU ID: Check with TACTID on ALL-FT
21  :SSR_CODE                       String  plan identifiant (12bits mode A), Secondary Surveillance Rader
22  :REGISTRATION                   String
23  :PTD_DATETIME                   DateTime Planned Date and Time Departure
25  :ATFM_DELAY                     Air Traffic Flow Management Delay: Difference between calculated by CASA take off time (CTOT) and estimated take off time (ETOT)
26  :REROUTING_STATE                String
27  :MOST_PEN_REG                   String  Most penelizing regulation. If no regulation 'X' is present: Check with mostPenalizingRegulationID
28  :TYPE_OF_FLIGHT                 String  Letters indicating type of flight (military ?)
29  :EQUIPMENT                      String  Letters indicating equipment of flight
30  :ICAO_EQUIP                     String
31  :COM_EQUIP                      String
32  :NAV_EQUIP                      String
33  :SSR_EQUIP                      String  Secondary Surveillance Radar equipment
34  :SURVIVAL_EQUIP                 String
35  :PERSONS_ON_BOARD               Int64   0 means no information
36  :TOP_FL                         Int64
37  :MAX_RFL                        Int64   Requested Flight Level
38  :FLT_PLN_SOURCE                 String
40  :AOBT                           DateTime Actual Of Block in Time
41  :IFPSID                         String  Prisme (Integrated Initial Flight Plan Processing System)
42  :IOBT                           DateTime Initial Of Block in Time | FLF (planned time departure)
43  :ORIGFLIGHTDATAQUALITY          String  NON, PFD, RPL, FPL
44  :FLIGHTDATAQUALITY              String  FLF (flt plan source), NON, PFD, RPL, FPL
45  :SOURCE                         String  UNK, FPL, RPL, AFI, MFS, FNM, AFP, DIV
46  :EXEMPTREASON                   String  NEXE, EMER, SERE, HEAD, AEAP, empty
47  :EXEMPTREASONDIST               String  NEXE, LONG, empty .Note in NEST the flight exemption is
                                            limited to exempted or not exempted states. Not exempted
                                            corresponds to NEXT in fields 46 and 47. All other values
                                            correspon to exempted. During export, NEST writes empty
                                            fields in 46 and 47 for exempted flights.
48  :LATEFILER                      String  Y/N
49  :LATEUPDATER                    String  Y/N
50  :NORTHATLANTIC                  String  Y/N
51  :COBT                           DateTime Computed Of Block in Time
52  :EOBT                           DateTime Estimate Of Block in Time
53  :FLIGHTSTATE                    String  NE, PL, PS, PR, SR, FI, FS, SI, TA, AA, CA, TE
54  :PREV2ACTIVATIONFLIGHTSTATE     String  NE, PL, PS, PR, SR, FI, FS, SI, TA, AA, CA, TE
55  :SUSPENSIONSTATUS               String  NS, ST, SM, RC, TV, NR, RV
57  :SAMCTOT                        DateTime
58  :SAMSENT                        String  Y/N
59  :SIPCTOT                        DateTime
60  :SIPSENT                        String  Y/N
61  :SLOTFORCED                     String  Y/N
62  :MOSTPENALIZINGREGID            String  Is it the same as most pen reg on FLF
63  :REGAFFECTEDBYNROFINST          Int64
64  :EXCLFROMNROFINST               Int64
65  :LASTRECEIVEDATFMMESSAGETITLE   String  DES, ERR, FCM, FUM, FLS, REA, RFI, RJT, RRN, RRP, SAM, SIP, SLC, SMM, SPA, SRJ, SRM, SWM, UNK
66  :LASTRECEIVEDMESSAGETITLE       String  ABI, ACH, ACT, APL, ARR, CAN, CHG, CNL, DEP, DLA, ERR, EST, FPL, FSA, MFS, PAC, PFD, RPL, UNK
67  :LASTSENTATFMMESSAGETITLE       String  DES, ERR, FCM, FUM, FLS, REA, RFI, RJT, RRN, RRP, SAM, SIP, SLC, SMM, SPA, SRJ, SRM, SWM, UNK
68  :MANUALEXEMPREASON              String  N/S/R
69  :SENSITIVEFLIGHT                String  Y/N
70  :READYFORIMPROVEMENT            String  Y/N
71  :READYFORDEP                    String  Y/N
72  :REVISEDTAXITIME                Int64   0..999999
73  :TIS                            Int64   Time to intert the sequence, 0..999999
74  :TRS                            Int64   Time to remove the sequence, 0..999999
75  :TOBESENTSLOTMESSAGE            String  Related to flight progress, ABI, ACH, ACT, APL, ARR, CAN, CHG, CNL, DEP, DLA, ERR, EST, FPL, FSA, MFS, PAC, PFD, RPL, UNK
76  :TOBESENTPROPMESSAGETITLE       String  Related to flight progress, ABI, ACH, ACT, APL, ARR, CAN, CHG, CNL, DEP, DLA, ERR, EST, FPL, FSA, MFS, PAC, PFD, RPL, UNK
77  :LASTSENTSLOTMESSAGETITLE       String  Related to flight progress, ABI, ACH, ACT, APL, ARR, CAN, CHG, CNL, DEP, DLA, ERR, EST, FPL, FSA, MFS, PAC, PFD, RPL, UNK
78  :LASTSENTPROPMESSAGETITLE       String  Related to flight progress, ABI, ACH, ACT, APL, ARR, CAN, CHG, CNL, DEP, DLA, ERR, EST, FPL, FSA, MFS, PAC, PFD, RPL, UNK
79  :LASTSENTSLOTMESSAGE            DateTime Related to flight progress
80  :LASTSENTPROPMESSAGE            DateTime Related to flight progress
81  :FLIGHTCOUNTOPTION              String  Indicates which flight plan should be / has been ussed when doing flight/count related operations. Used in TACT queries and replies P,N
82  :NORMALFLIGHTTACT_ID            Int64
83  :PROPFLIGHTTACT_ID              Int64
84  :OPERATINGACOPERICAOID          String
85  :REROUTINGWHY                   String  N/M/C/A/O
86  :REROUTINGLFIGHTSTATE           String  P/E/T/R/V/N
87  :RVR                            Int64
88  :FTFMAIRAC                      Int64   Filed traffic flight model (TFM=Profile) airac..
89  :FTFMENVBASELINENUM             Int64   Filed traffic flight model (TFM=Profile) env..
90  :RTFMAIRAC                      Int64   Regulated traffic flight model (TFM=Profile) airac..
91  :RTFMENVBASELINENUM             Int64   Regulated traffic flight model (TFM=Profile) env..
92  :CTFMAIRAC                      Int64   Computer traffic flight model (TFM=Profile) airac..
93  :CTFMENVBASELINENUM             Int64   Computer traffic flight model (TFM=Profile) env..
94  :LASTRECEIVEDPROGRESSMESSAGE    String  DPI, EMPTY, SIZE
"""
module Exp2

export read

#TODO Keep unused fields?
using ..util  # new
using Format
using CSV
using Dates
using DataFrames

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
const yymmddhhmm = DateFormat("YYmmddHHMM")
const year2000 = Year(2000)

function read(file)
    df = CSV.read(file, delim=";", types=exp2_fileformat, header=header_format,
    copycols=true)
    reformat!(df);
    return df
end

function eta_datetime(eta_time::String, etd_datetime::DateTime)
    eta_time_type = format_time(eta_time, hhmm)
    eta_datetime = ""

    if eta_time_type === missing
        return missing
    else
        eta_datetime = Date(etd_datetime) + eta_time_type
    end

    if eta_datetime === missing
        return missing
    elseif eta_datetime < etd_datetime
        return eta_datetime + Dates.Day(1)
    else
        eta_datetime
    end
end

function reformat_exp!(df)
    df[:,:ETD_DATETIME] = format_datetime.(df[:,:DEP_DATE] .*
    df[:,:DEP_TIME], yymmddhhmm, addyear=year2000)

    df[:,:ETA_DATETIME] = eta_datetime.(df[:,:ARR_TIME], df[:,:ETD_DATETIME])
end

function reformat_flf!(df)
    df[:,:PTD_DATETIME] = format_datetime.(df[:,:PLAN_DEP_DATE] .*
    df[:,:PLAN_DEP_TIME], yymmddhhmm, addyear=year2000)
end

function reformat_allft!(df)
    df[:,:TEMP] = format_datetime.(df[:,:AOBT], yyyymmddhhmmss)
    select!(df, Not(:AOBT))
    df[:,:AOBT] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_datetime.(df[:,:IOBT], yyyymmddhhmmss)
    select!(df, Not(:IOBT))
    df[:,:IOBT] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_datetime.(df[:,:COBT], yyyymmddhhmmss)
    select!(df, Not(:COBT))
    df[:,:COBT] =  df[:,:TEMP]
    select!(df, Not(:TEMP))

    df[:,:TEMP] = format_datetime.(df[:,:EOBT], yyyymmddhhmmss)
    select!(df, Not(:EOBT))
    df[:,:EOBT] =  df[:,:TEMP]
    select!(df, Not(:TEMP))
end

function remove_unused!(df)
    select!(df,[:ADEP, :ADES, :ACTYPE, :RFL, :ZONE_ORIG, :ZONE_DEST,
    :FLIGHT_ID, :ETD_DATETIME, :ETA_DATETIME, :CALLSIGN, :COMPANY, :UUID,
    :FIPS_CLONED, :FLIGHT_SAAM_ID, :FLIGHT_SAMAD_ID, :TACT_ID, :SSR_CODE,
    :REGISTRATION, :PTD_DATETIME, :ATFM_DELAY, :REROUTING_STATE, :MOST_PEN_REG,
    :TYPE_OF_FLIGHT, :EQUIPMENT, :ICAO_EQUIP, :COM_EQUIP, :NAV_EQUIP,
    :SSR_EQUIP, :SURVIVAL_EQUIP, :PERSONS_ON_BOARD, :TOP_FL, :MAX_RFL,
    :FLT_PLN_SOURCE, :AOBT, :IFPSID, :IOBT, :ORIGFLIGHTDATAQUALITY,
    :FLIGHTDATAQUALITY, :SOURCE, :EXEMPTREASON, :EXEMPTREASONDIST, :LATEFILER,
    :LATEUPDATER, :NORTHATLANTIC, :COBT, :EOBT, :FLIGHTSTATE,
    :PREV2ACTIVATIONFLIGHTSTATE, :SUSPENSIONSTATUS, :SAMCTOT, :SAMSENT,
    :SIPCTOT, :SIPSENT, :SLOTFORCED, :MOSTPENALIZINGREGID,
    :REGAFFECTEDBYNROFINST, :EXCLFROMNROFINST, :LASTRECEIVEDATFMMESSAGETITLE,
    :LASTRECEIVEDMESSAGETITLE, :LASTSENTATFMMESSAGETITLE, :MANUALEXEMPREASON,
    :SENSITIVEFLIGHT, :READYFORIMPROVEMENT, :READYFORDEP, :REVISEDTAXITIME,
    :TIS, :TRS, :TOBESENTSLOTMESSAGE, :TOBESENTPROPMESSAGETITLE,
    :LASTSENTSLOTMESSAGETITLE, :LASTSENTPROPMESSAGETITLE, :LASTSENTSLOTMESSAGE,
    :LASTSENTPROPMESSAGE, :FLIGHTCOUNTOPTION, :NORMALFLIGHTTACT_ID,
    :PROPFLIGHTTACT_ID, :OPERATINGACOPERICAOID, :REROUTINGWHY,
    :REROUTINGLFIGHTSTATE, :RVR, :FTFMAIRAC, :FTFMENVBASELINENUM, :RTFMAIRAC,
    :RTFMENVBASELINENUM, :CTFMAIRAC, :CTFMENVBASELINENUM,
    :LASTRECEIVEDPROGRESSMESSAGE])
end

function reformat!(df)
    reformat_exp!(df)
    reformat_flf!(df)
    reformat_allft!(df)
    remove_unused!(df)
end




end # module
