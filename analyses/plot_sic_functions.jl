##################################################################################################################################
#                                               load packages
##################################################################################################################################
cd(@__DIR__)
using Pkg
Pkg.activate("..")
using Revise
using ACTR_SFT
using CSV
using DataFrames
using Plots
using StatsBase
pyplot()
##################################################################################################################################
#                                       intra modal serial and model
##################################################################################################################################
df = CSV.read(
    "../simulation_output/simulated_rts/intra_modality_serial_and_model.csv",
    DataFrame
)
df.present1 = map(x -> x == "NIL" ? false : true, df.visual1)
df.present2 = map(x -> x == "NIL" ? false : true, df.visual2)

df.condition = map((x, y) -> map_condition(x, y), df.visual1, df.visual2)

time_range = range(0.2, 1.0, length = 500)
df_LL = filter(x -> x.condition == "LL", df)
df_LH = filter(x -> x.condition == "LH", df)
df_HL = filter(x -> x.condition == "HL", df)
df_HH = filter(x -> x.condition == "HH", df)

f_ll = ecdf(df_LL.rt)
f_lh = ecdf(df_LH.rt)
f_hl = ecdf(df_HL.rt)
f_hh = ecdf(df_HH.rt)

sic =
    (survivor(f_ll, time_range) .- survivor(f_lh, time_range)) .-
    (survivor(f_hl, time_range) .- survivor(f_hh, time_range))

p1 = plot(time_range,
    sic,
    color = :black,
    grid = false,
    leg = false,
    framestyle = :box,
    ylims = (-0.2, 0.2),
    title = "IM S AND")
hline!([0.0], linestyle = :dash, color = :black)
##################################################################################################################################
#                                       intra modal serial or model
##################################################################################################################################
df = CSV.read(
    "../simulation_output/simulated_rts/intra_modality_serial_or_model.csv",
    DataFrame
)
df.present1 = map(x -> x == "NIL" ? false : true, df.visual1)
df.present2 = map(x -> x == "NIL" ? false : true, df.visual2)
df.condition = map((x, y) -> map_condition(x, y), df.visual1, df.visual2)

time_range = range(0.2, 1.0, length = 500)
df_LL = filter(x -> x.condition == "LL", df)
df_LH = filter(x -> x.condition == "LH", df)
df_HL = filter(x -> x.condition == "HL", df)
df_HH = filter(x -> x.condition == "HH", df)

f_ll = ecdf(df_LL.rt)
f_lh = ecdf(df_LH.rt)
f_hl = ecdf(df_HL.rt)
f_hh = ecdf(df_HH.rt)

sic =
    (survivor(f_ll, time_range) .- survivor(f_lh, time_range)) .-
    (survivor(f_hl, time_range) .- survivor(f_hh, time_range))

p2 = plot(time_range,
    sic,
    color = :black,
    grid = false,
    leg = false,
    framestyle = :box,
    ylims = (-0.2, 0.2),
    title = "IM S OR")
hline!([0.0], linestyle = :dash, color = :black)
##################################################################################################################################
#                                       cross modal serial and model
##################################################################################################################################
df = CSV.read(
    "../simulation_output/simulated_rts/cross_modality_serial_and_model.csv",
    DataFrame
)
df.present1 = map(x -> x == "NIL" ? false : true, df.visual)
df.present2 = map(x -> x == "NIL" ? false : true, df.auditory)
df.condition = map((x, y) -> map_condition(x, y), df.visual, df.auditory)

time_range = range(0.2, 1.0, length = 500)
df_LL = filter(x -> x.condition == "LL", df)
df_LH = filter(x -> x.condition == "LH", df)
df_HL = filter(x -> x.condition == "HL", df)
df_HH = filter(x -> x.condition == "HH", df)

f_ll = ecdf(df_LL.rt)
f_lh = ecdf(df_LH.rt)
f_hl = ecdf(df_HL.rt)
f_hh = ecdf(df_HH.rt)

sic =
    (survivor(f_ll, time_range) .- survivor(f_lh, time_range)) .-
    (survivor(f_hl, time_range) .- survivor(f_hh, time_range))

p3 = plot(time_range,
    sic,
    color = :black,
    grid = false,
    leg = false,
    framestyle = :box,
    ylims = (-0.2, 0.2),
    title = "CM S AND")
