
n4f4ton0f8(x::UInt16) = reinterpret(N0f8, (x % UInt8) * 0x11)
n3f5ton0f8(x::UInt16) = reinterpret(N0f8, (x * 0x083A + 0x80) >> 0x8 % UInt8)
n2f6ton0f8(x::UInt16) = reinterpret(N0f8, (x * 0x040C + 0x80) >> 0x8 % UInt8)

function rationalized_scale(::Type{T}) where {T}
    a = zeros(T, 256)
    for d = 1:255
        for n = 1:d
            i = round(Int, n / d * 255) + 1
            if a[i] == zero(T)
                a[i] = n / d
            end
        end
    end
    return a
end

const n0f8tof32 = rationalized_scale(Float32)
const n0f8tof64 = rationalized_scale(Float64)


hue_u8(hue::Real) = unsafe_trunc(UInt8, round((hue * 0.5f0) % 180))
hue_u8(hue::Integer) = (hue >> 0x1) % UInt8

lstar_u8(l::Real) = unsafe_trunc(UInt8, round(l * 2.55f0))

abstar_u8(ab::Real) = unsafe_trunc(UInt8, round(ab + 128))

ustar_u8(u::Real) = unsafe_trunc(UInt8, round((u + 134) * 255 / 354))

vstar_u8(v::Real) = unsafe_trunc(UInt8, round((v + 140) * 255 / 262))

function ColorTypes._convert(::Type{Cout}, ::Type{C1}, ::Type{C2}, c) where
    {Cout<:HSV, C1<:HSV, C2<:HSV24}

    Cout(comp1(c), comp2(c), comp3(c))
end

function ColorTypes._convert(::Type{Cout}, ::Type{C1}, ::Type{C2}, c) where
    {Cout<:AbstractRGB, C1<:AbstractRGB, C2<:Union{HSV24, HSL24, HLS24}}
    convert(Cout, floattype(C2)(comp1(c), comp2(c), comp3(c)))
end

reinterpret(::Type{UInt16}, c::C) where {C <: AbstractRGB16} = c.color
reinterpret(::Type{C}, x::UInt16) where {C <: AbstractRGB16} = C(x, Val(:no))
