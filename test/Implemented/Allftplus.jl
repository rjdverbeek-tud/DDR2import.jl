using Dates

@testset "Allftplus.jl" begin
    filename = "data\\20171215_from_NEST.ALL_FT+"
    df = DDR2import.Allftplus.read(filename)
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
    @test df[2,:iobt_7] === missing
    @test df[2,:originalFlightDataQuality_8] === missing
    @test df[2,:flightDataQuality_9] === missing
    @test df[2,:source_10] == "UNK"
    @test df[2,:exemptionReasonType_11] == "NEXE"
    @test df[2,:exemptionReasonDistance_12] == "NEXE"
    @test df[2,:lateFiler_13] === missing
    @test df[2,:lateUpdater_14] === missing
    @test df[2,:northAtlanticFlight_15] === missing
    @test Dates.month(df[2,:cobt_16]) == 12
    @test Dates.hour(df[2,:cobt_16]) == 5
    @test Dates.day(df[2,:eobt_17]) == 15
    @test Dates.minute(df[2,:eobt_17]) == 45
    @test df[2,:lobt_18] === missing
    @test df[2,:flightState_19] == "NE"
    @test df[2,:previousToActivationFlightState_20] == "NE"
    @test df[2,:suspensionStatus_21] == "NS"
    @test df[2,:tactId_22] == 512256
    @test Dates.year(df[2,:samCtot_23]) == 2017
    @test df[2,:samSent_24] === missing
    @test Dates.day(df[2,:sipCtot_25]) == 15
    @test df[2,:sipSent_26] === missing
    @test df[2,:slotForced_27] === missing
    @test df[2,:mostPenalizingRegulationId_28] == "EHAMA15M"
    @test df[2,:regulationsAffectedByNrOfInstances_29] == 0
    @test df[2,:excludedFromNrOfInstances_30] == 0
    @test df[2,:lastReceivedAtfmMessageTitle_31] === missing
    @test df[2,:lastReceivedMessageTitle_32] === missing
    @test df[2,:lastSentAtfmMessageTitle_33] === missing
    @test df[2,:manualExemptionReason_34] == "N"
    @test df[2,:sensitiveFlight_35] === missing
    @test df[2,:readyForImprovement_36] === missing
    @test df[2,:readyToDepart_37] === missing
    @test df[2,:revisedTaxiTime_38] == 0
    @test df[2,:tis_39] == 0
    @test df[2,:trs_40] == 0
    @test df[2,:toBeSentSlotMessageTitle_41] === missing
    @test df[2,:toBeSentProposalMessageTitle_42] === missing
    @test df[2,:lastSentSlotMessageTitle_43] === missing
    @test df[2,:lastSentProposalMessageTitle_44] === missing
    @test Dates.year(df[2,:lastSentSlotMessage_45]) == 2017
    @test Dates.day(df[2,:lastSentSlotMessage_45]) == 15
    @test Dates.month(df[2,:lastSentProposalMessage_46]) == 12
    @test df[2,:flightCountOption_47] == "N"
    @test df[2,:normalFlightTactId_48] === missing
    @test df[2,:proposalFlightTactId_49] === missing
    @test df[2,:operatingAircraftOperatorIcaoId_50] === missing
    @test df[2,:reroutingWhy_51] === missing
    @test df[2,:reroutedFlightState_52] === missing
    @test df[2,:runwayVisualRange_53] == 0
    @test df[2,:numberIgnoredErrors_54] === missing
    @test df[2,:arcAddrSource_55] === missing
    @test df[2,:arcAddr_56] === missing
    @test df[2,:ifpsRegistrationMark_57] === missing
    @test df[2,:flightType_58] === missing
    @test df[2,:aircraftEquipment_59] === missing
    @test df[2,:cdmStatus_60] === missing
    @test df[2,:cdmEarlyTtot_61] === missing
    @test df[2,:cdmAoTtot_62] === missing
    @test df[2,:cdmAtcTtot_63] === missing
    @test df[2,:cdmSequencedTtot_64] === missing
    @test df[2,:cdmTaxiTime_65] === missing
    @test df[2,:cdmOffBlockTimeDiscrepancy_66] === missing
    @test df[2,:cdmDepartureProcedureId_67] === missing
    @test df[2,:cdmAircraftTypeId_68] === missing
    @test df[2,:cdmRegistrationMark_69] === missing
    @test df[2,:cdmNoSlotBefore_70] === missing
    @test df[2,:cdmDepartureStatus_71] === missing
    @test df[2,:ftfmEetFirNrOfInstances_72] === missing
    #@test df[2,:ftfmEetFirList_73] === missing
    @test df[2,:ftfmEetPtNrOfInstances_74] === missing
    #@test df[2,:ftfmEetPtList_75] === missing
    @test df[2,:ftfmAiracCycleReleaseNumber_76] === missing
    @test df[2,:ftfmEnvBaselineNumber_77] === missing
    @test df[2,:ftfmDepartureRunway_78] === missing
    @test df[2,:ftfmArrivalRunway_79] === missing
    @test df[2,:ftfmReqFlightlevelSpeedNrOfInstances_80] == 1
    #@test df[2,:ftfmReqFlightlevelSpeedList_81]
    @test df[2,:ftfmConsumedFuel_82] === missing
    @test df[2,:ftfmRouteCharges_83] === missing
    @test df[2,:ftfmAllFtPointNrOfInstances_84] === missing
    #@test df[2,:ftfmAllFtPointProfile_85]
    @test df[2,:ftfmAllFtAirspaceNrOfInstances_86] === missing
    #@test df[2,:ftfmAllFtAirspaceProfile_87]
    @test df[2,:ftfmAllFtCircleIntersectionsNrOfInstances_88] === missing
    #@test df[2,:ftfmAllFtCircleIntersections_89]
    @test df[2,:rtfmAiracCycleReleaseNumber_90] === missing
    @test df[2,:rtfmEnvBaselineNumber_91] === missing
    @test df[2,:rtfmDepartureRunway_92] === missing
    @test df[2,:rtfmArrivalRunway_93] === missing
    @test df[2,:rtfmReqFlightlevelSpeedNrOfInstances_94] === missing
    #@test df[2,:rtfmReqFlightlevelSpeedList_95]
    @test df[2,:rtfmConsumedFuel_96] === missing
    @test df[2,:rtfmRouteCharges_97] === missing
    @test df[2,:rtfmAllFtPointNrOfInstances_98] === missing
    #@test df[2,:rtfmAllFtPointProfile_99]
    @test df[2,:rtfmAllFtAirspaceNrOfInstances_100] === missing
    #@test df[2,:rtfmAllFtAirspaceProfile_101]
    @test df[2,:rtfmAllFtCircleIntersectionsNrOfInstances_102] === missing
    #@test df[2,:rtfmAllFtCircleIntersections_103]
    @test df[2,:ctfmAiracCycleReleaseNumber_104] === missing
    @test df[2,:ctfmEnvBaselineNumber_105] === missing
    @test df[2,:ctfmDepartureRunway_106] === missing
    @test df[2,:ctfmArrivalRunway_107] === missing
    @test df[2,:ctfmReqFlightlevelSpeedNrOfInstances_108] == 1
    #@test df[2,:ctfmReqFlightlevelSpeedList_109]
    @test df[2,:ctfmConsumedFuel_110] === missing
    @test df[2,:ctfmRouteCharges_111] === missing
    @test df[2,:ctfmAllFtPointNrOfInstances_112] === missing
    #@test df[2,:ctfmAllFtPointProfile_113]
    @test df[2,:ctfmAllFtAirspaceNrOfInstances_114] === missing
    #@test df[2,:ctfmAllFtAirspaceProfile_115]
    @test df[2,:ctfmAllFtCircleIntersectionsNrOfInstances_116] === missing
    #@test df[2,:ctfmAllFtCircleIntersections_117]
    @test df[2,:noCPGCPFReason_118] === missing
    @test df[2,:scrObt_119] === missing
    @test df[2,:scrConsumedFuel_120] === missing
    @test df[2,:scrRouteCharges_121] === missing
    @test df[2,:scrAllFtPointNrOfInstances_122] === missing
    #@test df[2,:scrAllFtPointProfile_123]
    @test df[2,:scrAllFtAirspaceNrOfInstances_124] === missing
    #@test df[2,:scrAllFtAirspaceProfile_125]
    @test df[2,:scrAllFtCircleIntersectionsNrOfInstances_126] === missing
    #@test df[2,:scrAllFtCircleIntersections_127]
    @test df[2,:srrObt_128] === missing
    @test df[2,:srrConsumedFuel_129] === missing
    @test df[2,:srrRouteCharges_130] === missing
    @test df[2,:srrAllFtPointNrOfInstances_131] === missing
    #@test df[2,:srrAllFtPointProfile_132]
    @test df[2,:srrAllFtAirspaceNrOfInstances_133] === missing
    #@test df[2,:srrAllFtAirspaceProfile_134]
    @test df[2,:srrAllFtCircleIntersectionsNrOfInstances_135] === missing
    #@test df[2,:srrAllFtCircleIntersections_136]
    @test df[2,:surObt_137] === missing
    @test df[2,:surConsumedFuel_138] === missing
    @test df[2,:surRouteCharges_139] === missing
    @test df[2,:surAllFtPointNrOfInstances_140] === missing
    #@test df[2,:surAllFtPointProfile_141]
    @test df[2,:surAllFtAirspaceNrOfInstances_142] === missing
    #@test df[2,:surAllFtAirspaceProfile_143]
    @test df[2,:surAllFtCircleIntersectionsNrOfInstances_144] === missing
    #@test df[2,:surAllFtCircleIntersections_145]
    @test df[2,:dctObt_146] === missing
    @test df[2,:dctConsumedFuel_147] === missing
    @test df[2,:dctRouteCharges_148] === missing
    @test df[2,:dctAllFtPointNrOfInstances_149] === missing
    #@test df[2,:dctAllFtPointProfile_150]
    @test df[2,:dctAllFtAirspaceNrOfInstances_151] === missing
    #@test df[2,:dctAllFtAirspaceProfile_152]
    @test df[2,:dctAllFtCircleIntersectionsNrOfInstances_153] === missing
    #@test df[2,:dctAllFtCircleIntersections_154]
    @test df[2,:dctObt_146] === missing
    @test df[2,:dctConsumedFuel_147] === missing
    @test df[2,:dctRouteCharges_148] === missing
    @test df[2,:dctAllFtPointNrOfInstances_149] === missing
    #@test df[2,:dctAllFtPointProfile_150]
    @test df[2,:dctAllFtAirspaceNrOfInstances_151] === missing
    #@test df[2,:dctAllFtAirspaceProfile_152]
    @test df[2,:dctAllFtCircleIntersectionsNrOfInstances_153] === missing
    #@test df[2,:dctAllFtCircleIntersections_154]
    @test df[2,:cpfObt_155] === missing
    @test df[2,:cpfConsumedFuel_156] === missing
    @test df[2,:cpfRouteCharges_157] === missing
    @test df[2,:cpfAllFtPointNrOfInstances_158] === missing
    #@test df[2,:cpfAllFtPointProfile_159]
    @test df[2,:cpfAllFtAirspaceNrOfInstances_160] === missing
    #@test df[2,:cpfAllFtAirspaceProfile_161]
    @test df[2,:cpfAllFtCircleIntersectionsNrOfInstances_162] === missing
    #@test df[2,:cpfAllFtCircleIntersections_163]
    @test df[2,:aircraftidIATA_164] === missing
    @test df[2,:intentionFlight_165] === missing
    @test df[2,:intentionRelatedRouteAssignmentMethod_166] === missing
    @test df[2,:intentionUID_167] === missing
    @test df[2,:intentionEditionDate_168] === missing
    @test df[2,:intentionSource_169] === missing
    @test df[2,:associatedIntentions_170] === missing
    @test df[2,:enrichmentOutput_171] === missing
    @test df[2,:eventID_172] === missing
    @test df[2,:eventTime_173] === missing
    @test df[2,:flightVersionNr_174] === missing
    @test df[2,:ftfmNrTvProfiles_175] === missing
    # @test df[2,:ftfmTvProfile_176] === missing
    @test df[2,:rtfmNrTvProfiles_177] === missing
    # @test df[2,:rtfmTvProfile_178] === missing
    @test df[2,:ctfmNrTvProfiles_179] === missing
    # @test df[2,:ctfmTvProfile_180] === missing
end
