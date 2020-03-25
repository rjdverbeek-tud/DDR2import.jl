"""
Sls fileformat
Sector list file

The link between this and the region file ARE is made by volume name

See EUROCONTROL NEST Manual for Sls fileformat description

Sls DataFrame Column Names
#   Field           Type        Size    Comment
1   :SECTORNAME     String      Max 19
2   :VOLUMENAME     String              Refer to name in volumne IN the ARE file (max 24 characters)
3   :VOLUMEBOTTOMLEVEL  Int64           In FL, overwrite level present in ARE file for that volume
4   :VOLUMETOPLEVEL Int64               In FL, overwrite level present in ARE file for that volume

Example SLS fileformat
CASTOR_UP + AX 000 295
CASTOR_UP + GU 245 265
TMA + SLP 000 095
TMA + SLX 000 125
ABRON + TOP 45 660
"""
module Sls

export read

using Format
using CSV
using DataFrames

const fileformat = Dict(1=>String, 2=>String, 3=>String, 4=>Int64,
5=>Int64)

const header_format = ["SECTORNAME", "VOLUMESIGN", "VOLUMENAME",
"VOLUMEBOTTOMLEVEL", "VOLUMETOPLEVEL"]

function read(file)
    df = CSV.read(file, delim=" ", types=fileformat, header=header_format,
    copycols=true)
    select!(df, Not(:VOLUMESIGN))
    return df
end

end # module
