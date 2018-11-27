module Example

import Base.rand
export AbstractPoint, AbstractLine,AbstractPlane, Point, Line, Plane
export area, point, distance, convexHull

include("types.jl")
include("functions.jl")

end # module
