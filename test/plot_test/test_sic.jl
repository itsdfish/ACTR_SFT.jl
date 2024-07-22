##################################################################################################################################
#                                                     load packages
##################################################################################################################################
cd(@__DIR__)
using Pkg
Pkg.activate("../..")
using ACTR_SFT
using DataFrames
using Distributions
using Plots
using Random
using StatsBase
##################################################################################################################################
#                                                      example 1
##################################################################################################################################
# produces the expected SIC curve
Random.seed!(558)

n_sim = 10_000

D_H = Weibull(2, 400)
D_L = Weibull(2, 800)

rts_HH = max.(rand(D_H, n_sim), rand(D_H, n_sim))
rts_LH = max.(rand(D_L, n_sim), rand(D_H, n_sim))
rts_HL = max.(rand(D_H, n_sim), rand(D_L, n_sim))
rts_LL = max.(rand(D_L, n_sim), rand(D_L, n_sim))

time_range = range(0, 1200, length = 200)

f_ll = ecdf(rts_LL)
f_lh = ecdf(rts_LH)
f_hl = ecdf(rts_HL)
f_hh = ecdf(rts_HH)

sic = compute_sic(time_range; f_ll, f_lh, f_hl, f_hh)

plot(time_range, sic, xlabel = "RT [s]", ylabel = "SIC", linewidth = 1,
    grid = false, leg = false, framestyle = :box, ylims = (-0.25, 0.25),
    titlefontsize = 8, xaxis = font(10), yaxis = font(10))
hline!([0], color = :black, linestyle = :dash)

s_ll = survivor(f_ll, time_range)
s_lh = survivor(f_lh, time_range)
s_hl = survivor(f_hl, time_range)
s_hh = survivor(f_hh, time_range)

plot(time_range, s_ll, label = "LL", grid = false)
plot!(time_range, s_lh, label = "LH", grid = false)
plot!(time_range, s_hl, label = "HL", grid = false)
plot!(time_range, s_hh, label = "HH", grid = false)
##################################################################################################################################
#                                                           example 2
##################################################################################################################################
# the SIC curve is flat because the survivor functions are not ordered as expected.
# the processing time of one stimulus is much slower than the other. 
n_sim = 10_000

D1_H = Uniform(200, 400)
D1_L = Uniform(300, 500)

D2_H = Uniform(600, 800)
D2_L = Uniform(700, 900)

rts_HH = max.(rand(D1_H, n_sim), rand(D2_H, n_sim))
rts_LH = max.(rand(D1_L, n_sim), rand(D2_H, n_sim))
rts_HL = max.(rand(D1_H, n_sim), rand(D2_L, n_sim))
rts_LL = max.(rand(D1_L, n_sim), rand(D2_L, n_sim))

time_range = range(0, 1200, length = 200)

f_ll = ecdf(rts_LL)
f_lh = ecdf(rts_LH)
f_hl = ecdf(rts_HL)
f_hh = ecdf(rts_HH)

sic = compute_sic(time_range; f_ll, f_lh, f_hl, f_hh)

plot(time_range, sic, xlabel = "RT [s]", ylabel = "SIC", linewidth = 1,
    grid = false, leg = false, framestyle = :box, ylims = (-0.25, 0.25),
    titlefontsize = 8, xaxis = font(10), yaxis = font(10))
hline!([0], color = :black, linestyle = :dash)

s_ll = survivor(f_ll, time_range)
s_lh = survivor(f_lh, time_range)
s_hl = survivor(f_hl, time_range)
s_hh = survivor(f_hh, time_range)

plot(time_range, s_ll, label = "LL", grid = false)
plot!(time_range, s_lh, label = "LH", grid = false)
plot!(time_range, s_hl, label = "HL", grid = false)
plot!(time_range, s_hh, label = "HH", grid = false)
##################################################################################################################################
#                                                        example 3
##################################################################################################################################
n_sim = 10_000

D1_H = Weibull(1000, 200)
D1_L = Weibull(1000, 400)

D2_H = Weibull(1000, 800)
D2_L = Weibull(1000, 1000)

rts_HH = max.(rand(D_H, n_sim), rand(D_H, n_sim))
rts_LH = max.(rand(D_L, n_sim), rand(D_H, n_sim))
rts_HL = max.(rand(D_H, n_sim), rand(D_L, n_sim))
rts_LL = max.(rand(D_L, n_sim), rand(D_L, n_sim))

time_range = range(0, 1200, length = 200)

f_ll = ecdf(rts_LL)
f_lh = ecdf(rts_LH)
f_hl = ecdf(rts_HL)
f_hh = ecdf(rts_HH)

sic = compute_sic(time_range; f_ll, f_lh, f_hl, f_hh)

plot(time_range, sic, xlabel = "RT [s]", ylabel = "SIC", linewidth = 1,
    grid = false, leg = false, framestyle = :box, ylims = (-0.25, 0.25),
    titlefontsize = 8, xaxis = font(10), yaxis = font(10))
hline!([0], color = :black, linestyle = :dash)

s_ll = survivor(f_ll, time_range)
s_lh = survivor(f_lh, time_range)
s_hl = survivor(f_hl, time_range)
s_hh = survivor(f_hh, time_range)

