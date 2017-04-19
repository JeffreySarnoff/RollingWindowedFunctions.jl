# RollingFunctions.jl

### Roll a function over data or run a function along data.

#### Copyright © 2017 by Jeffrey Sarnoff.  Released under the MIT License.

-----

[![Build Status](https://travis-ci.org/JeffreySarnoff/RollingFunctions.jl.svg?branch=master)](https://travis-ci.org/JeffreySarnoff/RollingFunctions.jl)   (Julia v0.6)

-----

### exports

#### windowed functions
```julia
roll_minimum, roll_maximum, 
roll_mean, roll_median,
roll_std, roll_var, roll_mad, 
roll_sum, roll_prod, roll_norm
```

#### how to fill, if desired
```julia
FILL_FIRST, FILL_LAST, FILL_BOTH,     # same value used repeatedly    
TAPER_FIRST, TAPER_LAST, TAPER_BOTH   # smaller windows (to `tapered_size`) used, copies last repeatedly    
                                      # note: `tapered_size = max(2, tapered_size)`, needed for coherence
```

#### windowed function construction
`rolling`

### use

This example shows how you may create other running functions.   
You do not need to define all of the forms, just the ones you want to use.

```julia
import StatsBase: middle
using RollingFunctions

# to roll a function keeping only complete windows
# (a) define
roll_middle{T<:Real}(window_size::Int, data::Vector{T}) =
    rolling(middle, window_size, data)
# (b) use
rolled_data = roll_middle(window_size, data)

# to roll a function filling the first part with NaNs
# (a) define
roll_middle{T<:Real}(FILL_FIRST, window_size::Int, filler::T, data::Vector{T})  =
    rolling(FILL_FIRST, middle, window_size, filler, data)
# (b) specialize
roll_middle_NaN{T<:Real}(window_size::Int, data::Vector{T}) =
    roll_middle(FILL_FIRST, window_size, (T)NaN, data)
# (c) use
rolled_data = roll_middle_NaN(window_size, data)

```

Here are all of the forms

```julia
import StatsBase: middle
using RollingFunctions

roll_middle{T<:Real}(window_size::Int, data::Vector{T}) =
    rolling(middle, window_size, data)

roll_middle{T<:Real}(FILL_FIRST, window_size::Int, data::Vector{T})  =
    rolling(FILL_FIRST, middle, window_size, data)
roll_middle{T<:Real}(FILL_LAST, window_size::Int, data::Vector{T})  =
    rolling(FILL_LAST, middle, window_size, data)
roll_middle{T<:Real}(FILL_BOTH, window_size::Int, data::Vector{T})  =
    rolling(FILL_BOTH, middle, window_size, data)

roll_middle{T<:Real}(FILL_FIRST, window_size::Int, filler::T, data::Vector{T})  =
    rolling(FILL_FIRST, middle, window_size, filler, data)
roll_middle{T<:Real}(FILL_LAST, window_size::Int, filler::T, data::Vector{T})  =
    rolling(FILL_LAST, middle, window_size, filler, data)
roll_middle{T<:Real}(FILL_BOTH, window_size::Int, filler::T, data::Vector{T})  =
    rolling(FILL_BOTH, middle, window_size, filler, data)

roll_middle{T<:Real}(TAPER_FIRST, window_size::Int, tapered_size::Int, data::Vector{T})  =
    rolling(TAPER_FIRST, middle, window_size, tapered_size, data)
roll_middle{T<:Real}(TAPER_LAST, window_size::Int, tapered_size::Int, data::Vector{T})  =
    rolling(TAPER_LAST, middle, window_size, tapered_size, data)
roll_middle{T<:Real}(TAPER_BOTH, window_size::Int, tapered_size::Int, data::Vector{T})  =
    rolling(TAPER_BOTH, middle, window_size, tapered_size, data)


data = [ 1.0, 3.0, 5.0, 7.0, 11.0, 15.0 ];

roll_middle(3, data)                 #           [ 3.0,  5.0,  8.0,  11.0 ]
roll_middle(FILL_FIRST, 3, data)     # [ 3.0, 3.0, 3.0,  5.0,  8.0,  11.0 ]
roll_middle(FILL_LAST,  3, data)     #           [ 3.0,  5.0,  8.0,  11.0, 11.0, 11.0 ]
roll_middle(FILL_BOTH,  3, data)     #      [ 3.0, 4.0,  5.5,  8.0,   9.5, 11.0 ]

```
