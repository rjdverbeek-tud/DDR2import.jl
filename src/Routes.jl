"""
Routes fileformat

Example:
#;ROUTES;3;446;20181206;20190102;8;EAR_P
L;ABIRO1AGMTT;AP;999999999999;000000000000;ABIRO;SP;1
L;ABIRO1AGMTT;AP;999999999999;000000000000;*2TNG;DBP;2
L;ABIRO1DGMTT;DP;999999999999;000000000000;*TAN3;DBP;1
L;ABIRO1DGMTT;DP;999999999999;000000000000;ABIRO;SP;2
L;ABIRO2AGMTT;AP;999999999999;000000000000;ABIRO;SP;1
L;ABIRO2AGMTT;AP;999999999999;000000000000;*2TNG;DBP;2
L;ABIRO2DGMTT;DP;999999999999;000000000000;*1TNG;DBP;1
L;ABIRO2DGMTT;DP;999999999999;000000000000;ABIRO;SP;2
"""
module Routes

export read

struct RoutePoint
    wp::String
    location_type::String
end

struct Route
    type::String
    route::Vector{RoutePoint}
end

function read(file)
    routes = Dict{String, Route}()
    name = ""
    type = ""
    route = Vector{RoutePoint}()
    for route_line in eachline(file)
        split_route = split(route_line, ';')
        if split_route[1] == "L"
            if split_route[2] != name
                # Create route
                if split_route[2] != ""
                    routes[name] = Route(type, route)
                end
                name = split_route[2]
                type = split_route[3]
                route = Vector{RoutePoint}()
            end
            route = vcat(route, RoutePoint(split_route[6], split_route[7]))
        else
            # Initial line
        end
    end
    # Create route
    routes[name] = Route(type, route)
    return routes
end

end # module
