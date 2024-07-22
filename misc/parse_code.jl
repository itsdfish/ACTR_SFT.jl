################################################################################
#                               load dependencies
################################################################################
cd(@__DIR__)
cd("..")
using Code2String
################################################################################
#                               configure options
################################################################################
# an optional function for filtering. return true to keep
keep(r, d, f; valid_format) = any(x -> contains(f, x), valid_format)
output = ""
# valid formats to keep 
valid_format = [".md", ".lisp", ".jl", ".json"]
top_folders = [
    "analyses",
    "simulations",
    "simulation_output",
    "src",
    "test"
]
################################################################################
#                               extract code
################################################################################
for top_folder ∈ top_folders
    str = code2string(top_folder; keep, valid_format)
    output *= str
end
file = open("code.txt", "w")
write(file, output)
close(file)
# right click code.txt and select "save as pdf"
