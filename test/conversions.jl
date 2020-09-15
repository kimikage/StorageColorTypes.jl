using Test, StorageColorTypes
using Colors, FixedPointNumbers

@testset "reinterpret" begin
    @testset "reinterpret RGB/ARGB" begin
        @test reinterpret(UInt16, RGB565LE(1, 0, 1)) === ltoh(0b11111000_00011111)
        @test reinterpret(UInt16, RGB565BE(1, 0, 1)) === ntoh(0b11111000_00011111)
        @test reinterpret(UInt16, RGB555LE(1, 0, 1)) === ltoh(0b01111100_00011111)
        @test reinterpret(UInt16, RGB555BE(1, 0, 1)) === ntoh(0b01111100_00011111)
        @test reinterpret(UInt16, XRGB444LE(1, 1, 0)) === ltoh(0b00001111_11110000)
        @test reinterpret(UInt16, XRGB444BE(1, 1, 0)) === ntoh(0b00001111_11110000)
        @test reinterpret(UInt16, RGBX444LE(0, 1, 1)) === ltoh(0b00001111_11110000)
        @test reinterpret(UInt16, RGBX444BE(0, 1, 1)) === ntoh(0b00001111_11110000)

        @test reinterpret(RGB565LE, ltoh(0b11111000_00011111)) === RGB565LE(1, 0, 1)
        @test reinterpret(RGB565BE, ntoh(0b11111000_00011111)) === RGB565BE(1, 0, 1)
        @test reinterpret(RGB555LE, ltoh(0b01111100_00011111)) === RGB555LE(1, 0, 1)
        @test reinterpret(RGB555BE, ntoh(0b01111100_00011111)) === RGB555BE(1, 0, 1)
        @test reinterpret(XRGB444LE, ltoh(0b00001111_11110000)) === XRGB444LE(1, 1, 0)
        @test reinterpret(XRGB444BE, ntoh(0b00001111_11110000)) === XRGB444BE(1, 1, 0)
        @test reinterpret(RGBX444LE, ltoh(0b00001111_11110000)) === RGBX444LE(0, 1, 1)
        @test reinterpret(RGBX444BE, ntoh(0b00001111_11110000)) === RGBX444BE(0, 1, 1)
    end

    @testset "reinterpret HSV/HSL" begin
        @test reinterpret(UInt8, [HSV24(100, 1.0, 0.5)]) == UInt8[ 50, 0xFF, 0x80]
        @test reinterpret(UInt8, [HSL24(200, 0.0, 0.6)]) == UInt8[100, 0x00, 0x99]
        @test reinterpret(UInt8, [HLS24(300, 0.0, 0.4)]) == UInt8[150, 0x66, 0x00]

        @test reinterpret(HSV24, UInt8[ 50, 0xFF, 0x80]) == [HSV24(100, 1.0, 0.5)]
        @test reinterpret(HSL24, UInt8[100, 0x00, 0x99]) == [HSL24(200, 0.0, 0.6)]
        @test reinterpret(HLS24, UInt8[150, 0x66, 0x00]) == [HLS24(300, 0.0, 0.4)]

        @test reinterpret(HLS{Float32}, [HSL{Float32}(200, 0.0, 0.6)]) ==
            [HLS{Float32}(200, 0.6, 0.0)]
    end

    @testset "reinterpret Lab/Luv" begin
        @test reinterpret(UInt8, [Lab24(60, 100, -100)]) == UInt8[0x99, 228, 28]
        @test reinterpret(UInt8, [Luv24(60, 100, -100)]) == UInt8[0x99, 169, 39]

        @test reinterpret(Lab24, UInt8[0x99, 228, 28]) == [Lab24(60, 100, -100)]
        @test reinterpret(Luv24, UInt8[0x99, 169, 39]) == [Luv24(60, 100, -100)]
    end
end
