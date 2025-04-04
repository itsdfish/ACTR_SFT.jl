##################################################################################################################################
#                                               load packages
##################################################################################################################################
cd(@__DIR__)
using Pkg
Pkg.activate("..")
using Revise
using ACTR_SFT
using JSON
using Plots
using DataFrames
##################################################################################################################################
#                                               parse data
##################################################################################################################################
json_io =
    open("../simulation_output/gantt_plot_data/cross_modal_serial_and_gantt_data.json")
start_times, end_times, col_names = parse_module_activity(json_io)
close(json_io)
##################################################################################################################################
#                                               plot data
##################################################################################################################################
pyplot()
color_map(col) =
    col == "AURAL" ? RGB(116 / 255, 94 / 255, 181 / 255) :
    col == "VISUAL" ? RGB(66 / 255, 168 / 255, 114 / 255) :
    col == "PRODUCTION" ? RGB(66 / 255, 110 / 255, 168 / 255) :
    RGB(168 / 255, 72 / 255, 66 / 255)
col_map(col) =
    col == "AURAL" ? "Auditory" :
    col == "VISUAL" ? "Visual" : col == "PRODUCTION" ? "Procedural" : "Motor"
colors = color_map.(col_names)
col_names = col_map.(col_names)
df = DataFrame(
    label = col_names,
    start_time = start_times,
    end_time = end_times,
    color = colors
)
serial_plot = plot_gantt_chart(df; title = "Serial AND", titlefontsize = 8, xlabel = "")
##################################################################################################################################
#                                               parse data
##################################################################################################################################
json_io =
    open("../simulation_output/gantt_plot_data/cross_modal_parallel_and_gantt_data.json")
start_times, end_times, col_names = parse_module_activity(json_io)
close(json_io)
##################################################################################################################################
#                                               plot data
##################################################################################################################################
colors = color_map.(col_names)
col_names = col_map.(col_names)
df = DataFrame(
    label = col_names,
    start_time = start_times,
    end_time = end_times,
    color = colors
)
parallel_plot =
    plot_gantt_chart(df; title = "Parallel AND", titlefontsize = 8, xlims = (0, 0.80))

plot(serial_plot, parallel_plot, layout = (2, 1); size = (250, 200))
savefig("gantt_serial_parallel.eps")
