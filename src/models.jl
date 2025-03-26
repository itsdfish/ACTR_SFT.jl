"""
    simulate_experiment(model::SFTModel, run_experiment, rule, stimuli, n_sim)

Simulates a double factorial experiment for a given model, response rule, and experiment. The function factorially manipulates the stimuli
to create n_stimuli by n_stimuli conditions. 

# Arguments 

- `model::SFTModel`: a model designed for a double factorial experiment 
- `run_experiment`: an function for running a double factorial experiment, which expects (model, rule, stimulus1, stimulus2) 
- `rule`: a response rule
- `stimuli`: a collection of stimulus levels. Elements are expected to be symbols 
- `n_sim`: number of simulated responses per condition
"""
function simulate_experiment(model::SFTModel, run_experiment, rule, stimuli, n_sim)
    n_cond = length(stimuli)^2
    rts = fill(0.0, n_sim * n_cond)
    stimulus1 = fill(:_, n_sim * n_cond)
    stimulus2 = fill(:_, n_sim * n_cond)
    cnt = 1
    for s1 ∈ stimuli, s2 ∈ stimuli, _ ∈ 1:n_sim
        rts[cnt] = run_experiment(model, rule, s1, s2)
        stimulus1[cnt] = s1
        stimulus2[cnt] = s2
        cnt += 1
    end
    return (; stimulus1, stimulus2, rts)
end

function simulate_experiment(model::SFTModel, run_experiment, stimuli, n_sim)
    n_cond = length(stimuli)^2
    rts = fill(0.0, n_sim * n_cond)
    stimulus1 = fill(:_, n_sim * n_cond)
    stimulus2 = fill(:_, n_sim * n_cond)
    cnt = 1
    for s1 ∈ stimuli, s2 ∈ stimuli, _ ∈ 1:n_sim
        rts[cnt] = run_experiment(model, s1, s2)
        stimulus1[cnt] = s1
        stimulus2[cnt] = s2
        cnt += 1
    end
    return (; stimulus1, stimulus2, rts)
end

"""
    simulate_imdf(model::SerialACTR, ::Type{<:AND}, stimulus1, stimulus2)

Simulates a serial AND ACT-R model for the intra-modality double factorial experiment 

# Arguments 

- `model::SerialACTR`: serial ACT-R model 
- `::Type{<:AND}`: AND response rule
- `stimulus1`: a stimulus ∈ {:L,:H,:absent}
- `stimulus2`: a stimulus ∈ {:L,:H,:absent}
"""
function simulate_imdf(model::SerialACTR, ::Type{<:AND}, stimulus1, stimulus2)
    (; μv, μa, μcr, μm, Δa, Δv, dist) = model
    μv1 = manipulate_salience(stimulus1, μv, Δv)
    μv2 = manipulate_salience(stimulus2, μv, Δv)
    # both stimuli present 
    if (stimulus1 ≠ :absent) && (stimulus2 ≠ :absent)
        return rand_time(dist, μcr) + rand_time(dist, μv1) + rand_time(dist, μcr) +
               rand_time(dist, μcr) + rand_time(dist, μv2) + rand_time(dist, μcr) +
               rand_time(dist, μm)
    end
    # both stimuli absent 
    if (stimulus1 == :absent) && (stimulus2 == :absent)
        return rand_time(dist, μcr) + rand_time(dist, μcr) + rand_time(dist, μm)
    end
    # one stimulus present, one absent 
    _μv = stimulus1 ≠ :absent ? μv1 : μv2
    return rand_time(dist, μcr) + rand_time(dist, _μv) + rand_time(dist, μcr) +
           rand_time(dist, μcr) + rand_time(dist, μm)
end

