using Test, StorageColorTypes
using ColorTypes, FixedPointNumbers

@testset "type hierarchy" begin
    @test RGB565LE <: Colorant
    @test RGB565LE <: Color{N0f8, 3}
    @test RGB565LE <: AbstractRGB{N0f8}

    @test ARGB4444BE <: Colorant
    @test ARGB4444BE <: TransparentColor
    @test ARGB4444BE <: TransparentRGB
    @test ARGB4444BE <: AlphaColor
end

@testset "internal constructors" begin
    @test RGB565LE(0xAA55, Val(:no)).color === 0xAA55
    @test RGB565BE(0xAA55, Val(:no)).color === 0xAA55
    @test RGB555LE(0xAA55, Val(:no)).color === 0xAA55
    @test RGB555BE(0xAA55, Val(:no)).color === 0xAA55
    @test XRGB444LE(0xAA55, Val(:no)).color === 0xAA55
    @test XRGB444BE(0xAA55, Val(:no)).color === 0xAA55
    @test RGBX444LE(0xAA55, Val(:no)).color === 0xAA55
    @test RGBX444BE(0xAA55, Val(:no)).color === 0xAA55

    if StorageColorTypes.BE
        @test RGB565LE(0xAA55, Val(:le)).color === 0x55AA
        @test RGB565BE(0xAA55, Val(:be)).color === 0xAA55
        @test RGB555LE(0xAA55, Val(:le)).color === 0x55AA
        @test RGB555BE(0xAA55, Val(:be)).color === 0xAA55
        @test XRGB444LE(0xAA55, Val(:le)).color === 0x55AA
        @test XRGB444BE(0xAA55, Val(:be)).color === 0xAA55
        @test RGBX444LE(0xAA55, Val(:le)).color === 0x55AA
        @test RGBX444BE(0xAA55, Val(:be)).color === 0xAA55
    else
        @test RGB565LE(0xAA55, Val(:le)).color === 0xAA55
        @test RGB565BE(0xAA55, Val(:be)).color === 0x55AA
        @test RGB555LE(0xAA55, Val(:le)).color === 0xAA55
        @test RGB555BE(0xAA55, Val(:be)).color === 0x55AA
        @test XRGB444LE(0xAA55, Val(:le)).color === 0xAA55
        @test XRGB444BE(0xAA55, Val(:be)).color === 0x55AA
        @test RGBX444LE(0xAA55, Val(:le)).color === 0xAA55
        @test RGBX444BE(0xAA55, Val(:be)).color === 0x55AA

    end
    @test_throws MethodError RGB565LE(0xAA55, Val(:be))
    @test_throws MethodError RGB555BE(0xAA55, Val(:le))

    @test_throws Exception XRGB444(0x0000)
end

@testset "rgb constructors" begin
    @testset "$C constructor" for C in (RGB565LE, RGB565BE,
                                        RGB555LE, RGB565BE,
                                        XRGB444LE, XRGB444BE,
                                        RGBX444LE, RGBX444BE,
                                        RGB332, RGB242)
        for val1 in (0.2, 0.2f0, N0f8(0.2), N4f12(0.2), N0f16(0.2))
            for val2 in (0.6, 0.6f0, N0f8(0.6), N4f12(0.6), N0f16(0.6))
                @test C(val1, val2, val1) === C(0.2N0f8, 0.6N0f8, 0.2N0f8)
            end
            # 1-arg constructor
            #@test C(val1) === C{typeof(val1)}(0.2,0.2,0.2)
        end

        @test_throws ArgumentError C(2,1,0) # integers

        for val in (1.2, 1.2f0, N4f12(1.2), -0.2)
            @test_throws ArgumentError C(val,val,val)
        end
    end
end
