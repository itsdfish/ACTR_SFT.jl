@safetestset "cross-modality serial and" begin
    @safetestset "simulate_cmdf" begin
        @safetestset "two stimuli" begin
            using ACTR_SFT
            using Test

            # response rule 
            rule = AND
            # salience effect 
            Δv = 0.020
            Δa = 0.030
            # distribution 
            dist = Fixed
            # model
            model = SerialACTR(; Δv, Δa, dist)

            base_rt = 0.780
            rt = simulate_cmdf(model, rule, :N, :N)
            @test rt ≈ base_rt

            rt = simulate_cmdf(model, rule, :L, :L)
            @test rt ≈ base_rt + Δv + Δa

            rt = simulate_cmdf(model, rule, :L, :H)
            @test rt ≈ base_rt + Δv - Δa

            rt = simulate_cmdf(model, rule, :H, :L)
            @test rt ≈ base_rt - Δv + Δa

            rt = simulate_cmdf(model, rule, :H, :H)
            @test rt ≈ base_rt - Δv - Δa
        end

        @safetestset "1 stimulus" begin
            using ACTR_SFT
            using Test

            # response rule 
            rule = AND
            # salience effect 
            Δv = 0.020
            Δa = 0.030
            # distribution 
            dist = Fixed
            # model
            model = SerialACTR(; Δv, Δa, dist)

            base_rt_v = 0.445
            base_rt_a = 0.645

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
            rule = AND
            # salience effect 
            Δv = 0.020
            Δa = 0.030
            # distribution 
            dist = Fixed
            # model
            model = SerialACTR(; Δv, Δa, dist)

            rt = simulate_cmdf(model, rule, :absent, :absent)
            @test rt ≈ 0.310
        end
    end
end