"""
    simulate_imdf(model::SerialACTR, ::Type{<:OR}, stimulus1, stimulus2)

Simulates a serial OR ACT-R model for the intra-modality double factorial experiment 

# Arguments 

- `model::SerialACTR`: serial ACT-R model 
- `::Type{<:OR}`: OR response rule
- `stimulus1`: a stimulus ∈ {:L,:H,:absent}
- `stimulus2`: a stimulus ∈ {:L,:H,:absent}
"""
function simulate_imdf(model::SerialACTR, ::Type{<:OR}, stimulus1, stimulus2)
    (; μv, μa, μcr, μm, Δa, Δv, dist) = model
    μv1 = manipulate_salience(stimulus1, μv, Δv)
    μv2 = manipulate_salience(stimulus2, μv, Δv)

    # both stimuli present 
    if (stimulus1 ≠ :absent) && (stimulus2 ≠ :absent)
        _μv = rand() ≤ 0.50 ? μv1 : μv2
        return rand_time(dist, μcr) + rand_time(dist, _μv) + rand_time(dist, μcr) +
               rand_time(dist, μm)
    end
    # both stimuli absent 
    if (stimulus1 == :absent) && (stimulus2 == :absent)
        return rand_time(dist, μcr) + rand_time(dist, μcr) + rand_time(dist, μcr) +
               rand_time(dist, μm)
    end
    # one stimulus present, one absent 
    _μv = stimulus1 ≠ :absent ? μv1 : μv2
    return rand_time(dist, μcr) + rand_time(dist, _μv) + rand_time(dist, μcr) +
           rand_time(dist, μm)
end

"""
    simulate_cmdf(model::SerialACTR, ::Type{<:AND}, stimulus1, stimulus2)

Simulates a serial AND ACT-R model for the cross-modality double factorial experiment 

# Arguments 

- `model::SerialACTR`: serial ACT-R model 
- `::Type{<:AND}`: AND response rule
- `stimulus1`: a stimulus ∈ {:L,:H,:absent}
- `stimulus2`: a stimulus ∈ {:L,:H,:absent}
"""
function simulate_cmdf(model::SerialACTR, ::Type{<:AND}, stimulus1, stimulus2)
    (; μv, μa, μcr, μm, Δa, Δv, dist) = model
    μv1 = manipulate_salience(stimulus1, μv, Δv)
    μa1 = manipulate_salience(stimulus2, μa, Δa)

    # both stimuli present 
    if (stimulus1 ≠ :absent) && (stimulus2 ≠ :absent)
        return rand_time(dist, μcr) + rand_time(dist, μv1) + rand_time(dist, μcr) +
               rand_time(dist, μcr) +
               rand_time(dist, μa1) + rand_time(dist, μcr) + rand_time(dist, μm)
    end
    # both stimuli absent 
    if (stimulus1 == :absent) && (stimulus2 == :absent)
        return rand_time(dist, μcr) + rand_time(dist, μcr) + rand_time(dist, μm)
    end
    # one stimulus present, one absent 
    _μ = stimulus1 ≠ :absent ? μv1 : μa1
    return rand_time(dist, μcr) + rand_time(dist, _μ) + rand_time(dist, μcr) +
           rand_time(dist, μcr) + rand_time(dist, μm)
end

"""
    simulate_cmdf(model::SerialACTR, ::Type{<:OR}, stimulus1, stimulus2)

Simulates a serial OR ACT-R model for the cross-modality double factorial experiment 

# Arguments 

- `model::SerialACTR`: serial ACT-R model 
- `::Type{<:OR}`: OR response rule
- `stimulus1`: a stimulus ∈ {:L,:H,:absent}
- `stimulus2`: a stimulus ∈ {:L,:H,:absent}
"""
function simulate_cmdf(model::SerialACTR, ::Type{<:OR}, stimulus1, stimulus2)
    (; μv, μa, μcr, μm, Δa, Δv, dist) = model
    μv1 = manipulate_salience(stimulus1, μv, Δv)
    μa1 = manipulate_salience(stimulus2, μa, Δa)

    # both stimuli present 
    if (stimulus1 ≠ :absent) && (stimulus2 ≠ :absent)
        μ = rand() ≤ 0.50 ? μv1 : μa1
        return rand_time(dist, μcr) + rand_time(dist, μ) + rand_time(dist, μcr) +
               rand_time(dist, μm)
    end
    # both stimuli absent 
    if (stimulus1 == :absent) && (stimulus2 == :absent)
        return rand_time(dist, μcr) + rand_time(dist, μcr) + rand_time(dist, μcr) +
               rand_time(dist, μm)
    end
    # one stimulus present, one absent 
    μ = stimulus1 ≠ :absent ? μv1 : μa1
    return rand_time(dist, μcr) + rand_time(dist, μ) + rand_time(dist, μcr) +
           rand_time(dist, μm)
end

