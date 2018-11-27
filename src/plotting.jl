# Plotting

function layerPolygon(arr::Array{Point{T, 2}, 1}) where T
    xx = []
    yy = []
    for i in 1:length(arr)
        push!(xx, arr[i].coordinates[1])
        push!(yy, arr[i].coordinates[2])
    end
    return layer(x = xx, y = yy, Geom.polygon(preserve_order = true, fill = true))
end

function layer(arr::Array{Point{T, 2}, 1}) where T
    xx = []
    yy = []
    for i in 1:length(arr)
        push!(xx, arr[i].coordinates[1])
        push!(yy, arr[i].coordinates[2])
    end
    return layer(x = xx, y = yy)
end
