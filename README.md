# StorageColorTypes
This package is an add-on to [ColorTypes](https://github.com/JuliaGraphics/ColorTypes.jl)
and adds support for pixel formats used in low-level image buffers or datagrams.

This package is intended to deal transparently with commonly used formats (e.g.
`RGB{N0f8}`) rather than using the raw encodings.

## Supported Types

### RGB types
- `AbstractRGB`
  - `RGB565LE`, `RGB565BE`
  - `RGB555LE`, `RGB555BE`
  - `XRGB444LE`, `XRGB444BE`
  - `RGBX444LE`, `RGBX444BE`
  - `RGB332`
  - `RGB242`
- `TransparentRGB`
  - `ARGB4444LE`, `ARGB4444BE`
  - `ARGB1555LE`, `ARGB1555BE`
- Type Alias
  - `RGB565`, `RGB555`, `XRGB444`, `RGBX444`
  - `ARGB4444`, `ARGB1555`

### OpenCV 8-bit types
- `HSV24`
- `HLS24`
- `Lab24`
- `Luv24`

### Other types
- `HSL24`
- `HLS`
