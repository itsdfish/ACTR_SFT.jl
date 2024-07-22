using SafeTestsets

files = filter(f -> (f ≠ "runtests.jl") && (f ≠ "plot_test"), readdir())

include.(files)
