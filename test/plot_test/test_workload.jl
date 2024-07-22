##################################################################################################################################
#                                               load packages
##################################################################################################################################
cd(@__DIR__)
using Pkg
Pkg.activate("../..")
using Revise
using ACTR_SFT
using Distributions
using Plots
using Random
using StatsBase
pyplot()
##################################################################################################################################
#                               simulate unlimited capacity parallel AND
##################################################################################################################################
n_sim = 1_000_000
dist = Gamma(10, 0.08)
rt_both = max.(rand(dist, n_sim), rand(dist, n_sim))
rt_top = rand(dist, n_sim)
rt_bottom = rand(dist, n_sim)
time_range = range(0.3, 1.5, length = 200)

# create empirical cdfs
f_both = ecdf(rt_both)
f_top = ecdf(rt_top)
f_bottom = ecdf(rt_bottom)

# compute workload
workload = compute_and_capacity(f_both, (f_top, f_bottom), time_range)

# capacity coefficient should mostly follow a line along zero
p1 = plot(time_range,
    workload,
    color = :black,
    grid = false,
    leg = false,
    framestyle = :box,
    ylims = (-0.2, 0.2)
)
hline!([0.0], linestyle = :dash, color = :black)
##################################################################################################################################
#                            simulate unlimited capacity parallel OR
##################################################################################################################################
n_sim = 1_000_000
dist = Gamma(10, 0.08)
rt_both = min.(rand(dist, n_sim), rand(dist, n_sim))
rt_top = rand(dist, n_sim)
rt_bottom = rand(dist, n_sim)

# create empirical cdfs
f_both = ecdf(rt_both)
f_top = ecdf(rt_top)
f_bottom = ecdf(rt_bottom)

# compute workload
workload = compute_or_capacity(f_both, (f_top, f_bottom), time_range)

# capacity coefficient should mostly follow a line along zero
p1 = plot(time_range,
    workload,
    color = :black,
    grid = false,
    leg = false,
    framestyle = :box,
    ylims = (-0.2, 0.2)
)
hline!([0.0], linestyle = :dash, color = :black)
##################################################################################################################################
#                              simulate limited capacity parallel AND
##################################################################################################################################
n_sim = 1_000_000
dist_both = Gamma(10, 0.1)
dist_one = Gamma(10, 0.08)
rt_both = max.(rand(dist_both, n_sim), rand(dist_both, n_sim))
rt_top = rand(dist_one, n_sim)
rt_bottom = rand(dist_one, n_sim)

# create empirical cdfs
f_both = ecdf(rt_both)
f_top = ecdf(rt_top)
f_bottom = ecdf(rt_bottom)

# compute workload
workload = compute_and_capacity(f_both, (f_top, f_bottom), time_range)

# capacity coefficient should be mostly negative due to limited capacity
p1 = plot(time_range,
    workload,
    color = :black,
    grid = false,
    leg = false,
    framestyle = :box
)
hline!([0.0], linestyle = :dash, color = :black)
