
# AbstractRGB

abstract type AbstractStorageRGB{T, fr, fg, fb, en} <: AbstractRGB{T} end

const AbstractRGB16{en} = Union{
    AbstractStorageRGB{N0f8, 5, 6, 5, en},
    AbstractStorageRGB{N0f8, 5, 5, 5, en},
    AbstractStorageRGB{N0f8, 4, 4, 4, en}}

"""
    RGB565LE

A 16-bit RGB type with 5-bit red, 6-bit green and 5-bit blue components.
Unlike [`RGB565BE`](@ref), the blue component is included in the first byte as
follows.
```
  7  6  5  4  3  2  1  0     7  6  5  4  3  2  1  0
+--+--+--+--+--+--+--+--+  +--+--+--+--+--+--+--+--+
|G2 G1 G0|B4 B3 B2 B1 B0|  |R4 R3 R2 R1 R0|G5 G4 G3|
+--+--+--+--+--+--+--+--+  +--+--+--+--+--+--+--+--+
       first byte                 second byte
```
As the blue component is before the red component, `RGB565LE` is sometimes
called "BGR565". Note that "BGR565" may also refer to a variant of "RGB565"
swapped by component, not by byte.
"""
struct RGB565LE <: AbstractStorageRGB{N0f8, 5, 6, 5, :le}
    color::UInt16
    RGB565LE(color::UInt16, ::Val{:no}) = new(color)
end

"""
    RGB565BE

A 16-bit RGB type with 5-bit red, 6-bit green and 5-bit blue components.
Unlike [`RGB565LE`](@ref), the red component is included in the first byte as
follows.
```
  7  6  5  4  3  2  1  0     7  6  5  4  3  2  1  0
+--+--+--+--+--+--+--+--+  +--+--+--+--+--+--+--+--+
|R4 R3 R2 R1 R0|G5 G4 G3|  |G2 G1 G0|B4 B3 B2 B1 B0|
+--+--+--+--+--+--+--+--+  +--+--+--+--+--+--+--+--+
       first byte                 second byte
```
"""
struct RGB565BE <: AbstractStorageRGB{N0f8, 5, 6, 5, :be}
    color::UInt16
    RGB565BE(color::UInt16, ::Val{:no}) = new(color)
end


"""
    RGB555LE

A 16-bit RGB type with 5-bit red, green and blue components.
Unlike [`RGB555BE`](@ref), the blue component is included in the first byte as
follows.
```
  7  6  5  4  3  2  1  0     7  6  5  4  3  2  1  0
+--+--+--+--+--+--+--+--+  +--+--+--+--+--+--+--+--+
|G2 G1 G0|B4 B3 B2 B1 B0|  |X |R4 R3 R2 R1 R0|G4 G3|
+--+--+--+--+--+--+--+--+  +--+--+--+--+--+--+--+--+
       first byte                 second byte
```
As the blue component is before the red component, `RGB555LE` is sometimes
called "BGR555". Note that "BGR555" may also refer to a variant of "RGB555"
swapped by component, not by byte.
"""
struct RGB555LE <: AbstractStorageRGB{N0f8, 5, 5, 5, :le}
    color::UInt16
    RGB555LE(color::UInt16, ::Val{:no}) = new(color)
end

"""
    RGB555BE

A 16-bit RGB type with 5-bit red, green and blue components.
Unlike [`RGB555LE`](@ref), the red component is included in the first byte as
follows.
```
  7  6  5  4  3  2  1  0     7  6  5  4  3  2  1  0
+--+--+--+--+--+--+--+--+  +--+--+--+--+--+--+--+--+
|X |R4 R3 R2 R1 R0|G4 G3|  |G2 G1 G0|B4 B3 B2 B1 B0|
+--+--+--+--+--+--+--+--+  +--+--+--+--+--+--+--+--+
       first byte                 second byte
```
"""
struct RGB555BE <: AbstractStorageRGB{N0f8, 5, 5, 5, :be}
    color::UInt16
    RGB555BE(color::UInt16, ::Val{:no}) = new(color)
end

"""
    XRGB444LE

A 16-bit RGB type with 4-bit red, green and blue components.
Unlike [`XRGB444BE`](@ref), the blue component is included in the first byte as
follows.
```
  7  6  5  4  3  2  1  0     7  6  5  4  3  2  1  0
+--+--+--+--+--+--+--+--+  +--+--+--+--+--+--+--+--+
|G3 G2 G1 G0|B3 B2 B1 B0|  |X  X  X  X |R3 R2 R1 R0|
+--+--+--+--+--+--+--+--+  +--+--+--+--+--+--+--+--+
       first byte                 second byte
```
"""
struct XRGB444LE <: AbstractStorageRGB{N0f8, 4, 4, 4, :le}
    color::UInt16
    XRGB444LE(color::UInt16, ::Val{:no}) = new(color)
