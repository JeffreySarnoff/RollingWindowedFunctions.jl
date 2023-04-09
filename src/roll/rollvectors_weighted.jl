#=
   basic_rolling(func, span, data1, weights) ..
   basic_rolling(func, span, data1, data2, data3, weights)

   padfirst_rolling(func, span, data1, weights; padding) ..
   padfirst_rolling(func, span, data1, data2, data3, weights; padding)

   padfinal_rolling(func, span, data1, weights; padding) ..
   padfinal_rolling(func, span, data1, data2, data3, weights; padding)

   basic_rolling(func, span, data1, data2, weights1, weights2) ..
   basic_rolling(func, span, data1, data2, data3, span, 
                            weights1, weights2, weights3)

   padfirst_rolling(func, span, data1, data2, weights1, weights2; padding) ..
   padfirst_rolling(func, span, data1, data2, data3, 
                            weights1, weights2, weights3, weights4; padding)

   padfinal_rolling(func, span, data1, data2, weights1, weights2; padding) ..
   padfinal_rolling(func, span, data1, data2, data3, 
                            weights1, weights2, weights3, weights4; padding)
=#

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T}, weights::AbstractWeights{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷweights = asview(weights)

    basic_rolling(func, span, ᵛʷdata1, ᵛʷweights)
end

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T}, data2::AbstractVector{T}, weights::AbstractWeights{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweights = asview(weights)

    basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweights)
end

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T}, data2::AbstractVector{T}, weights1::AbstractWeights{T}, weights2::AbstractWeights{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)

    basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweights1, ᵛʷweights2)
end

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, weights::AbstractWeights{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweights = asview(weights)

    basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweights)
end

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weights1::AbstractWeights{T}, weights2::AbstractWeights{T}, weights3::AbstractWeights{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)
    ᵛʷweights3 = asview(weights3)

    basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3)
end

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T}, weights::AbstractWeights{W}) where {T,W}
    typ = promote_type(T, W)
    ᵛʷdata1 = T === typ ? asview(data1) : [typ(x) for x in data1]
    ᵛʷweights = W === typ ? asview(weights) : [typ(x) for x in weights]

    basic_rolling(func, span, ᵛʷdata1, ᵛʷweights)
end

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, weights::AbstractWeights{W}) where {T1,T2,W}
    typ = promote_type(T1, T2, W)
    ᵛʷdata1 = T1 === typ ? asview(data1) : [typ(x) for x in data1]
    ᵛʷdata2 = T2 === typ ? asview(data2) : [typ(x) for x in data2]
    ᵛʷweights = W === typ ? asview(weights) : [typ(x) for x in weights]

    basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweights)
end

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, weights1::AbstractWeights{W1}, weights2::AbstractWeights{W2}) where {T1,T2,W1,W2}
    typ = promote_type(T1, T2, W1, W2)
    ᵛʷdata1 = T1 === typ ? asview(data1) : [typ(x) for x in data1]
    ᵛʷdata2 = T2 === typ ? asview(data2) : [typ(x) for x in data2]
    ᵛʷweights1 = W1 === typ ? asview(weights1) : [typ(x) for x in weights1]
    ᵛʷweights2 = W2 === typ ? asview(weights2) : [typ(x) for x in weights2]

    basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweights1, ᵛʷweights2)
end

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, weights::AbstractWeights{W}) where {T1,T2,T3,W}
    typ = promote_type(T1, T2, T3, W)
    ᵛʷdata1 = T1 === typ ? asview(data1) : [typ(x) for x in data1]
    ᵛʷdata2 = T2 === typ ? asview(data2) : [typ(x) for x in data2]
    ᵛʷdata3 = T3 === typ ? asview(data3) : [typ(x) for x in data3]
    ᵛʷweights = W === typ ? asview(weights) : [typ(x) for x in weights]

    basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweights)
