using Test, StorageColorTypes

@testset "rgb types" begin
    include("rgbtypes.jl")
end

@testset "HSV/HSL constructors" begin
    @testset "$C constructor" for C in (HSV24, HSL24, HLS24, HLS)
        @test C(100, 1.0, 0.5) isa Color{Float32, 3}
        @test C(1N0f8, 0.6N0f8, 0.0N0f8) === C(1, 0.6, 0)
    end
end

@testset "Lab/Luv constructors" begin
    @testset "$C constructor" for C in (Lab24, Luv24)
        @test C(50, 40, 30.0) isa Color{Float32, 3}
        @test C(1N0f8, 0.6N0f8, 0.0N0f8) === C(1, 0.6, 0)
    end
end