"""
    simulate_cmdf(model::ParallelACTR, ::Type{<:AND}, stimulus1, stimulus2)

Simulates a parallel AND ACT-R model for the cross-modality double factorial experiment 

# Arguments 

- `model::SerialACTR`: serial ACT-R model 
- `::Type{<:AND}`: AND response rule
- `stimulus1`: a stimulus ∈ {:L,:H,:absent}
- `stimulus2`: a stimulus ∈ {:L,:H,:absent}
"""
function simulate_cmdf(model::ParallelACTR, ::Type{<:AND}, stimulus1, stimulus2)
    (; μv, μa, μcr, μm, Δa, Δv, dist) = model
    μv1 = manipulate_salience(stimulus1, μv, Δv)
    μa1 = manipulate_salience(stimulus2, μa, Δa)

    # both stimuli present 
    if (stimulus1 ≠ :absent) && (stimulus2 ≠ :absent)
        return rand_time(dist, μcr) + max(rand_time(dist, μv1), rand_time(dist, μa1)) +
               rand_time(dist, μcr) + rand_time(dist, μm)
    end
    # both stimuli absent 
    if (stimulus1 == :absent) && (stimulus2 == :absent)
        return rand_time(dist, μcr) + rand_time(dist, μcr) + rand_time(dist, μm)
    end
    # one stimulus present, one absent 
    μ = stimulus1 ≠ :absent ? μv1 : μa1
    return rand_time(dist, μcr) + rand_time(dist, μ) + rand_time(dist, μcr) +
           rand_time(dist, μm)
end

"""
    simulate_cmdf(model::ParallelACTR, ::Type{<:OR}, stimulus1, stimulus2)

Simulates a parallel OR ACT-R model for the cross-modality double factorial experiment 

# Arguments 

- `model::SerialACTR`: serial ACT-R model 
- `::Type{<:OR}`: OR response rule
- `stimulus1`: a stimulus ∈ {:L,:H,:absent}
- `stimulus2`: a stimulus ∈ {:L,:H,:absent}
"""
function simulate_cmdf(model::ParallelACTR, ::Type{<:OR}, stimulus1, stimulus2)
    (; μv, μa, μcr, μm, Δa, Δv, dist) = model
    μv1 = manipulate_salience(stimulus1, μv, Δv)
    μa1 = manipulate_salience(stimulus2, μa, Δa)

    # both stimuli present 
    if (stimulus1 ≠ :absent) && (stimulus2 ≠ :absent)
        return rand_time(dist, μcr) + min(rand_time(dist, μv1), rand_time(dist, μa1)) +
               rand_time(dist, μcr) + rand_time(dist, μm)
    end
    # both stimuli absent 
    if (stimulus1 == :absent) && (stimulus2 == :absent)
        return rand_time(dist, μcr) + rand_time(dist, μcr) + rand_time(dist, μm)
    end
    # one stimulus present, one absent 
    μ = stimulus1 ≠ :absent ? μv1 : μa1
    return rand_time(dist, μcr) + rand_time(dist, μ) + rand_time(dist, μcr) +
           rand_time(dist, μm)
end

function simulate_imdf(model::Coactive, stimulus1, stimulus2)
    (; ν, α, τ, Δ) = model
    μv1 = manipulate_salience(stimulus1, ν, Δ)
    μv2 = manipulate_salience(stimulus2, ν, Δ)
    μv12 = μv1 + μv2

    # both stimuli present 
    if (stimulus1 ≠ :absent) && (stimulus2 ≠ :absent)
        return rand(Wald(μv12, α, τ))
    end
    # both stimuli absent 
    if (stimulus1 == :absent) && (stimulus2 == :absent)
        return rand(Wald(μv12, α, τ))
    end
    # one stimulus present, one absent 
    _μv = stimulus1 ≠ :absent ? μv1 : μv2
    return rand(Wald(_μv, α, τ))
end

manipulate_salience(stimulus, μ, Δ) = stimulus == :H ? μ - Δ : stimulus == :L ? μ + Δ : μ

rand_time(dist::Type{<:Uniform}, μ) = rand(dist(μ * 2 / 3, μ * 4 / 3))

rand_time(dist::Type{<:Fixed}, μ) = μ

function rand_time(dist::Type{<:Gamma}, μ)
    σ = std(Uniform(μ * 2 / 3, μ * 4 / 3))
    α, θ = transform(dist, μ, σ)
    return rand(Gamma(α, θ))
end

transform(dist::Type{<:Gamma}, μ, σ) = (; α = (μ^2) / (σ^2), θ = (σ^2) / μ)
