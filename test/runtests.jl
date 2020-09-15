using Test, StorageColorTypes
using ColorTypes

const ENDIAN = StorageColorTypes.BE ? "big" : "little"
@info "This script is running on a $ENDIAN-endian machine."

@test isempty(detect_ambiguities(StorageColorTypes, ColorTypes, Base, Core))

@testset "types" begin
    include("types.jl")
end

@testset "conversions" begin
    include("conversions.jl")
end