end


"""
    XRGB444BE

A 16-bit RGB type with 4-bit red, green and blue components.
Unlike [`XRGB444LE`](@ref), the red component is included in the first byte as
follows.
```
  7  6  5  4  3  2  1  0     7  6  5  4  3  2  1  0
+--+--+--+--+--+--+--+--+  +--+--+--+--+--+--+--+--+
|X  X  X  X |R3 R2 R1 R0|  |G3 G2 G1 G0|B3 B2 B1 B0|
+--+--+--+--+--+--+--+--+  +--+--+--+--+--+--+--+--+
       first byte                 second byte
```
"""
struct XRGB444BE <: AbstractStorageRGB{N0f8, 4, 4, 4, :be}
    color::UInt16
    XRGB444BE(color::UInt16, ::Val{:no}) = new(color)
end


"""
    RGBX444LE

A 16-bit RGB type with 4-bit red, green and blue components.
Unlike [`RGBX444BE`](@ref), the blue component is included in the first byte as
follows.
```
  7  6  5  4  3  2  1  0     7  6  5  4  3  2  1  0
+--+--+--+--+--+--+--+--+  +--+--+--+--+--+--+--+--+
|B3 B2 B1 B0|X  X  X  X |  |R3 R2 R1 R0|G3 G2 G1 G0|
+--+--+--+--+--+--+--+--+  +--+--+--+--+--+--+--+--+
       first byte                 second byte
```
"""
struct RGBX444LE <: AbstractStorageRGB{N0f8, 4, 4, 4, :le}
    color::UInt16
    RGBX444LE(color::UInt16, ::Val{:no}) = new(color)
end

"""
    RGBX444BE

A 16-bit RGB type with 4-bit red, green and blue components.
Unlike [`RGBX444LE`](@ref), the red component is included in the first byte as
follows.
```
  7  6  5  4  3  2  1  0     7  6  5  4  3  2  1  0
+--+--+--+--+--+--+--+--+  +--+--+--+--+--+--+--+--+
|R3 R2 R1 R0|G3 G2 G1 G0|  |B3 B2 B1 B0|X  X  X  X |
+--+--+--+--+--+--+--+--+  +--+--+--+--+--+--+--+--+
       first byte                 second byte
```
"""
struct RGBX444BE <: AbstractStorageRGB{N0f8, 4, 4, 4, :be}
    color::UInt16
    RGBX444BE(color::UInt16, ::Val{:no}) = new(color)
end

"""
    RGB332

An 8-bit RGB type with 3-bit red, 3-bit green and 2-bit blue components.
```
  7  6  5  4  3  2  1  0
+--+--+--+--+--+--+--+--+
|R2 R1 R0|G2 G1 G0|B1 B0|
+--+--+--+--+--+--+--+--+
```
"""
struct RGB332 <: AbstractStorageRGB{N0f8, 3, 3, 2, :no}
    color::UInt8
    RGB332(color::UInt8, ::Val{:no}) = new(color)
end

"""
    RGB242

An 8-bit RGB type with 2-bit red, 4-bit green and 2-bit blue components.

This type has a single green component, which is different from the "RGGB" (with
two green components) used in the Bayer pattern.
```
  7  6  5  4  3  2  1  0
+--+--+--+--+--+--+--+--+
|R1 R0|G3 G2 G1 G0|B1 B0|
+--+--+--+--+--+--+--+--+
```
"""
struct RGB242 <: AbstractStorageRGB{N0f8, 2, 4, 2, :no}
    color::UInt8
    RGB242(color::UInt8, ::Val{:no}) = new(color)
end

# TransparentRGB

struct ARGB4444LE <: AlphaColor{XRGB444LE, N0f8, 4}
    color::UInt16
    ARGB4444LE(color::UInt16, ::Val{:no}) = new(color)
end

struct ARGB4444BE <: AlphaColor{XRGB444BE, N0f8, 4}
    color::UInt16
    ARGB4444BE(color::UInt16, ::Val{:no}) = new(color)
end

struct ARGB1555LE <: AlphaColor{RGB555LE, N0f8, 4}
    color::UInt16
    ARGB1555LE(color::UInt16, ::Val{:no}) = new(color)
