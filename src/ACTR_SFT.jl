module ACTR_SFT

using Distributions
using JSON
using Plots

using SequentialSamplingModels: Wald
using StatsBase: ecdf

export AND
export OR
export Fixed
export Coactive
export ParallelACTR
export SerialACTR

export compute_and_capacity
export compute_or_capacity
export compute_sic
export map_condition
export mapper
export parse_module_activity
export plot_gantt_chart
export simulate_cmdf
export simulate_imdf
export simulate_experiment
export survivor

include("structs.jl")
include("models.jl")
include("sft.jl")
include("utilities.jl")

end
