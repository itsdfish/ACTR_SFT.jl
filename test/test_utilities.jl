@safetestset "transform" begin
    using ACTR_SFT
    using Distributions
    using Random
    using Test

    using ACTR_SFT: transform

    Random.seed!(9854)

    for _ ∈ 1:20
        μ = rand(Uniform(0.05, 1))
        σ = rand(Uniform(0.05, 1))
        parms = transform(Gamma, μ, σ)
        @test μ ≈ mean(Gamma(parms...))
        @test σ ≈ std(Gamma(parms...))
    end
end

@safetestset "manipulate_salience" begin
    using ACTR_SFT
    using Test

    using ACTR_SFT: manipulate_salience

    μ = 0.100
    Δ = 0.02
    x = manipulate_salience(:L, μ, Δ)
    @test x ≈ 0.120

    μ = 0.100
    Δ = 0.02
    x = manipulate_salience(:H, μ, Δ)
    @test x ≈ 0.080

    μ = 0.100
    Δ = 0.02
    x = manipulate_salience(:Z, μ, Δ)
    @test x ≈ 0.100
end
