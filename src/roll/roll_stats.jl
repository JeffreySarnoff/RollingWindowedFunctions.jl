for T1 in (:T, :(Union{Missing,T}))
    for (R, F) in ((:rollmin, :vminimum), (:rollmax, :vmaximum),
        (:rollmean, :vmean), (:rollsum, :vsum),
        (:rollvar, :vvar), (:rollstd, :vstd))
        @eval begin
            $R(width::Width, data::V; padding=nopadding, atend=false) where {T, V<:AbstractVector{$T1}} =
                rolling($F, width, data; padding, atend)
            $R(width::Width, data::V, weights::W; padding=nopadding, atend=false) where {T, V<:AbstractVector{$T1}, W<:AbstractWeights} =
                rolling($F, width, data, weights; padding, atend)
        end
    end
end

for T1 in (:T, :(Union{Missing,T}))
    for (R, F) in ((:rollcor, :vcor), (:rollcov, :vcov))
        @eval begin
            $R(width::Width, data1::V, data2::V; padding=nopadding, atend=false) where {T,V<:AbstractVector{$T1}} =
                rolling($F, width, data1, data2; padding, atend)
            $R(width::Width, data1::V, data2::V, weights::W; padding=nopadding, atend=false) where {T,V<:AbstractVector{$T1},W<:AbstractWeights} =
                rolling($F, width, data1, data2, weights, weights; padding, atend)
            $R(width::Width, data1::V, data2::V, weights1::W, weights2::W; padding=nopadding, atend=false) where {T,V<:AbstractVector{$T1},W<:AbstractWeights} =
                rolling($F, width, data1, data2, weights1, weights2; padding, atend)
        end
    end
end

#=
mad_not_normalized(x) = mad(x, normalize=false)
mad_normalized(x) = mad(x, normalize=true)

for T1 in (:T, :(Union{Missing,T}))    
    for (R,F) in ((:rollmin, :minimum), (:rollmax, :maximum),
                  (:rollmean, :mean), (:rollmedian, :median), 
                  (:rollvar, :var), (:rollstd, :std),
                  (:rollskewness, :skewness), (:rollkurtosis, :kurtosis),
                  (:rollsem, :sem), 
                  (:rollmad, :mad_not_normalized),
                  (:rollmad_normalized, :mad_normalized),
                  (:rollvariation, :variation))
        @eval begin
            $R(data::V, windowwidth::Int) where {T, V<:AbstractVector{$T1}} =
                rolling($F, data, windowwidth)
            $R(data::V, windowwidth::Int, weighting::AbstractVector{S}) where {T, V<:AbstractVector{$T1}, S} =
                rolling($F, data, windowwidth, weighting)
            $R(data::V, windowwidth::Int, weighting::AbstractWeights) where {T, V<:AbstractVector{$T1}} =
                rolling($F, data, windowwidth, weighting.values)
        end
    end
end


rollcor(data1::V1, data2::V2, windowwidth::Int) where {T, V1<:Union{AbstractVector{T}, AbstractVector{Union{Missing,T}}}, 
                                                         V2<:Union{AbstractVector{T},AbstractVector{Union{Missing,T}}}} =
    rolling(cor, data1, data2, windowwidth)

rollcov(data1::V1, data2::V2, windowwidth::Int) where {T, V1<:Union{AbstractVector{T}, AbstractVector{Union{Missing,T}}}, 
                                                         V2<:Union{AbstractVector{T},AbstractVector{Union{Missing,T}}}} =
    rolling(cov, data1, data2, windowwidth)

rollcor(data1::V1, data2::V2, windowwidth::Int, weighting::AbstractVector{S}) where {S, T, V1<:Union{AbstractVector{T}, AbstractVector{Union{Missing,T}}}, 
                                                                                          V2<:Union{AbstractVector{T},AbstractVector{Union{Missing,T}}}} =
    rolling(cor, data1, data2, windowwidth, weighting)

rollcov(data1::V1, data2::V2, windowwidth::Int, weighting::AbstractVector{S}) where {S, T, V1<:Union{AbstractVector{T}, AbstractVector{Union{Missing,T}}}, 
                                                                                          V2<:Union{AbstractVector{T},AbstractVector{Union{Missing,T}}}} =
    rolling(cov, data1, data2, windowwidth, weighting)
=#