end

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weights1::AbstractWeights{W1}, weights2::AbstractWeights{W2}, weights3::AbstractWeights{W3}) where {T1,T2,T3,W1,W2,W3}
    typ = promote_type(T1, T2, T3, W1, W2, W3)
    ᵛʷdata1 = T1 === typ ? asview(data1) : [typ(x) for x in data1]
    ᵛʷdata2 = T2 === typ ? asview(data2) : [typ(x) for x in data2]
    ᵛʷdata3 = T3 === typ ? asview(data3) : [typ(x) for x in data3]
    ᵛʷweights1 = W1 === typ ? asview(weights1) : [typ(x) for x in weights1]
    ᵛʷweights2 = W2 === typ ? asview(weights2) : [typ(x) for x in weights2]
    ᵛʷweights3 = W3 === typ ? asview(weights3) : [typ(x) for x in weights3]

    basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3)
end

# pad first

function padfirst_rolling(func::Function, span::Span, data1::AbstractVector{T},
    weights::AbstractWeights{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷweights = asview(weights)

    padfirst_rolling(func, span, ᵛʷdata1, ᵛʷweights, padding)
end

function padfirst_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T},
    weights::AbstractWeights{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweights = asview(weights)

    padfirst_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweights, padding)
end

function padfirst_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weights::AbstractWeights{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweights = asview(weights)

    padfirst_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweights, padding)
end


function padfirst_rolling(func::Function, span::Span,
    data1::AbstractVector{T}, weights::AbstractWeights{W}, padding) where {T,W}
    typ = promote_type(T, W)
    ᵛʷdata1 = T === typ ? asview(data1) : [typ(x) for x in data1]
    ᵛʷweights = W === typ ? asview(weights) : [typ(x) for x in weights]

    padfirst_rolling(func, span, ᵛʷdata1, ᵛʷweights, padding)
end

function padfirst_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, weights::AbstractWeights{W}, padding) where {T1,T2,W}
    typ = promote_type(T1, T2, W)
    ᵛʷdata1 = T1 === typ ? asview(data1) : [typ(x) for x in data1]
    ᵛʷdata2 = T2 === typ ? asview(data2) : [typ(x) for x in data2]
    ᵛʷweights = W === typ ? asview(weights) : [typ(x) for x in weights]

    padfirst_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweights, padding)
end

function padfirst_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, weights1::AbstractWeights{W1}, weights2::AbstractWeights{W2}, padding) where {T1,T2,W1,W2}
    typ = promote_type(T1, T2, W1, W2)
    ᵛʷdata1 = T1 === typ ? asview(data1) : [typ(x) for x in data1]
    ᵛʷdata2 = T2 === typ ? asview(data2) : [typ(x) for x in data2]
    ᵛʷweights1 = W1 === typ ? asview(weights1) : [typ(x) for x in weights1]
    ᵛʷweights2 = W2 === typ ? asview(weights2) : [typ(x) for x in weights2]

    padfirst_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweights1, ᵛʷweights2, padding)
end

function padfirst_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, weights::AbstractWeights{W}, padding) where {T1,T2,T3,W}
    typ = promote_type(T1, T2, T3, W)
    ᵛʷdata1 = T1 === typ ? asview(data1) : [typ(x) for x in data1]
    ᵛʷdata2 = T2 === typ ? asview(data2) : [typ(x) for x in data2]
    ᵛʷdata3 = T3 === typ ? asview(data3) : [typ(x) for x in data3]
    ᵛʷweights = W === typ ? asview(weights) : [typ(x) for x in weights]

    padfirst_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweights, padding)
end

function padfirst_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weights1::AbstractWeights{W1}, weights2::AbstractWeights{W2}, weights3::AbstractWeights{W3}, padding) where {T1,T2,T3,W1,W2,W3}
    typ = promote_type(T1, T2, T3, W1, W2, W3)
    ᵛʷdata1 = T1 === typ ? asview(data1) : [typ(x) for x in data1]
    ᵛʷdata2 = T2 === typ ? asview(data2) : [typ(x) for x in data2]
    ᵛʷdata3 = T3 === typ ? asview(data3) : [typ(x) for x in data3]
    ᵛʷweights1 = W1 === typ ? asview(weights1) : [typ(x) for x in weights1]
    ᵛʷweights2 = W2 === typ ? asview(weights2) : [typ(x) for x in weights2]
    ᵛʷweights3 = W3 === typ ? asview(weights3) : [typ(x) for x in weights3]

    padfirst_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3, padding)
