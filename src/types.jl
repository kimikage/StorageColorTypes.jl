
include("rgbtypes.jl")

"""
    HSV24

A 24-bit HSV color type.

# 8-bit encoding (compatible with OpenCV)
- `h_raw = 0.5 * h` in [0, 180)
- `s_raw = 255 * s` in [0, 255]
- `v_raw = 255 * v` in [0, 255]

!!! note
    Unlike `RGB24`, which is a 32-bit type, `HSV24` is a 24-bit (3-byte) type.
    Also,  whereas `RGB24` depends on the endianness,`HSV24` does not. That is,
    `HSV24` components are always in the order of `h`, `s`, `v`.
"""
struct HSV24 <: Color{Float32, 3}
    h_raw::UInt8
    s_raw::UInt8
    v_raw::UInt8
    function HSV24(h::Real, s::Real, v::Real)
        new(hue_u8(h), reinterpret(s % N0f8), reinterpret(v % N0f8))
    end
end

"""
    HSL24

A 24-bit HSL color type.

See [`HSV24`](@ref) for the differences from `RGB24` and the encoding.
"""
struct HSL24 <: Color{Float32, 3}
    h_raw::UInt8
    s_raw::UInt8
    l_raw::UInt8
    function HSL24(h::Real, s::Real, l::Real)
        new(hue_u8(h), reinterpret(s % N0f8), reinterpret(l % N0f8))
    end
end

"""
    HLS24

A 24-bit HSL color type.

See also [`HSV24`](@ref) for the differences from `RGB24` and the encoding.

!!! warning
    For compatibility with `HSL{Float32}`, the constructor arguments are in the
    order of `h`, `s`, `l`.
"""
struct HLS24 <: Color{Float32, 3}
    h_raw::UInt8
    l_raw::UInt8
    s_raw::UInt8
    function HLS24(h::Real, s::Real, l::Real)
        new(hue_u8(h), reinterpret(l % N0f8), reinterpret(s % N0f8))
    end
end

"""
    Lab24

A 24-bit CIE L*a*b* color type.

# 8-bit encoding (compatible with OpenCV)
- `l_raw = 255 * l /100` in [0, 255]
- `a_raw = a + 128` in [1, 255]
- `b_raw = b + 128` in [1, 255]

See also [`HSV24`](@ref) for the differences from `RGB24`.
"""
struct Lab24 <: Color{Float32, 3}
    l_raw::UInt8
    a_raw::UInt8
    b_raw::UInt8
    function Lab24(l::Real, a::Real, b::Real)
        new(lstar_u8(l), abstar_u8(a), abstar_u8(b))
    end
end

"""
    Luv24

A 24-bit CIE L*u*v* color type.

# 8-bit encoding (compatible with OpenCV)
- `l_raw = 255 * l / 100` in [0, 255]
- `u_raw = 255 * (u + 134) / 354` in [0, 255]
- `v_raw = 255 * (v + 140) / 262` in [0, 255]

See also [`HSV24`](@ref) for the differences from `RGB24`.
!!! note
    [`Lab24`]
"""
struct Luv24 <: Color{Float32, 3}
    l_raw::UInt8
    u_raw::UInt8
    v_raw::UInt8
    function Luv24(l::Real, u::Real, v::Real)
        new(lstar_u8(l), ustar_u8(u), vstar_u8(v))
    end
end


"""
    HLS{T <: AbstractFloat}

A variant of `HSL` with a different field order.

!!! warning
    For compatibility with `HSL`, the constructor arguments are in the order of
    `h`, `s`, `l`.
"""
struct HLS{T <: AbstractFloat} <: Color{T, 3}
    h::T
    l::T
    s::T
    HLS{T}(h::T, s::T, l::T) where {T <: AbstractFloat} = new{T}(h, l, s)
end

# FIXME
HLS(h::Real, s::Real, l::Real) = HLS{Float32}(h, s, l)
HLS{T}(h::Real, s::Real, l::Real) where {T <: AbstractFloat} = HLS{T}(T(h), T(s), T(l))
