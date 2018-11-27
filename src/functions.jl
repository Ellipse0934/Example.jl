# Functions

# Point
#rand(rng::Random.AbstractRNG, ::Random.SamplerType{Point{T, N}}) where N where T = Point{T, N}(NTuple{N, T}(rand(rng, T, N)))
distance(p1::Point{T, N}, p2::Point{T, N}) where N where T = sqrt(sum((p1.coordinates .- p2.coordinates).^2))

#=function area(arr::Array{Point{T, N}})
    length(arr) ≦ 2 && error("Area for two points cannot be computed!")
    area = 0.0
    x = 2
    y = 3
    flag = false
    while(x ≦ length(arr) && y ≦ length(arr))
        a = distance(arr[1], arr[x])
        b = distance(arr[x], arr[z])
        c = distance(arr[1], arr[z])
        s = (a + b + c)/2.0
        area += sqrt(s*(s - a)*(s - b)*(s - c))
        if flag == false
            flag = true
            x = y + 1
        else
            flag = false
            y = x + 1
        end
    end
    return area
end=#

function convexHull(points::Array{Point{T,2},1}) where T
    if length(points) < 3
        error("Minimum three points required")
    end
    n = length(points)
    function orientation(p::Point{T, 2}, q::Point{T, 2}, r::Point{T, 2}) where T <: Real
        v = (q.coordinates[2] - p.coordinates[2])*(r.coordinates[1] - q.coordinates[1])- (q.coordinates[1] - p.coordinates[1])*(r.coordinates[2] - q.coordinates[2])
        if v == 0 return 0 end
        return v > 0 ? 1 : 2
    end
    hull = Array{Point{T, 2}, 1}(undef, 0)
    l = 1
    for i in 2:n
        if points[i].coordinates[1] < points[l].coordinates[1]
            l = i
        end
    end
    p = l - 1
    q = -1
    while true
        push!(hull, points[p + 1])
        q = (p + 1) % n
        for i in 0:(n - 1)
            if(orientation(points[p + 1], points[i + 1], points[q+1]) == 2)
                q = i
            end
        end
        p = q
        if p == l - 1
            break
        end
    end
    return hull
end
# Line
function distance(p::Point{T, N}, l::Line{T, N}) where N where T
    t = dot(p.coordinates .- l.p.coordinates, l.v)/dot(l.v, l.v)
    return norm(p.coordinates .- l.p.coordinates .- t*l.v)
end
distance(l::Line{T, N}, p::Point{T, N}) where N where T = distance(p::Point{T, N}, l::Line{T, N})

function distance(l1::Line{T, N}, l2::Line{T, N}; err = 1e-10) where N where T
    if norm(l1.v .- l2.v) ≦ err
        return distance(l1.p, l2)
    else
        return zero(T)
    end
end

# Plane

function distance(p::Point{T, N}, q::Plane{T, N}) where N where T
    x = distance(p, q.p)
    y = distance(p, q.n)
    return sqrt(x^2 - y^2)
end
#=
function boundingbox(a::Array{Point{T, N}}})
    mn = Array{T}(undef, N)
    mn .= typemax(T)
    mx = Array{T}(undef, N)
    mx .= typemin(T)
    for i in 1:N, j in 1:length(a)
        mn[i] = min(mn[i], a[j].coordinates[i])
        mx[i] = max(mx[i], a[j].coordinates[i])
    end
    return (Point{T, N}(mn), Point{T, N}(mx))
end

=#
