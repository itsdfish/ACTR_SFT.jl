@safetestset "cross-modality serial or" begin
    @safetestset "simulate_cmdf" begin
        @safetestset "two stimuli" begin
            using ACTR_SFT
            using Random
            using Test

            Random.seed!(711)

            # response rule 
            rule = OR
            # salience effect 
            Δv = 0.020
            Δa = 0.030
            # distribution 
            dist = Fixed
            # model
            model = SerialACTR(; Δv, Δa, dist)

            base_rt_v = 0.395
            base_rt_a = 0.595

            rts = unique(map(_ -> simulate_cmdf(model, rule, :N, :N), 1:10))
            @test length(rts) == 2
            @test minimum(rts) ≈ base_rt_v
            @test maximum(rts) ≈ base_rt_a

            rts = unique(map(_ -> simulate_cmdf(model, rule, :L, :L), 1:10))
            @test length(rts) == 2
            @test minimum(rts) ≈ base_rt_v + Δv
            @test maximum(rts) ≈ base_rt_a + Δa

            rts = unique(map(_ -> simulate_cmdf(model, rule, :L, :H), 1:10))
            @test length(rts) == 2
            @test minimum(rts) ≈ base_rt_v + Δv
            @test maximum(rts) ≈ base_rt_a - Δa

            rts = unique(map(_ -> simulate_cmdf(model, rule, :H, :L), 1:10))
            @test length(rts) == 2
            @test minimum(rts) ≈ base_rt_v - Δv
            @test maximum(rts) ≈ base_rt_a + Δa

            rts = unique(map(_ -> simulate_cmdf(model, rule, :H, :H), 1:10))
            @test length(rts) == 2
            @test minimum(rts) ≈ base_rt_v - Δv
            @test maximum(rts) ≈ base_rt_a - Δa
        end

        @safetestset "1 stimulus" begin
            using ACTR_SFT
            using Test

            # response rule 
            rule = OR
            # salience effect 
            Δv = 0.020
            Δa = 0.030
            # distribution 
            dist = Fixed
            # model
            model = SerialACTR(; Δv, Δa, dist)

            base_rt_v = 0.395
            base_rt_a = 0.595

            rt = simulate_cmdf(model, rule, :N, :absent)
            @test rt ≈ base_rt_v

            rt = simulate_cmdf(model, rule, :absent, :N)
            @test rt ≈ base_rt_a

            rt = simulate_cmdf(model, rule, :L, :absent)
            @test rt ≈ base_rt_v + Δv

            rt = simulate_cmdf(model, rule, :absent, :L)
            @test rt ≈ base_rt_a + Δa

            rt = simulate_cmdf(model, rule, :H, :absent)
            @test rt ≈ base_rt_v - Δv

            rt = simulate_cmdf(model, rule, :absent, :H)
            @test rt ≈ base_rt_a - Δa
        end

        @safetestset "no stimuli" begin
            using ACTR_SFT
            using Test

            # response rule 
            rule = OR
            # salience effect 
            Δv = 0.020
            Δa = 0.030
            # distribution 
            dist = Fixed
            # model
            model = SerialACTR(; Δv, Δa, dist)

            rt = simulate_cmdf(model, rule, :absent, :absent)
            @test rt ≈ 0.360
        end
    end
end