end

struct ARGB1555BE <: AlphaColor{RGB555BE, N0f8, 4}
    color::UInt16
    ARGB1555BE(color::UInt16, ::Val{:no}) = new(color)
end

# Type Aliases

const RGB565 = BE ? RGB565BE : RGB565LE
const RGB555 = BE ? RGB555BE : RGB555LE
const XRGB444 = BE ? XRGB444BE : XRGB444LE
const RGBX444 = BE ? RGBX444BE : RGBX444LE
const ARGB4444 = BE ? ARGB4444BE : ARGB4444LE
const ARGB1555 = BE ? ARGB1555BE : ARGB1555LE

# Constructors

(::Type{C})(color::UInt16, ::Val{:le}) where {C <: AbstractRGB16{:le}} =
    C(htol(color), Val(:no))
(::Type{C})(color::UInt16, ::Val{:be}) where {C <: AbstractRGB16{:be}} =
    C(hton(color), Val(:no))

# Here we quantize the input RGB values, but there will be another quantization
# error in the conversion to `N0f8`. It is possible to reduce the error by using
# unequally spaced steps, but for simplicity, we will apply the equally spaced
# steps here.
function (::Type{C})(r::Real, g::Real, b::Real) where {C <: Union{AbstractRGB16,
                                                                  RGB332, RGB242}}
    # For simplicity, the 0.5eps margins are not accepted.
    (min(r, g, b) >= 0) & (max(r, g, b) <= 1) || throw_rgb_error(C, r, g, b)
    T = rawtype(C)
    ri = unsafe_trunc(T, round(Int32, float(r) * saturatedr(C)))
    gi = unsafe_trunc(T, round(Int32, float(g) * saturatedg(C)))
    bi = unsafe_trunc(T, round(Int32, float(b) * saturatedb(C)))
    C(ri << nshiftr(C) + gi << nshiftg(C) + bi << nshiftb(C), Val(endian(C)))
end


function (::Type{C})(r::Integer, g::Integer, b::Integer) where {C <: AbstractRGB16}
    (r | g | b) >>> 0x1 == 0 || throw_rgb_error(C, r, g, b)
    ri = ifelse(r % Bool, maskr(C), UInt16(0))
    gi = ifelse(g % Bool, maskg(C), UInt16(0))
    bi = ifelse(b % Bool, maskb(C), UInt16(0))
    C(ri + gi + bi, Val(endian(C)))
end

function (::Type{C})(r::N0f8, g::N0f8, b::N0f8) where {C <: Union{RGB565LE, RGB565BE}}
    r8, g8, b8 = reinterpret(r), reinterpret(g), reinterpret(b)
    ri = (widemul(r8, 0xF9) + 0x400) & maskr(C)
    gi = (widemul(g8, 0xFD) + 0x200) >> nbitsfr(C)
    bi = (widemul(b8, 0xF9) + 0x400) >> nshiftr(C)
    C(ri + (gi & maskg(C)) + bi, Val(endian(C)))
end

function (::Type{C})(r::N0f8, g::N0f8, b::N0f8) where {C <: Union{RGB555LE, RGB555BE}}
    r8, g8, b8 = reinterpret(r), reinterpret(g), reinterpret(b)
    ri = (widemul(r8, 0xF9) + 0x400) >> 0x1
    gi = (widemul(g8, 0xF9) + 0x400) >> (nbitsfr(C) + 1)
    bi = (widemul(b8, 0xF9) + 0x400) >> (nshiftr(C) + 1)
    C((ri &  maskr(C)) + (gi & maskg(C)) + bi, Val(endian(C)))
end

function (::Type{C})(r::N0f8, g::N0f8, b::N0f8) where {C <: Union{XRGB444LE, XRGB444BE,
                                                                  RGBX444LE, RGBX444BE}}
    r8, g8, b8 = reinterpret(r), reinterpret(g), reinterpret(b)
    ri = (UInt16(r8) & saturatedr(C)) << nshiftr(C)
    gi = (UInt16(g8) & saturatedg(C)) << nshiftg(C)
    bi = (UInt16(b8) & saturatedb(C)) << nshiftb(C)
    C(ri + gi + bi, Val(endian(C)))
end

@noinline function throw_rgb_error(@nospecialize(C),
                                   @nospecialize(r), @nospecialize(g), @nospecialize(b))
    throw(ArgumentError(
        "Each RGB value must be in the interval [0,1]. $C cannot represent ($r, $g, $b)."))
end
