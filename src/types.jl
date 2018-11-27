# Type Definitions and Conversions

#Abstract Type Definitions

abstract type AbstractGeometry{T <: Real, N} end
abstract type AbstractPoint{T, N} <: AbstractGeometry{T, N} end
abstract type AbstractLine{T, N} <: AbstractGeometry{T, N} end
abstract type AbstractPlane{T, N} <: AbstractGeometry{T, N} end

# Specific Types
"""
    Point{T, N}
A point in `N` dimensional space stored with the datatype `T`. Has a single field
coordinates which is stored as an `NTuple{N, T}`.
"""
struct Point{T, N} <: AbstractPoint{T, N}
    coordinates::Array{T}
end

Point{T}(args...) where T = Point{T, length(args)}(Array{T}([args...]))
Point(args...) = Point{typeof(args[1])}(args...)

"""
    Line{T, N}
A line which passes through the point `p` and extended using a basis vector `v`
"""
struct Line{T, N} <: AbstractLine{T, N}
    p::Point{T, N}
    v::Array{T}
end

Line(p1::Point{T, N}, p2::Point{T, N}) where N where T = Line{T, N}(p1, p1.coordinates .- p2.coordinates)

"""
    Plane{T, N}
A plane which passes through point `p` and is perpendicular to the normal vector `n`.
"""
struct Plane{T, N} <: AbstractPlane{T, N}
    p::Point{T, N}
    n::Vector{T}
end

"""
    Polygon{T, N}

An array of points.
"""
