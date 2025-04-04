##################################################################################################################################
#                                               load packages
##################################################################################################################################
cd(@__DIR__)
using Pkg
Pkg.activate("..")
using Revise
using ACTR_SFT
using DataFrames
using Distributions
using Plots
using Random
Random.seed!(1854)
pyplot()
##################################################################################################################################
#                                            setup intra-modal simulation
##################################################################################################################################
# salience effect
Δv = 0.020
Δa = 0.020
# stimulus conditions
stimuli = (:H, :L, :absent)
# process distribution 
dist = Uniform
# number of simulations 
n_sim = 10_000
# time range 
time_range = range(0.2, 1.0, length = 500)
plot_options = (xlabel = "RT [s]", ylabel = nothing, linewidth = 1,
    grid = false, leg = false, framestyle = :box, ylims = (-4, 4),
    titlefontsize = 8, xaxis = font(6), yaxis = font(6))
##################################################################################################################################
#                                                 intra-modality Serial AND
##################################################################################################################################
# response rule 
rule = AND
# model
model = SerialACTR(; Δv, Δa, dist, μa = 0.285)
sim_data = simulate_experiment(model, simulate_imdf, rule, stimuli, n_sim)
df = DataFrame(sim_data)
workload = compute_and_capacity(df, time_range)

p1 = plot(time_range, workload, color = :black, title = "IM S AND"; plot_options...)
hline!([0.0], linestyle = :dash, color = :black)
##################################################################################################################################
#                                                 intra-modality Serial OR
##################################################################################################################################
# response rule 
rule = OR
# model
model = SerialACTR(; Δv, Δa, dist, μa = 0.285)
sim_data = simulate_experiment(model, simulate_imdf, rule, stimuli, n_sim)
df = DataFrame(sim_data)
workload = compute_or_capacity(df, time_range)

p2 = plot(time_range, workload, color = :black, title = "IM S OR"; plot_options...)
hline!([0.0], linestyle = :dash, color = :black)
##################################################################################################################################
#                                                 cross-modality Serial AND
##################################################################################################################################
# response rule 
rule = AND
# model
model = SerialACTR(; Δv, Δa, dist, μa = 0.285)
sim_data = simulate_experiment(model, simulate_cmdf, rule, stimuli, n_sim)
df = DataFrame(sim_data)
workload = compute_and_capacity(df, time_range)

p3 = plot(time_range, workload, color = :black, title = "CM S AND"; plot_options...)
hline!([0.0], linestyle = :dash, color = :black)
##################################################################################################################################
#                                                 cross-modality Serial OR
##################################################################################################################################
# response rule 
rule = OR
# model
model = SerialACTR(; Δv, Δa, dist, μa = 0.285)
sim_data = simulate_experiment(model, simulate_cmdf, rule, stimuli, n_sim)
df = DataFrame(sim_data)
workload = compute_or_capacity(df, time_range)

p4 = plot(time_range, workload, color = :black, title = "CM S OR"; plot_options...)
hline!([0.0], linestyle = :dash, color = :black)
##################################################################################################################################
#                                                 cross-modality Parallel AND
##################################################################################################################################
# response rule 
rule = AND
# model
model = ParallelACTR(; Δv, Δa, dist, μa = 0.285)
sim_data = simulate_experiment(model, simulate_cmdf, rule, stimuli, n_sim)
df = DataFrame(sim_data)
workload = compute_and_capacity(df, time_range)

p5 = plot(time_range, workload, color = :black, title = "CM P AND"; plot_options...)
hline!([0.0], linestyle = :dash, color = :black)
##################################################################################################################################
#                                                 cross-modality Parallel OR
##################################################################################################################################
# response rule 
rule = OR
# model
model = ParallelACTR(; Δv, Δa, dist, μa = 0.285)
sim_data = simulate_experiment(model, simulate_cmdf, rule, stimuli, n_sim)
df = DataFrame(sim_data)
workload = compute_or_capacity(df, time_range)

p6 = plot(time_range, workload, color = :black, title = "CM P OR"; plot_options...)
hline!([0.0], linestyle = :dash, color = :black)

plot([p1, p2, p3, p4, p5, p6]..., size = (340, 300), layout = (3, 2))
savefig("workload_plots.eps")