end

# pad final


function padfinal_rolling(func::Function, span::Span, data1::AbstractVector{T},
    weights::AbstractWeights{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷweights = asview(weights)

    padfinal_rolling(func, span, ᵛʷdata1, ᵛʷweights, padding)
end

function padfinal_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T},
    weights::AbstractWeights{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweights = asview(weights)

    padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweights, padding)
end

function padfinal_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T},
    weights1::AbstractWeights{T}, weights2::AbstractWeights{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)

    padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweights1, ᵛʷweights2, padding)
end

function padfinal_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weights::AbstractWeights{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweights = asview(weights)

    padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweights, padding)
end

function padfinal_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weights1::AbstractWeights{T}, weights2::AbstractWeights{T}, weights3::AbstractWeights{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)
    ᵛʷweights3 = asview(weights3)

    padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3, padding)
end


function padfinal_rolling(func::Function, span::Span,
    data1::AbstractVector{T}, weights::AbstractWeights{W}, padding) where {T,W}
    typ = promote_type(T, W)
    ᵛʷdata1 = T === typ ? asview(data1) : [typ(x) for x in data1]
    ᵛʷweights = W === typ ? asview(weights) : [typ(x) for x in weights]

    padfinal_rolling(func, span, ᵛʷdata1, ᵛʷweights, padding)
end

function padfinal_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, weights::AbstractWeights{W}, padding) where {T1,T2,W}
    typ = promote_type(T1, T2, W)
    ᵛʷdata1 = T1 === typ ? asview(data1) : [typ(x) for x in data1]
    ᵛʷdata2 = T2 === typ ? asview(data2) : [typ(x) for x in data2]
    ᵛʷweights = W === typ ? asview(weights) : [typ(x) for x in weights]

    padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweights, padding)
end

function padfinal_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, weights1::AbstractWeights{W1}, weights2::AbstractWeights{W2}, padding) where {T1,T2,W1,W2}
    typ = promote_type(T1, T2, W1, W2)
    ᵛʷdata1 = T1 === typ ? asview(data1) : [typ(x) for x in data1]
    ᵛʷdata2 = T2 === typ ? asview(data2) : [typ(x) for x in data2]
    ᵛʷweights1 = W1 === typ ? asview(weights1) : [typ(x) for x in weights1]
    ᵛʷweights2 = W2 === typ ? asview(weights2) : [typ(x) for x in weights2]

    padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweights1, ᵛʷweights2, padding)
end

function padfinal_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, weights::AbstractWeights{W}, padding) where {T1,T2,T3,W}
    typ = promote_type(T1, T2, T3, W)
    ᵛʷdata1 = T1 === typ ? asview(data1) : [typ(x) for x in data1]
    ᵛʷdata2 = T2 === typ ? asview(data2) : [typ(x) for x in data2]
    ᵛʷdata3 = T3 === typ ? asview(data3) : [typ(x) for x in data3]
    ᵛʷweights = W === typ ? asview(weights) : [typ(x) for x in weights]

    padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweights, padding)
end

function padfinal_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weights1::AbstractWeights{W1}, weights2::AbstractWeights{W2}, weights3::AbstractWeights{W3}, padding) where {T1,T2,T3,W1,W2,W3}
    typ = promote_type(T1, T2, T3, W1, W2, W3)
    ᵛʷdata1 = T1 === typ ? asview(data1) : [typ(x) for x in data1]
    ᵛʷdata2 = T2 === typ ? asview(data2) : [typ(x) for x in data2]
    ᵛʷdata3 = T3 === typ ? asview(data3) : [typ(x) for x in data3]
    ᵛʷweights1 = W1 === typ ? asview(weights1) : [typ(x) for x in weights1]
    ᵛʷweights2 = W2 === typ ? asview(weights2) : [typ(x) for x in weights2]
    ᵛʷweights3 = W3 === typ ? asview(weights3) : [typ(x) for x in weights3]

    padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3, padding)
