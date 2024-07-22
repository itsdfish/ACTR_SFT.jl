"""
    compute_sic(df, time_range)

Computes the survivor interaction contrast across a specified time range. 

The expected data input is a `DataFrame` of the following form:

```julia 
Row │ stimulus1  stimulus2  rts
    │ Symbol     Symbol     Float64
────┼────────────────────────────────
1 │ H          H          0.54511
2 │ H          H          0.600605
3 │ H          H          0.513032
4 │ H          H          0.483171
5 │ H          H          0.519241
6 │ H          H          0.53945
7 │ H          H          0.623189
```
where symbols :H, :L and :absent are stimulus values for high salience, low salience and absent. 

# Arguments

- `df`: a `DataFrame` containing rts and stimulus values 
- `time_range`: a time range to compute the SIC 
"""
function compute_sic(df, time_range)
    df_LL = filter(x -> (x.stimulus1 == :L) && (x.stimulus2 == :L), df)
    df_LH = filter(x -> (x.stimulus1 == :L) && (x.stimulus2 == :H), df)
    df_HL = filter(x -> (x.stimulus1 == :H) && (x.stimulus2 == :L), df)
    df_HH = filter(x -> (x.stimulus1 == :H) && (x.stimulus2 == :H), df)

    f_ll = ecdf(df_LL.rts)
    f_lh = ecdf(df_LH.rts)
    f_hl = ecdf(df_HL.rts)
    f_hh = ecdf(df_HH.rts)
    return compute_sic(time_range; f_ll, f_lh, f_hl, f_hh)
end

function compute_sic(time_range; f_ll, f_lh, f_hl, f_hh)
    return (survivor(f_ll, time_range) .- survivor(f_lh, time_range)) .-
           (survivor(f_hl, time_range) .- survivor(f_hh, time_range))
end

survivor(f, t) = 1 .- f(t)

"""
    compute_and_capacity(df, time_range; level=:L)

Computes the AND workload copacity coefficient across a specified time range. By default, the AND workload capacity is 
computed for low salience. 

The expected data input is a `DataFrame` of the following form:

```julia 
Row │ stimulus1  stimulus2  rts
    │ Symbol     Symbol     Float64
────┼────────────────────────────────
1 │ H          H          0.54511
2 │ H          H          0.600605
3 │ H          H          0.513032
4 │ H          H          0.483171
5 │ H          H          0.519241
6 │ H          H          0.53945
7 │ H          H          0.623189
```
where symbols :H, :L and :absent are stimulus values for high salience, low salience and absent. 

# Arguments

- `df`: a `DataFrame` containing rts and stimulus values 
- `time_range`: a time range to compute the SIC 

# Keywords

- `level=:L`: the salience level at which the AND workload capacity is computed
"""
function compute_and_capacity(df, time_range; level = :L)
    # extract workload conditions for low salience
    df_LL = filter(x -> (x.stimulus1 == level) && (x.stimulus2 == level), df)
    df_LA = filter(x -> (x.stimulus1 == level) && (x.stimulus2 == :absent), df)
    df_AL = filter(x -> (x.stimulus1 == :absent) && (x.stimulus2 == level), df)

    # create empirical cdfs
    f_ll = ecdf(df_LL.rts)
    f_la = ecdf(df_LA.rts)
    f_al = ecdf(df_AL.rts)

    # compute workload
    return compute_and_capacity(f_ll, (f_la, f_al), time_range)
end

function compute_and_capacity(cdf_sim, cdf_sep, t_range)
    v_sim = map(t -> CRHF((cdf_sim,), t), t_range)
    v_sep = map(t -> CRHF(cdf_sep, t), t_range)
    return v_sim .- v_sep
end

function CRHF(cdf_funs, t)
    return mapreduce(f -> log(f(t)), +, cdf_funs)
end

"""
    compute_or_capacity(df, time_range; level=:L)

Computes the OR workload copacity coefficient across a specified time range. By default, the OR workload capacity is 
computed for low salience. 

The expected data input is a `DataFrame` of the following form:

```julia 
Row │ stimulus1  stimulus2  rts
    │ Symbol     Symbol     Float64
────┼────────────────────────────────
1 │ H          H          0.54511
2 │ H          H          0.600605
3 │ H          H          0.513032
4 │ H          H          0.483171
5 │ H          H          0.519241
6 │ H          H          0.53945
7 │ H          H          0.623189
```
where symbols :H, :L and :absent are stimulus values for high salience, low salience and absent. 

# Arguments

- `df`: a `DataFrame` containing rts and stimulus values 
- `time_range`: a time range to compute the SIC 

# Keywords

- `level=:L`: the salience level at which the OR workload capacity is computed
"""
function compute_or_capacity(df, time_range; level = :L)
    # extract workload conditions for low salience
    df_LL = filter(x -> (x.stimulus1 == level) && (x.stimulus2 == level), df)
    df_LA = filter(x -> (x.stimulus1 == level) && (x.stimulus2 == :absent), df)
    df_AL = filter(x -> (x.stimulus1 == :absent) && (x.stimulus2 == level), df)

    # create empirical cdfs
    f_ll = ecdf(df_LL.rts)
    f_la = ecdf(df_LA.rts)
    f_al = ecdf(df_AL.rts)

    # compute workload
    return compute_or_capacity(f_ll, (f_la, f_al), time_range)
end

function compute_or_capacity(cdf_sim, cdf_sep, t_range)
    v_sim = map(t -> CHF((cdf_sim,), t), t_range)
    v_sep = map(t -> CHF(cdf_sep, t), t_range)
    return v_sim .- v_sep
end

function CHF(cdf_funs, t)
    return mapreduce(f -> -log(1 - f(t)), +, cdf_funs)
end
