
endian(::Type{C}) where {T, fr, fg, fb, en, C <: AbstractStorageRGB{T, fr, fg, fb, en}} = en
nbitsfr(::Type{C}) where {T, fr, fg, fb, C <: AbstractStorageRGB{T, fr, fg, fb}} = fr
nbitsfg(::Type{C}) where {T, fr, fg, fb, C <: AbstractStorageRGB{T, fr, fg, fb}} = fg
nbitsfb(::Type{C}) where {T, fr, fg, fb, C <: AbstractStorageRGB{T, fr, fg, fb}} = fb
nshiftr(::Type{C}) where {C} = nbitsfg(C) + nshiftg(C)
nshiftg(::Type{C}) where {C} = nbitsfb(C) + nshiftb(C)
nshiftb(::Type{C}) where {T, fr, fg, fb, C <: AbstractStorageRGB{T, fr, fg, fb}} = 0
nshiftb(::Type{C}) where {C <: Union{RGBX444LE, RGBX444BE}} = 4
rawtype(::Type{C}) where {C <: AbstractStorageRGB} =
    sizeof(C) == 1 ? UInt8 : sizeof(C) == 2 ? UInt16 : UInt32
saturatedr(::Type{C}) where {C <: AbstractStorageRGB} = ~(typemax(rawtype(C)) << nbitsfr(C))
saturatedg(::Type{C}) where {C <: AbstractStorageRGB} = ~(typemax(rawtype(C)) << nbitsfg(C))
saturatedb(::Type{C}) where {C <: AbstractStorageRGB} = ~(typemax(rawtype(C)) << nbitsfb(C))
maskr(::Type{C}) where {C <: AbstractStorageRGB} = saturatedr(C) << nshiftr(C)
maskg(::Type{C}) where {C <: AbstractStorageRGB} = saturatedg(C) << nshiftg(C)
maskb(::Type{C}) where {C <: AbstractStorageRGB} = saturatedb(C) << nshiftb(C)

endian(::C) where {C <: AbstractStorageRGB} = endian(C)
nbitsfr(::C) where {C <: AbstractStorageRGB} = nbitsfr(C)
nbitsfg(::C) where {C <: AbstractStorageRGB} = nbitsfg(C)
nbitsfb(::C) where {C <: AbstractStorageRGB} = nbitsfb(C)
nshiftr(::C) where {C <: AbstractStorageRGB} = nshiftr(C)
nshiftg(::C) where {C <: AbstractStorageRGB} = nshiftg(C)
nshiftb(::C) where {C <: AbstractStorageRGB} = nshiftb(C)
saturatedr(::C) where {C <: AbstractStorageRGB} = saturatedr(C)
saturatedg(::C) where {C <: AbstractStorageRGB} = saturatedg(C)
saturatedb(::C) where {C <: AbstractStorageRGB} = saturatedb(C)
maskr(::C) where {C <: AbstractStorageRGB} = maskr(C)
maskg(::C) where {C <: AbstractStorageRGB} = maskg(C)
maskb(::C) where {C <: AbstractStorageRGB} = maskb(C)


toh(c::C) where {C <: AbstractStorageRGB} = (endian(C) === :be ? ntoh : ltoh)(c.color)

# Accessors
red(c::Union{RGB565LE, RGB565BE, RGB555LE, RGB555BE}) =
    n3f5ton0f8((toh(c) >> nshiftr(c)) & saturatedr(c))
red(c::Union{XRGB444LE, XRGB444BE, RGBX444LE, RGBX444BE}) =
    n4f4ton0f8((toh(c) >> nshiftr(c)) & saturatedr(c))

green(c::Union{RGB565LE, RGB565BE}) = n2f6ton0f8((toh(c) >> nshiftg(c)) & saturatedg(c))
green(c::Union{RGB555LE, RGB555BE}) = n3f5ton0f8((toh(c) >> nshiftg(c)) & saturatedg(c))
green(c::Union{XRGB444LE, XRGB444BE, RGBX444LE, RGBX444BE}) =
    n4f4ton0f8((toh(c) >> nshiftg(c)) & saturatedg(c))

blue(c::Union{RGB565LE, RGB565BE, RGB555LE, RGB555BE}) =
    n3f5ton0f8((toh(c) >> nshiftb(c)) & saturatedb(c))
blue(c::Union{XRGB444LE, XRGB444BE, RGBX444LE, RGBX444BE}) =
    n4f4ton0f8((toh(c) >> nshiftb(c)) & saturatedb(c))

chroma(c::Union{Lab24, Luv24}) = sqrt(comp2(c)^2 + comp3(c)^2)

hue(c::Union{HSV24, HSL24, HLS24, HLS}) = comp1(c)
hue(c::Union{Lab24, Luv24}) = (h = atand(comp3(c), comp2(c)); h < 0 ? h + 360 : h)

comp1(c::Union{HSV24, HSL24, HLS24}) = getfield(c, :h_raw) * 2.0f0
comp1(c::Union{Lab24, Luv24}) = getfield(c, :l_raw) * 65537f0 * Float32(0x1919p-30)
comp2(c::Union{HSV24, HSL24, HLS24}) = @inbounds n0f8tof32[getfield(c, :s_raw) + 1]
comp2(c::Union{Lab24}) = getfield(c, :a_raw) - 128f0
comp2(c::Union{Luv24}) = getfield(c, :u_raw) * (354f0 / 255f0) - 134f0
comp2(c::HLS) = c.s
comp3(c::Union{HSV24}) = @inbounds n0f8tof32[getfield(c, :v_raw) + 1]
comp3(c::Union{HSL24, HLS24}) = @inbounds n0f8tof32[getfield(c, :l_raw) + 1]
comp3(c::Union{Lab24}) = getfield(c, :b_raw) - 128f0
comp3(c::Union{Luv24}) = getfield(c, :v_raw) * (262f0 / 255f0) - 140f0
comp3(c::HLS) = c.l

function Base.getproperty(c::HSV24, sym::Symbol)
    sym === :h && return comp1(c)
    sym === :s && return comp2(c)
    sym === :v && return comp3(c)
    getfield(c, sym)
end

function Base.getproperty(c::HSL24, sym::Symbol)
    sym === :h && return comp1(c)
    sym === :s && return comp2(c)
    sym === :l && return comp3(c)
    getfield(c, sym)
end

function Base.getproperty(c::HLS24, sym::Symbol)
    sym === :h && return comp1(c)
    sym === :l && return comp2(c)
    sym === :s && return comp3(c)
    getfield(c, sym)
end

floattype(::Type{HSV24}) = HSV{Float32}
floattype(::Type{HSL24}) = HSL{Float32}
floattype(::Type{HLS24}) = HLS{Float32}