plot(time_range, s_ll, label = "LL", grid = false)
plot!(time_range, s_lh, label = "LH", grid = false)
plot!(time_range, s_hl, label = "HL", grid = false)
plot!(time_range, s_hh, label = "HH", grid = false)
##################################################################################################################################
#                                                       example 4
##################################################################################################################################
# salience effect
Δv = 0.020
Δa = 0.020
# stimulus conditions
stimuli = (:H, :L, :absent)
# process distribution 
dist = Gamma
# number of simulations 
n_sim = 10_000
# time range 
time_range = range(0.2, 1.0, length = 500)

# response rule 
rule = AND
# model
model = ParallelACTR(; Δv, Δa, dist, μa = 0.285)
sim_data = simulate_experiment(model, simulate_cmdf, rule, stimuli, n_sim)
df = DataFrame(sim_data)
sic = compute_sic(df, time_range)

plot(time_range, sic, xlabel = "RT [s]", ylabel = "SIC", linewidth = 1,
    grid = false, leg = false, framestyle = :box, ylims = (-0.25, 0.25),
    titlefontsize = 8, xaxis = font(10), yaxis = font(10))
hline!([0], color = :black, linestyle = :dash)

df_LL = filter(x -> (x.stimulus1 == :L) && (x.stimulus2 == :L), df)
df_LH = filter(x -> (x.stimulus1 == :L) && (x.stimulus2 == :H), df)
df_HL = filter(x -> (x.stimulus1 == :H) && (x.stimulus2 == :L), df)
df_HH = filter(x -> (x.stimulus1 == :H) && (x.stimulus2 == :H), df)

f_ll = ecdf(df_LL.rts)
f_lh = ecdf(df_LH.rts)
f_hl = ecdf(df_HL.rts)
f_hh = ecdf(df_HH.rts)

s_ll = survivor(f_ll, time_range)
s_lh = survivor(f_lh, time_range)
s_hl = survivor(f_hl, time_range)
s_hh = survivor(f_hh, time_range)

plot(time_range, s_ll, label = "LL", grid = false)
plot!(time_range, s_lh, label = "LH", grid = false)
plot!(time_range, s_hl, label = "HL", grid = false)
plot!(time_range, s_hh, label = "HH", grid = false)
##################################################################################################################################
#                                                    example 5
##################################################################################################################################
using ACTR_SFT: transform
n_sim = 100_000
sd(μ) = std(Uniform(μ * 2 / 3, μ * 4 / 3))
μa = 0.285
μv = 0.085
Δ = 0.020

μvL = μv + Δ
σvL = sd(μvL)
θvL = transform(Gamma, μvL, σvL)
Dv_L = Gamma(θvL...)

μaL = μa + Δ
σaL = sd(μaL)
θaL = transform(Gamma, μaL, σaL)
Da_L = Gamma(θaL...)

μvH = μv - Δ
σvH = sd(μvH)
θvH = transform(Gamma, μvH, σvH)
Dv_H = Gamma(θvH...)

μaH = μa - Δ
σaH = sd(μaH)
θaH = transform(Gamma, μaH, σaH)
Da_H = Gamma(θaH...)

println("Dv_L: μ $(round(mean(Dv_L), digits=2)), σ $(round(std(Dv_L), digits=2))")
println("Dv_H: μ $(round(mean(Dv_H), digits=2)), σ $(round(std(Dv_H), digits=2))")
println("Da_L: μ $(round(mean(Da_L), digits=2)), σ $(round(std(Da_L), digits=2))")
println("Da_H: μ $(round(mean(Da_H), digits=2)), σ $(round(std(Da_H), digits=2))")

rts_HH = max.(rand(Dv_H, n_sim), rand(Da_H, n_sim))
rts_LH = max.(rand(Dv_L, n_sim), rand(Da_H, n_sim))
rts_HL = max.(rand(Dv_H, n_sim), rand(Da_L, n_sim))
rts_LL = max.(rand(Dv_L, n_sim), rand(Da_L, n_sim))

time_range = range(0, 1, length = 200)

f_ll = ecdf(rts_LL)
f_lh = ecdf(rts_LH)
f_hl = ecdf(rts_HL)
f_hh = ecdf(rts_HH)

sic = compute_sic(time_range; f_ll, f_lh, f_hl, f_hh)

plot(time_range, sic, xlabel = "RT [s]", ylabel = "SIC", linewidth = 1,
    grid = false, leg = false, framestyle = :box, ylims = (-0.25, 0.25),
    titlefontsize = 8, xaxis = font(10), yaxis = font(10))
hline!([0], color = :black, linestyle = :dash)

s_ll = survivor(f_ll, time_range)
s_lh = survivor(f_lh, time_range)
s_hl = survivor(f_hl, time_range)
s_hh = survivor(f_hh, time_range)

plot(time_range, s_ll, label = "LL", grid = false)
plot!(time_range, s_lh, label = "LH", grid = false)
plot!(time_range, s_hl, label = "HL", grid = false)
plot!(time_range, s_hh, label = "HH", grid = false)
