"""
The EUROCONTROL Demand Data Repository 'DDR2' provides air traffic management
(ATM) actors with the most accurate picture of past and future pan-European air
traffic demand (from several years ahead until the day before operation), as
well as environment data, analysis reports and tools that can read and process
the data.

All this information is management by DDR service, a EUROCONTROL cross-unit
activity, and can be accessed from the Demand Data Repository 2 'DDR2' web
portal. Access to the DDR2 web portal is restricted. Access conditions apply.

DDR future traffic can be forecast thanks to the knowledge of past traffic and
several thousands of flight intentions provided by airlines and airports that
are collected, stored, analysed and treated on a daily basis.

DDR traffic forecast supports strategic, seasonal and pre-tactical planning,
and also special events or major ATM evolution projects.

Finally, DDR provides a refined analysis of past demand to facilitate
post-operations analysis and to identify best practices for future operations.

Functionality
DDR2 gives access to:

Past traffic data - from August 2012 till now, traffic demand, last filed
flight plan traffic trajectories as well as actual trajectories are provided
for past analysis;
Past and Pre-OPS (one AIRAC in advance) environment data - they can be
downloaded and are used internally for processing future traffic trajectories.
    They contain all information necessary to analyse and process sector loads,
    capacity bottlenecks, re-routing options, etc;
Strategic traffic forecast - this covers the planning phase, from 18 months to
7 days before operations. It is used for medium- to-short-term capacity
planning and seasonal planning. Users can themselves generate, with several 4D
trajectory processing options, and download this type of forecast directly via
the DDR2 web portal;
Pre-tactical traffic forecast - it focusses on the planning phase, from 6 days
to 1 day before operations. Network pre-tactical planning is supported by the
NM PREDICT system and can be accessed via the DDR2 portal;
NEST and SAAM tools - they can be downloaded from DDR2 Web portal and are
compatible with DDR data. These tools analyse and process a great deal of information for the purpose of facilitating airspace design and capacity planning in Europe.

Users
The DDR addresses the needs of a wide range of users such as:

air navigation service providers (ANSPs), who use it to prepare and optimise
their capacity plans;
airlines, who rely on it to detect flight efficiency improvement opportunities,
by visualising and comparing flight plan trajectories for any period of time in
    the past;
airspace management actors, for airspace management and coordination of the
available airspace;
airports, with the aim of integrating their local plans with the Network
Operations Plan;
the NM at central/FAB/local level.

See EUROCONTROL NEST Manual Section 9.7 for fileformat descriptions

"""

module DDR2import
    include("T5.jl")
    include("SO6.jl")
    include("Exp2.jl")
    include("Allftplus.jl")
    include("Ase.jl")
    include("Are.jl")
    include("Gar.jl")
    include("Gsl.jl")
    include("Frp.jl")
end # module

#TODO Implementation sequence
"""
Implementation sequence
SO6
T5
EXP2
ALL_FT+
ASE
ARE
Gar
Gsl
Frp
Sls
"""
