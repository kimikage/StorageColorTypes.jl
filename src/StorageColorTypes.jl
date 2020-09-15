module StorageColorTypes

using FixedPointNumbers
using ColorTypes

import Base: reinterpret
import FixedPointNumbers: floattype
import ColorTypes: red, green, blue, alpha, chroma, hue, comp1, comp2, comp3

export
    RGB565LE, RGB565BE, RGB565,
    RGB555LE, RGB555BE, RGB555,
    XRGB444LE, XRGB444BE, XRGB444,
    RGBX444LE, RGBX444BE, RGBX444,
    ARGB4444LE, ARGB4444BE, ARGB4444,
    ARGB1555LE, ARGB1555BE, ARGB1555,
    RGB332, RGB242,
    HSV24, HSL24, HLS24, Lab24, Luv24, HLS

const BE = ENDIAN_BOM === 0x01020304

include("types.jl")
include("conversions.jl")
include("traits.jl")

end # module
