abstract type SFTModel end

abstract type ResponseRule end

struct AND <: ResponseRule end

struct OR <: ResponseRule end

"""
    Fixed
A type for a deterministic rt distribution 
"""
struct Fixed end

struct SerialACTR{D} <: SFTModel
    μv::Float64
    μa::Float64
    μcr::Float64
    μm::Float64
    Δa::Float64
    Δv::Float64
    dist::D
end

function SerialACTR(; μv = 0.085,
    μa = 0.285,
    μcr = 0.050,
    μm = 0.210,
    Δa = 0.020,
    Δv = 0.020,
    dist = Uniform
)
    return SerialACTR(μv, μa, μcr, μm, Δa, Δv, dist)
end

struct ParallelACTR{D} <: SFTModel
    μv::Float64
    μa::Float64
    μcr::Float64
    μm::Float64
    Δa::Float64
    Δv::Float64
    dist::D
end

function ParallelACTR(; μv = 0.085,
    μa = 0.285,
    μcr = 0.050,
    μm = 0.210,
    Δa = 0.020,
    Δv = 0.020,
    dist = Uniform
)
    return ParallelACTR(μv, μa, μcr, μm, Δa, Δv, dist)
end
struct Coactive <: SFTModel
    ν::Float64
    α::Float64
    τ::Float64
    Δ::Float64
end

Coactive(; ν, α, τ, Δ) = Coactive(ν, α, τ, Δ)
