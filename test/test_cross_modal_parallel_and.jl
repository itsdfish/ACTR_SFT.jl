@safetestset "cross-modality parallel and" begin
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
            model = ParallelACTR(; Δv, Δa, dist)

            base_rt = 0.595
            rt = simulate_cmdf(model, rule, :N, :N)
            @test rt ≈ base_rt

            rt = simulate_cmdf(model, rule, :L, :L)
            @test rt ≈ base_rt + Δa

            rt = simulate_cmdf(model, rule, :L, :H)
            @test rt ≈ base_rt - Δa

            rt = simulate_cmdf(model, rule, :H, :L)
            @test rt ≈ base_rt + Δa

            rt = simulate_cmdf(model, rule, :H, :H)
            @test rt ≈ base_rt - Δa
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
            model = ParallelACTR(; Δv, Δa, dist)

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
            rule = AND
            # salience effect 
            Δv = 0.020
            Δa = 0.030
            # distribution 
            dist = Fixed
            # model
            model = ParallelACTR(; Δv, Δa, dist)

            rt = simulate_cmdf(model, rule, :absent, :absent)
            @test rt ≈ 0.310
        end
    end

    @safetestset "compare lisp ACT-R" begin
        using ACTR_SFT
        using Test
        using DataFrames
        using Statistics

        lisp_values = (AA = 0.31,
            AH = 0.57,
            AL = 0.61,
            LA = 0.42,
            LH = 0.57,
            LL = 0.61,
            HA = 0.38,
            HH = 0.57,
            HL = 0.62)

        # salience effect
        Δv = 0.020
        Δa = 0.020
        # stimulus conditions
        stimuli = (:H, :L, :absent)
        # number of simulations 
        n_sim = 10_000
        # response rule 
        rule = AND
        # model
        model = ParallelACTR(; Δv, Δa)

        sim_data = simulate_experiment(model, simulate_cmdf, rule, stimuli, n_sim)
        df = DataFrame(sim_data)
        df_means = combine(groupby(df, [:stimulus1, :stimulus2]), :rts => mean)

        df_row = filter(x -> (x.stimulus1 == :H) && (x.stimulus2 == :H), df_means)
        @test df_row.rts_mean[1] ≈ lisp_values[:HH] atol = 0.01

        df_row = filter(x -> (x.stimulus1 == :H) && (x.stimulus2 == :L), df_means)
        @test df_row.rts_mean[1] ≈ lisp_values[:HL] atol = 0.01

        df_row = filter(x -> (x.stimulus1 == :L) && (x.stimulus2 == :H), df_means)
        @test df_row.rts_mean[1] ≈ lisp_values[:LH] atol = 0.01

        df_row = filter(x -> (x.stimulus1 == :L) && (x.stimulus2 == :L), df_means)
        @test df_row.rts_mean[1] ≈ lisp_values[:LL] atol = 0.01

        df_row = filter(x -> (x.stimulus1 == :absent) && (x.stimulus2 == :H), df_means)
        @test df_row.rts_mean[1] ≈ lisp_values[:AH] atol = 0.01

        df_row = filter(x -> (x.stimulus1 == :H) && (x.stimulus2 == :absent), df_means)
        @test df_row.rts_mean[1] ≈ lisp_values[:HA] atol = 0.01

        df_row = filter(x -> (x.stimulus1 == :L) && (x.stimulus2 == :absent), df_means)
        @test df_row.rts_mean[1] ≈ lisp_values[:LA] atol = 0.01

        df_row = filter(x -> (x.stimulus1 == :absent) && (x.stimulus2 == :L), df_means)
        @test df_row.rts_mean[1] ≈ lisp_values[:AL] atol = 0.01

        df_row = filter(x -> (x.stimulus1 == :absent) && (x.stimulus2 == :absent), df_means)
        @test df_row.rts_mean[1] ≈ lisp_values[:AA] atol = 0.01
    end
end