end


# IMPLEMENTATIONS

# basic_rolling implementations

function basic_rolling(func::Function, span::Span,
    ᵛʷdata1::ViewOfVector{T}, ᵛʷweights::ViewOfWeights{T}) where {T}
    n = length(ᵛʷdata1)
    nvalues = nrolled(n, span)

    rettype = rts(func, (Vector{T},))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, span
    @inline for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(func::Function, span::Span,
    ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷweights::ViewOfWeights{T}) where {T}

    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    nvalues = nrolled(n, span)

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, span
    @inline for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(func::Function, span::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T},
    ᵛʷweights::ViewOfWeights{T}) where {T}

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    nvalues = nrolled(n, span)

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, span

    @inline for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(func::Function, span::Span,
    data1::ViewOfMatrix{T}, weights::ViewOfWeights{W}) where {T,W}
    typ = promote_type(T, W)
    ᵛʷdata1 = T === typ ? asview(data1) : [typ(x) for x in data1]
    ᵛʷweights = W === typ ? asview(weights) : [typ(x) for x in weights]

    basic_rolling(func, span, ᵛʷdata1, ᵛʷweights)
end



# pad first implementations

function padfirst_rolling(func::Function, span::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷweights::ViewOfWeights{T}, padding) where {T}
    n = length(ᵛʷdata1)
    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = nvalues-padding_span:nvalues

    rettype = rts(func, (Vector{T},))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inline for idx in span:n
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfirst_rolling(func::Function, span::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T},
    ᵛʷweights::ViewOfWeights{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))

    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = nvalues-padding_span:nvalues

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inline for idx in 1:nvalues-padding_span
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfirst_rolling(func::Function, span::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T},
    ᵛʷweights::ViewOfWeights{T}, padding) where {T}

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))

    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = nvalues-padding_span:nvalues

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inline for idx in 1:nvalues-padding_span
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end


# pad final implementations

function padfinal_rolling(func::Function, span::Span, ᵛʷdata1::ViewOfVector{T},
    ᵛʷweights::ViewOfWeights{T}, padding) where {T}
    n = length(ᵛʷdata1)

    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = n-padding_span-1:n

    rettype = rts(func, (Vector{T},))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inline for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfinal_rolling(func::Function, span::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T},
    ᵛʷweights::ViewOfWeights{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))

    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = n-padding_span-1:n

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inline for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfinal_rolling(func::Function, span::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T},
    ᵛʷweights::ViewOfWeights{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))

    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = n-padding_span-1:n

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inline for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end


# =============================================


function basic_rolling(func::Function, span::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T},
    ᵛʷweights1::ViewOfWeights{T}, ᵛʷweights2::ViewOfWeights{T}, ᵛʷweights3::ViewOfWeights{T}) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    nvalues = nrolled(n, span)

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, span
    @inline for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights3)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end


# pad first

function padfirst_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T},
    weights1::AbstractWeights{T}, weights2::AbstractWeights{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2))

    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = nvalues-padding_span:nvalues

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inline for idx in 1:nvalues-padding_span
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights2)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfirst_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weights1::AbstractWeights{T}, weights2::AbstractWeights{T}, weights3::AbstractWeights{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)
    ᵛʷweights3 = asview(weights3)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))

    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = nvalues-padding_span:nvalues

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inline for idx in 1:nvalues-padding_span
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights3)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end


# pad last


function padfirst_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weights1::AbstractWeights{T}, weights2::AbstractWeights{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2))

    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = n-padding_span-1:n

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inline for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights2)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfinal_rolling(func::Function, span::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T},
    ᵛʷweights1::ViewOfWeights{T}, ᵛʷweights2::ViewOfWeights{T}, ᵛʷweights3::ViewOfWeights{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))

    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = n-padding_span-1:n

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inline for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights3)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end
