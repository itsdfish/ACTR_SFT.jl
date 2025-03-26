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
Random.seed!(9854)
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
plot_options = (ylabel = nothing, linewidth = 1,
    grid = false, leg = false, framestyle = :box, ylims = (-0.25, 0.25),
    titlefontsize = 7, xaxis = font(5), yaxis = font(5), yticks = [-0.2, 0, 0.2])
##################################################################################################################################
#                                                 cross-modality Serial AND
##################################################################################################################################
# response rule 
rule = AND
# model
model = SerialACTR(; Δv, Δa, dist, μa = 0.100)
sim_data = simulate_experiment(model, simulate_cmdf, rule, stimuli, n_sim)
df = DataFrame(sim_data)
sic = compute_sic(df, time_range)

p1 = plot(time_range, sic, color = :black, title = "S AND"; plot_options...)
hline!([0.0], linestyle = :dash, color = :black)
##################################################################################################################################
#                                                 cross-modality Serial OR
##################################################################################################################################
# response rule 
rule = OR
model = SerialACTR(; Δv, Δa, dist, μa = 0.100)
sim_data = simulate_experiment(model, simulate_cmdf, rule, stimuli, n_sim)
df = DataFrame(sim_data)
sic = compute_sic(df, time_range)

p2 = plot(time_range, sic, color = :black, title = "S OR"; plot_options...)
hline!([0.0], linestyle = :dash, color = :black)
##################################################################################################################################
#                                                 cross-modality Parallel AND
##################################################################################################################################
# response rule 
rule = AND
# model
model = ParallelACTR(; Δv, Δa, dist, μa = 0.100)
sim_data = simulate_experiment(model, simulate_cmdf, rule, stimuli, n_sim)
df = DataFrame(sim_data)
sic = compute_sic(df, time_range)

p3 = plot(time_range, sic, color = :black, title = "P AND"; plot_options...)
hline!([0.0], linestyle = :dash, color = :black)
##################################################################################################################################
#                                                 cross-modality Parallel OR
##################################################################################################################################
# response rule 
rule = OR
# model
model = ParallelACTR(; Δv, Δa, dist, μa = 0.100)
sim_data = simulate_experiment(model, simulate_cmdf, rule, stimuli, n_sim)
df = DataFrame(sim_data)
sic = compute_sic(df, time_range)

p4 = plot(time_range, sic, color = :black, title = "P OR"; plot_options...)
hline!([0.0], linestyle = :dash, color = :black)

layout = @layout [grid(3, 3); b{0.2h}]
##################################################################################################################################
#                                                 co-active
##################################################################################################################################
# model
model = Coactive(; ν = 5.5, α = 0.50, τ = 0.350, Δ = -2)
sim_data = simulate_experiment(model, simulate_imdf, stimuli, n_sim)
df = DataFrame(sim_data)
sic = compute_sic(df, time_range)

p5 = plot(time_range, sic, xlabel = "RT [s]", color = :black, title = "CA"; plot_options...)
hline!([0.0], linestyle = :dash, color = :black)

layout = @layout [grid(2, 2); b{0.3h}]

plot([p1, p2, p3, p4, p5]..., size = (250, 230); layout)
savefig("sic_plots.eps")
