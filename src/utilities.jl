"""
    parse_module_activity(json_io)

Parses module activity stored as a JSON file. This is used to prepare data for Gantt chart 

# Arguments 

- `json_io`: json object. 
"""
function parse_module_activity(json_io)
    json_data = JSON.parse(json_io)
    col_names = mapreduce(x -> fill(x[1], length(x[2])), vcat, json_data)
    module_vectors = map(x -> x[2], json_data)
    start_times = [arr[1] for v ∈ module_vectors for arr ∈ v]
    end_times = [arr[2] for v ∈ module_vectors for arr ∈ v]
    return start_times, end_times, col_names
end

function map_condition(x, y)
    str1 = mapper(x)
    str2 = mapper(y)
    return str1 * str2
end

mapper(x) = (x == "red") || (x == "0") ? "H" : x == "NIL" ? "A" : "L"

rect(w, h, x, y) = Shape(x .+ [0, w, w, 0, 0], y .+ [0, 0, h, h, 0])

"""
    plot_gantt_chart(df; kwargs...)

Creates a Gantt chart from a DataFrame of the following form:
```julia
7×4 DataFrame
 Row │ label       start_time  end_time  color
     │ String      Float64     Float64   RGB…
─────┼─────────────────────────────────────────────────────────────────────
   1 │ visual           0.05      0.135  RGB{Float64}(0.258824,0.658824,0… 
   2 │ visual           0.235     0.32   RGB{Float64}(0.258824,0.658824,0… 
   3 │ procedural       0.0       0.05   RGB{Float64}(0.258824,0.431373,0… 
   4 │ procedural       0.135     0.185  RGB{Float64}(0.258824,0.431373,0… 
```

# Arguments

- `df`: a DataFrame consisting of the following columns: label, start time, end time and color (see above)

# Keywords

- `kwargs...` optional keyword arguments to change the attributes of the plot 
"""
function plot_gantt_chart(df; kwargs...)
    df.duration = df.end_time - df.start_time
    nl = length(unique(df.label))
    dy = Dict(unique(df.label) .=> 1:nl)
    r = [rect(t[1], 1, t[2], dy[t[3]]) for t in zip(df.duration, df.start_time, df.label)]
    y_axis_labels = unique(df.label)

    return plot(r, c = permutedims(df.color),
        yticks = (1.5:(length(y_axis_labels) + 0.5), y_axis_labels),
        xlabel = "Time [s]", labels = false, grid = false, framestyle = :box,
        size = (300, 150), xaxis = font(6), yaxis = font(6), dpi = 400; kwargs...)
end
