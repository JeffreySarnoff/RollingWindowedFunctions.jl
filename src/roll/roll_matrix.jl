function basic_rolling(fn::F, width::Integer, data::AbstractMatrix{T}) where {T, F<:Function}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues = rolling_wholes(n, width)
    # there are 1 or more columns, each holds `n` values
    rettype = rts(fn, (T,))
    results = Matrix{rettype}(undef, (nvalues, ncols(ᵛʷdata)))

    ilow, ihigh = 1, width
    @inbounds for idx in eachindex(eachrow(results))
        @views results[idx, :] .= map(fn, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad the dropped indicies with a given padding value

function padfirst_rolling(fn::F, width::Integer, data::AbstractMatrix{T}, padding) where {T, F<:Function}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues = rolling_wholes(n, width)
    rettype = Union{typeof(padding),rts(fn, (T,))}
    results = Matrix{rettype}(undef, (nvalues, ncols(ᵛʷdata)))

    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt fn
    # this is the padding_width
    padding_width = width - 1
    padding_idxs = 1:padding_width

    results = Matrix{Union{typeof(padding),rettype}}(undef, size(ᵛʷdata))
    results[padding_idxs, :] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views results[idx, :] .= map(fn, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad the last entries, move windowed data back to the first entries

function padfinal_rolling(fn::F, width::Integer, data::AbstractMatrix{T}, padding) where {T, F<:Function}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues = rolling_wholes(n, width)
    rettype = Union{typeof(padding),rts(fn, (T,))}

    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt fn
    # this is the padding_width
    padding_width = width - 1
    padding_idxs = n-padding_width:n

    results = Matrix{rettype}(undef, size(ᵛʷdata))
    results[padding_idxs, :] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in 1:n-padding_width
        @views results[idx, :] = map(fn, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# weighted

function basic_rolling(fn::F, width::Integer,
                       data::AbstractMatrix{T}, weighting::AbstractWeights{T}) where {T, F<:Function}
    colcount = ncols(data)
    mweights = vmatrix(weighting, colcount)

    basic_rolling(fn, width, data, mweights)
end

function basic_rolling(fn::F, width::Integer,
                       data::AbstractMatrix{T}, weights::VectorOfVectors{T}) where {T, F<:Function}
    mweights = vmatrix(weights)

    basic_rolling(fn, width, data, mweights)
end

@inline function basic_rolling(fn::F, width::Integer,
                       data::AbstractMatrix{T}, weights::AbstractMatrix{T}) where {T, F<:Function}
    ᵛʷdata = asview(data)
    ᵛʷweights = asview(weights)

    basic_rolling(fn, width, ᵛʷdata, ᵛʷweights)
end

function basic_rolling(fn::F, width::Integer,
                       data::AbstractMatrix{T}, weighting::AbstractWeights{W}) where {T, W, F<:Function}
    colcount = ncols(data)
    mweights = vmatrix(Vector{T}(wieghting), colcount)

    basic_rolling(fn, width, data, mweights)
end

function basic_rolling(fn::F, width::Integer,
                       data::AbstractMatrix{T}, weights::VectorOfVectors{W}) where {T, W, F<:Function}
    mweights = Matrix{T}(vmatrix(weights))

    basic_rolling(fn, width, data, mweights)
end

@inline function basic_rolling(fn::F, width::Integer,
                       data::AbstractMatrix{T}, weights::AbstractMatrix{W}) where {T, W, F<:Function}
    mweights = Matrix{T}(weights)

    basic_rolling(fn, width, data, weights)
end

@inline function basic_rolling(fn::F, width::Integer, 
                       ᵛʷdata::ViewOfMatrix{T}, ᵛʷweights::ViewOfMatrix{T}) where {T, F<:Function}
    rowcount, colcount = size(ᵛʷdata)
    nvalues = rolling_wholes(rowcount, width)
    rettype = rts(fn, (T,))
    results = newmatrix(rettype, (nvalues, colcount))

    ilow, ihigh = 1, width
    @inbounds for idx in 1:nvalues
        results[ilow, :] = vec(mapcols(fn, ᵛʷdata[ilow:ihigh, :] .* ᵛʷweights))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

#
# pad the start (first observations) with a given padding value
#

function padfirst_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractWeights{T}) where {T,F<:Function}
    colcount = ncols(data)
    mweights = vmatrix(weighting, colcount)

    padfirst_rolling(fn, width, data, mweights)
end

function padfirst_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weights::VectorOfVectors{T}) where {T,F<:Function}
    mweights = vmatrix(weights)

    padfirst_rolling(fn, width, data, mweights)
end

@inline function padfirst_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weights::AbstractMatrix{T}) where {T,F<:Function}
    ᵛʷdata = asview(data)
    ᵛʷweights = asview(weights)

    padfirst_rolling(fn, width, ᵛʷdata, ᵛʷweights)
