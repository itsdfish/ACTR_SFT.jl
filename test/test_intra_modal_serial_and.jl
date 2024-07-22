@safetestset "intra-modality serial and" begin
    @safetestset "simulate_imdf" begin
        @safetestset "two stimuli" begin
            using ACTR_SFT
            using Test

            # response rule 
            rule = AND
            # salience effect 
            Δv = 0.020
            # distribution 
            dist = Fixed
            # model
            model = SerialACTR(; Δv, dist)

            base_rt = 0.58
            rt = simulate_imdf(model, rule, :N, :N)
            @test rt ≈ base_rt

            rt = simulate_imdf(model, rule, :L, :L)
            @test rt ≈ base_rt + Δv * 2

            rt = simulate_imdf(model, rule, :L, :H)
            @test rt ≈ base_rt

            rt = simulate_imdf(model, rule, :H, :L)
            @test rt ≈ base_rt

            rt = simulate_imdf(model, rule, :H, :H)
            @test rt ≈ base_rt - Δv * 2
        end

        @safetestset "1 stimulus" begin
            using ACTR_SFT
            using Test

            # response rule 
            rule = AND
            # salience effect 
            Δv = 0.020
            # distribution 
            dist = Fixed
            # model
            model = SerialACTR(; Δv, dist)

            base_rt = 0.445

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
            rule = AND
            # salience effect 
            Δv = 0.020
            # distribution 
            dist = Fixed
            # model
            model = SerialACTR(; Δv, dist)

            rt = simulate_imdf(model, rule, :absent, :absent)
            @test rt ≈ 0.310
        end
    end
end
