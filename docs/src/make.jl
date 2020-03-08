using Documenter, ISAtmosphere

makedocs(
    sitename = "DDR2import.jl",
    modules = [DDR2import],
    pages = Any[
        "Home" => "index.md",
    ],
)

deploydocs(
    repo = "github.com/rjdverbeek-tud/DDR2import.jl.git",
)
