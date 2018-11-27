module Example

using Gadfly
import Gadfly.plot

import Base.rand
export AbstractPoint, AbstractLine,AbstractPlane, Point, Line, Plane
export area, point, distance, convexHull, boundingbox
export layer, layerPolygon

include("types.jl")
include("functions.jl")
include("plotting.jl")

end # module
