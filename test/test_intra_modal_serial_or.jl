@safetestset "intra-modality serial or" begin
    @safetestset "simulate_imdf" begin
        @safetestset "two stimuli" begin
            using ACTR_SFT
            using Random
            using Test

            Random.seed!(87)

            # response rule 
            rule = OR
            # salience effect 
            Δv = 0.020
            # distribution 
            dist = Fixed
            # model
            model = SerialACTR(; Δv, dist)

            base_rt = 0.395
            rt = simulate_imdf(model, rule, :N, :N)
            @test rt ≈ base_rt

            rt = simulate_imdf(model, rule, :L, :L)
            @test rt ≈ base_rt + Δv

            rts = unique(map(_ -> simulate_imdf(model, rule, :L, :H), 1:10))
            @test length(rts) == 2
            @test minimum(rts) ≈ base_rt - Δv
            @test maximum(rts) ≈ base_rt + Δv

            rts = unique(map(_ -> simulate_imdf(model, rule, :H, :L), 1:10))
            @test length(rts) == 2
            @test minimum(rts) ≈ base_rt - Δv
            @test maximum(rts) ≈ base_rt + Δv

            rt = simulate_imdf(model, rule, :H, :H)
            @test rt ≈ base_rt - Δv
        end

        @safetestset "1 stimulus" begin
            using ACTR_SFT
            using Test

            # response rule 
            rule = OR
            # salience effect 
            Δv = 0.020
            # distribution 
            dist = Fixed
            # model
            model = SerialACTR(; Δv, dist)

            base_rt = 0.395

            rt = simulate_imdf(model, rule, :N, :absent)
            @test rt ≈ base_rt

            rt = simulate_imdf(model, rule, :absent, :N)
            @test rt ≈ base_rt

            rt = simulate_imdf(model, rule, :L, :absent)
            @test rt ≈ base_rt + Δv

            rt = simulate_imdf(model, rule, :absent, :L)
            @test rt ≈ base_rt + Δv

            rt = simulate_imdf(model, rule, :H, :absent)
            @test rt ≈ base_rt - Δv

            rt = simulate_imdf(model, rule, :absent, :H)
            @test rt ≈ base_rt - Δv
        end

        @safetestset "no stimuli" begin
            using ACTR_SFT
            using Test

            # response rule 
            rule = OR
            # salience effect 
            Δv = 0.020
            # distribution 
            dist = Fixed
            # model
            model = SerialACTR(; Δv, dist)

            rt = simulate_imdf(model, rule, :absent, :absent)
            @test rt ≈ 0.360
        end
    end
end