end

function padfirst_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractWeights{W}) where {T,W,F<:Function}
    colcount = ncols(data)
    mweights = vmatrix(Vector{T}(wieghting), colcount)

    padfirst_rolling(fn, width, data, mweights)
end

function padfirst_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weights::VectorOfVectors{W}) where {T,W,F<:Function}
    mweights = Matrix{T}(vmatrix(weights))

    padfirst_rolling(fn, width, data, mweights)
end

@inline function padfirst_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weights::AbstractMatrix{W}) where {T,W,F<:Function}
    mweights = Matrix{T}(weights)

    padfirst_rolling(fn, width, data, weights)
end

function padfirst_rolling(fn::F, width::Integer,
    ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfWeights{T}) where {T,F<:Function}
    n = nrows(ᵛʷdata)
    nvalues = rolling_wholes(n, width)
    rettype = Union{typeof(padding),rts(fn, (T,))}
    results = Matrix{rettype}(undef, (nvalues, ncols(ᵛʷdata)))

    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt fn
    # this is the padding_width
    padding_width = width - 1
    padding_idxs = 1:padding_width

    results = Matrix{Union{typeof(padding),rettype}}(undef, size(ᵛʷdata))
    results[padding_idxs, :] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views results[idx, :] .= map(fn, ᵛʷdata[ilow:ihigh, :] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

#
# pad the end (last observations) with a given padding value
#

function padfinal_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractWeights{T}) where {T,F<:Function}
    colcount = ncols(data)
    mweights = vmatrix(weighting, colcount)

    padfinal_rolling(fn, width, data, mweights)
end

function padfinal_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weights::VectorOfVectors{T}) where {T,F<:Function}
    mweights = vmatrix(weights)

    padfinal_rolling(fn, width, data, mweights)
end

@inline function padfinal_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weights::AbstractMatrix{T}) where {T,F<:Function}
    ᵛʷdata = asview(data)
    ᵛʷweights = asview(weights)

    padfinal_rolling(fn, width, ᵛʷdata, ᵛʷweights)
end

function padfinal_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractWeights{W}) where {T,W,F<:Function}
    colcount = ncols(data)
    mweights = vmatrix(Vector{T}(wieghting), colcount)

    padfinal_rolling(fn, width, data, mweights)
end

function padfinal_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weights::VectorOfVectors{W}) where {T,W,F<:Function}
    mweights = Matrix{T}(vmatrix(weights))

    padfinal_rolling(fn, width, data, mweights)
end

@inline function padfinal_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weights::AbstractMatrix{W}) where {T,W,F<:Function}
    mweights = Matrix{T}(weights)

    padfinal_rolling(fn, width, data, weights)
end

function padfinal_rolling(fn::F, width::Integer,
    ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfMatrix{T}, padding) where {T,F<:Function}
    n = nrows(ᵛʷdata)
    nvalues = nrolled(n, width)
    rettype = Union{typeof(padding),rts(fn, (T,))}

    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt fn
    # this is the padding_width
    padding_width = width - 1
    padding_idxs = n-padding_width:n

    results = Matrix{rettype}(undef, size(ᵛʷdata))
    results[padding_idxs, :] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in 1:n-padding_width
        @views results[idx, :] = map(fn, ᵛʷdata[ilow:ihigh, :] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end