hline!([0.0], linestyle = :dash, color = :black)
##################################################################################################################################
#                                       cross modal serial or model
##################################################################################################################################
df = CSV.read(
    "../simulation_output/simulated_rts/cross_modality_serial_or_model.csv",
    DataFrame
)
df.present1 = map(x -> x == "NIL" ? false : true, df.visual)
df.present2 = map(x -> x == "NIL" ? false : true, df.auditory)
df.condition = map((x, y) -> map_condition(x, y), df.visual, df.auditory)

time_range = range(0.2, 1.0, length = 500)
df_LL = filter(x -> x.condition == "LL", df)
df_LH = filter(x -> x.condition == "LH", df)
df_HL = filter(x -> x.condition == "HL", df)
df_HH = filter(x -> x.condition == "HH", df)

f_ll = ecdf(df_LL.rt)
f_lh = ecdf(df_LH.rt)
f_hl = ecdf(df_HL.rt)
f_hh = ecdf(df_HH.rt)

sic =
    (survivor(f_ll, time_range) .- survivor(f_lh, time_range)) .-
    (survivor(f_hl, time_range) .- survivor(f_hh, time_range))

p4 = plot(time_range,
    sic,
    color = :black,
    grid = false,
    leg = false,
    framestyle = :box,
    ylims = (-0.2, 0.2),
    title = "CM S OR")
hline!([0.0], linestyle = :dash, color = :black)
##################################################################################################################################
#                                       cross modal parallel and model
##################################################################################################################################
df = CSV.read(
    "../simulation_output/simulated_rts/cross_modality_parallel_and_model.csv",
    DataFrame
)
df.present1 = map(x -> x == "NIL" ? false : true, df.visual)
df.present2 = map(x -> x == "NIL" ? false : true, df.auditory)
df.condition = map((x, y) -> map_condition(x, y), df.visual, df.auditory)

time_range = range(0.2, 1.0, length = 500)
df_LL = filter(x -> x.condition == "LL", df)
df_LH = filter(x -> x.condition == "LH", df)
df_HL = filter(x -> x.condition == "HL", df)
df_HH = filter(x -> x.condition == "HH", df)

f_ll = ecdf(df_LL.rt)
f_lh = ecdf(df_LH.rt)
f_hl = ecdf(df_HL.rt)
f_hh = ecdf(df_HH.rt)

sic =
    (survivor(f_ll, time_range) .- survivor(f_lh, time_range)) .-
    (survivor(f_hl, time_range) .- survivor(f_hh, time_range))

p5 = plot(time_range,
    sic,
    color = :black,
    grid = false,
    leg = false,
    framestyle = :box,
    ylims = (-0.2, 0.2),
    title = "CM P AND")
hline!([0.0], linestyle = :dash, color = :black)
combine(groupby(df, :condition), :rt => mean)
##################################################################################################################################
#                                       cross modal parallel or model
##################################################################################################################################
df = CSV.read(
    "../simulation_output/simulated_rts/cross_modality_parallel_or_model.csv",
    DataFrame
)
df.present1 = map(x -> x == "NIL" ? false : true, df.visual)
df.present2 = map(x -> x == "NIL" ? false : true, df.auditory)
df.condition = map((x, y) -> map_condition(x, y), df.visual, df.auditory)

time_range = range(0.2, 1.0, length = 500)
df_LL = filter(x -> x.condition == "LL", df)
df_LH = filter(x -> x.condition == "LH", df)
df_HL = filter(x -> x.condition == "HL", df)
df_HH = filter(x -> x.condition == "HH", df)

f_ll = ecdf(df_LL.rt)
f_lh = ecdf(df_LH.rt)
f_hl = ecdf(df_HL.rt)
f_hh = ecdf(df_HH.rt)

sic =
    (survivor(f_ll, time_range) .- survivor(f_lh, time_range)) .-
    (survivor(f_hl, time_range) .- survivor(f_hh, time_range))

p6 = plot(time_range,
    sic,
    color = :black,
    grid = false,
    leg = false,
    framestyle = :box,
    ylims = (-0.2, 0.2),
    title = "CM P OR")

hline!([0.0], linestyle = :dash, color = :black)

plot(p1, p2, p3, p4, p5, p6, layout = (3, 2), size = (340, 300),
    dpi = 300, titlefontsize = 9)
savefig("sic_plots.eps")
