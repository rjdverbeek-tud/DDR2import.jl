using Dates

@testset "Allftplus.jl" begin
    filename = "data\\test1.ALL_FT+"
    filename2 = "data\\test2.ALL_FT+"
    df = DDR2import.Allftplus.read(filename)
    df2 = DDR2import.Allftplus.read(filename2)
    #EXP
    @test df[2,:departureAerodromeIcaoId_0] == "LFST"
    @test df[2,:arrivalAerodromeIcaoId_1] == "EHAM"
    @test df[2,:aircraftId_2] == "AFR27FK"
    @test df[2,:aircraftOperatorIcaoId_3] == "AFR"
    @test df[2,:aircraftTypeIcaoId_4] == "E145"
    @test Dates.year(df[2,:aobt_5]) == 2017
    @test Dates.minute(df[2,:aobt_5]) == 46
    @test df[2,:ifpsId_6] == "AA70843154"
    @test df[2,:aircraftTypeIcaoId_4] == "E145"
    @test Dates.hour(df2[2,:iobt_7]) == 14
    @test df2[2,:originalFlightDataQuality_8] == "FPL"
    @test df2[2,:flightDataQuality_9] == "FPL"
    @test df[2,:source_10] == "UNK"
    @test df[2,:exemptionReasonType_11] == "NEXE"
    @test df[2,:exemptionReasonDistance_12] == "NEXE"
    @test df2[2,:lateFiler_13] == "N"
    @test df2[2,:lateUpdater_14] == "N"
    @test df2[2,:northAtlanticFlight_15] == "N"
    @test Dates.month(df[2,:cobt_16]) == 12
    @test Dates.hour(df[2,:cobt_16]) == 5
    @test Dates.day(df[2,:eobt_17]) == 15
    @test Dates.minute(df[2,:eobt_17]) == 45
    @test Dates.month(df2[2,:lobt_18]) == 1
    @test df[2,:flightState_19] == "NE"
    @test df[2,:previousToActivationFlightState_20] == "NE"
    @test df[2,:suspensionStatus_21] == "NS"
    @test df[2,:tactId_22] == 512256
    @test Dates.year(df[2,:samCtot_23]) == 2017
    @test df2[2,:samSent_24] == "N"
    @test Dates.day(df[2,:sipCtot_25]) == 15
    @test df2[2,:sipSent_26] == "N"
    @test df2[2,:slotForced_27] == "N"
    @test df[2,:mostPenalizingRegulationId_28] == "EHAMA15M"
    @test df[2,:regulationsAffectedByNrOfInstances_29] == 0
    @test df[2,:excludedFromNrOfInstances_30] == 0
    @test df2[6,:lastReceivedAtfmMessageTitle_31] == "REA"
    @test df2[2,:lastReceivedMessageTitle_32] == "FPL"
    @test df2[6,:lastSentAtfmMessageTitle_33] == "SRM"
    @test df[2,:manualExemptionReason_34] == "N"
    @test df2[2,:sensitiveFlight_35] == "N"
    @test df2[2,:readyForImprovement_36] == "Y"
    @test df2[2,:readyToDepart_37] == "N"
    @test df[2,:revisedTaxiTime_38] == 0
    @test df[2,:tis_39] == 0
    @test df[2,:trs_40] == 0
    @test df[2,:toBeSentSlotMessageTitle_41] === missing
    @test df[2,:toBeSentProposalMessageTitle_42] === missing
    @test df2[3,:lastSentSlotMessageTitle_43] === "SRM"
    @test df[2,:lastSentProposalMessageTitle_44] === missing
    @test Dates.year(df[2,:lastSentSlotMessage_45]) == 2017
    @test Dates.day(df[2,:lastSentSlotMessage_45]) == 15
    @test Dates.month(df[2,:lastSentProposalMessage_46]) == 12
    @test df[2,:flightCountOption_47] == "N"
    @test df2[2,:normalFlightTactId_48] == 0
    @test df2[2,:proposalFlightTactId_49] == 0
    @test df2[2,:operatingAircraftOperatorIcaoId_50] == "RSC"
    @test df2[2,:reroutingWhy_51] == "N"
    @test df[2,:reroutedFlightState_52] === missing
    @test df[2,:runwayVisualRange_53] == 0
    @test df2[2,:numberIgnoredErrors_54] == 0
    @test df2[2,:arcAddrSource_55] == "N"
    @test df2[1,:arcAddr_56] == "A9F2C6"
    @test df2[2,:ifpsRegistrationMark_57] == "ECMIF"
    @test df2[2,:flightType_58] == "S"
    @test df2[2,:aircraftEquipment_59] == "DFGRSY:B2B3B4:EB1"
    @test df2[2,:cdmStatus_60] == "N"
    @test Dates.minute(df2[1,:cdmEarlyTtot_61]) == 8
    @test Dates.hour(df2[1,:cdmAoTtot_62]) == 21
    @test Dates.day(df2[1,:cdmAtcTtot_63]) == 2
    @test Dates.month(df2[1,:cdmSequencedTtot_64]) == 1
    @test Dates.minute(df2[1,:cdmTaxiTime_65]) == 21
    @test df2[2,:cdmOffBlockTimeDiscrepancy_66] == "N"
    @test df2[1,:cdmDepartureProcedureId_67] == "DENUT6C"
    @test df2[1,:cdmAircraftTypeId_68] == "B744"
    @test df2[1,:cdmRegistrationMark_69] == "N740CK"
    @test Dates.minute(df2[1,:cdmNoSlotBefore_70]) == 9
    @test df2[2,:cdmDepartureStatus_71] == "K"
    @test df2[2,:ftfmEetFirNrOfInstances_72] == 0
    @test df2[1,:ftfmEetFirList_73] == "EHAAFIR:10"
    @test df2[2,:ftfmEetPtNrOfInstances_74] == 0
    @test df2[1,:ftfmEetPtList_75] == "55N020W:125 57N030W:170 58N040W:211 58N050W:251 CUDDY:281"
    @test df2[2,:ftfmAiracCycleReleaseNumber_76] == 447
    @test df2[2,:ftfmEnvBaselineNumber_77] == 842
    @test df2[2,:ftfmDepartureRunway_78] == "GCXO30"
    @test df2[2,:ftfmArrivalRunway_79] == "GCHI34"
    @test df[2,:ftfmReqFlightlevelSpeedNrOfInstances_80] == 1
    @test df2[1,:ftfmReqFlightlevelSpeedList_81] == "F320:N0487:0 F340:M084:1383 F360:M084:4022"
    @test df2[2,:ftfmConsumedFuel_82] == 322.0
    @test df2[2,:ftfmRouteCharges_83] == 49.0
    @test df2[2,:ftfmAllFtPointNrOfInstances_84] == 16
    #@test df[2,:ftfmAllFtPointProfile_85]
    @test df2[2,:ftfmAllFtAirspaceNrOfInstances_86] == 10
    #@test df[2,:ftfmAllFtAirspaceProfile_87]
    @test df2[2,:ftfmAllFtCircleIntersectionsNrOfInstances_88] == 2
    #@test df[2,:ftfmAllFtCircleIntersections_89]
    @test df2[3,:rtfmAiracCycleReleaseNumber_90] == 447
    @test df2[3,:rtfmEnvBaselineNumber_91] == 1498
    @test df2[3,:rtfmDepartureRunway_92] == "EDDL23R"
    @test df2[3,:rtfmArrivalRunway_93] == "LTAC03R"
    @test df2[3,:rtfmReqFlightlevelSpeedNrOfInstances_94] == 3
    @test df2[3,:rtfmReqFlightlevelSpeedList_95] == "F350:N0425:0 F370:N0439:410 F390:N0453:1497"
    @test df2[3,:rtfmConsumedFuel_96] == 7772.0
    @test df2[3,:rtfmRouteCharges_97] == 1153.0
    @test df2[3,:rtfmAllFtPointNrOfInstances_98] == 68
    #@test df[2,:rtfmAllFtPointProfile_99]
    @test df2[3,:rtfmAllFtAirspaceNrOfInstances_100] == 97
    #@test df[2,:rtfmAllFtAirspaceProfile_101]
    @test df2[3,:rtfmAllFtCircleIntersectionsNrOfInstances_102] == 4
    #@test df[2,:rtfmAllFtCircleIntersections_103]
    @test df2[2,:ctfmAiracCycleReleaseNumber_104] == 447
    @test df2[2,:ctfmEnvBaselineNumber_105] == 1270
    @test df2[2,:ctfmDepartureRunway_106] == "GCXO30"
    @test df2[2,:ctfmArrivalRunway_107] == "GCHI34"
    @test df[2,:ctfmReqFlightlevelSpeedNrOfInstances_108] == 1
    @test df2[1,:ctfmReqFlightlevelSpeedList_109] == "F300:N0487:0 F320:N0487:492 F320:M084:1367 F360:M084:4021"
    @test df2[2,:ctfmConsumedFuel_110] == 343.0
    @test df2[2,:ctfmRouteCharges_111] == 49.0
    @test df2[2,:ctfmAllFtPointNrOfInstances_112] == 28
    #@test df[2,:ctfmAllFtPointProfile_113]
    @test df2[2,:ctfmAllFtAirspaceNrOfInstances_114] == 8
    #@test df[2,:ctfmAllFtAirspaceProfile_115]
    @test df2[2,:ctfmAllFtCircleIntersectionsNrOfInstances_116] == 2
    #@test df[2,:ctfmAllFtCircleIntersections_117]
    @test df2[5,:noCPGCPFReason_118] == "X"
    @test Dates.day(df2[2,:scrObt_119]) == 3
    @test df2[2,:scrConsumedFuel_120] == 322.0
    @test df2[2,:scrRouteCharges_121] === 49.0
    @test df2[2,:scrAllFtPointNrOfInstances_122] == 16
    #@test df[2,:scrAllFtPointProfile_123]
    @test df2[2,:scrAllFtAirspaceNrOfInstances_124] == 10
    #@test df[2,:scrAllFtAirspaceProfile_125]
    @test df2[2,:scrAllFtCircleIntersectionsNrOfInstances_126] == 0
    #@test df[2,:scrAllFtCircleIntersections_127]
    @test Dates.minute(df2[3,:srrObt_128]) == 15
    @test df2[3,:srrConsumedFuel_129] == 7813.0
    @test df2[3,:srrRouteCharges_130] == 1113.0
    @test df2[3,:srrAllFtPointNrOfInstances_131] == 74
    #@test df[2,:srrAllFtPointProfile_132]
    @test df2[3,:srrAllFtAirspaceNrOfInstances_133] == 80
    #@test df[2,:srrAllFtAirspaceProfile_134]
    @test df2[3,:srrAllFtCircleIntersectionsNrOfInstances_135] == 4
    #@test df[2,:srrAllFtCircleIntersections_136]
    @test Dates.minute(df2[2,:surObt_137]) == 54
    @test df2[2,:surConsumedFuel_138] == 343.0
    @test df2[2,:surRouteCharges_139] == 49.0
    @test df2[2,:surAllFtPointNrOfInstances_140] == 28
    #@test df[2,:surAllFtPointProfile_141]
    @test df2[2,:surAllFtAirspaceNrOfInstances_142] == 8
    #@test df[2,:surAllFtAirspaceProfile_143]
    @test df2[3,:surAllFtCircleIntersectionsNrOfInstances_144] == 4
    #@test df[2,:surAllFtCircleIntersections_145]
    @test Dates.minute(df2[1,:dctObt_146]) == 50
    @test df2[1,:dctConsumedFuel_147] == 73966.0
    @test df2[1,:dctRouteCharges_148] == 1864.0
    @test df2[1,:dctAllFtPointNrOfInstances_149] == 40
    #@test df[2,:dctAllFtPointProfile_150]
    @test df2[1,:dctAllFtAirspaceNrOfInstances_151] == 79
    #@test df[2,:dctAllFtAirspaceProfile_152]
    @test df2[1,:dctAllFtCircleIntersectionsNrOfInstances_153] == 4
    #@test df[2,:dctAllFtCircleIntersections_154]
    @test df[2,:cpfObt_155] === missing
    @test df[2,:cpfConsumedFuel_156] === missing
    @test df[2,:cpfRouteCharges_157] === missing
    @test df2[2,:cpfAllFtPointNrOfInstances_158] == 0
    #@test df[2,:cpfAllFtPointProfile_159]
    @test df2[2,:cpfAllFtAirspaceNrOfInstances_160] == 0
    #@test df[2,:cpfAllFtAirspaceProfile_161]
    @test df2[2,:cpfAllFtCircleIntersectionsNrOfInstances_162] == 0
    #@test df[2,:cpfAllFtCircleIntersections_163]
    @test df[2,:aircraftidIATA_164] === missing
    @test df[2,:intentionFlight_165] === missing
    @test df[2,:intentionRelatedRouteAssignmentMethod_166] === missing
    @test df[2,:intentionUID_167] === missing
    @test df[2,:intentionEditionDate_168] === missing
    @test df[2,:intentionSource_169] === missing
    @test df[2,:associatedIntentions_170] === missing
    @test df[2,:enrichmentOutput_171] === missing
    @test df2[2,:eventID_172] == "TTE"
    @test Dates.second(df2[1,:eventTime_173]) == 44
    @test df2[2,:flightVersionNr_174] == 44
    @test df[2,:ftfmNrTvProfiles_175] === missing
    # @test df[2,:ftfmTvProfile_176] === missing
    @test df[2,:rtfmNrTvProfiles_177] === missing
    # @test df[2,:rtfmTvProfile_178] === missing
    @test df[2,:ctfmNrTvProfiles_179] === missing
    # @test df[2,:ctfmTvProfile_180] === missing
    #LAST TEST
    @test df[5,:departureAerodromeIcaoId_0] == "WSSS"
end
