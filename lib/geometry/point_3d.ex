defmodule Tesseract.Geometry.Point3D do
    alias Tesseract.Geometry.AABB3
    alias Tesseract.Math.Vec3

    @type t :: Vec3.t()

    @spec mbb(t) :: AABB3.t()
    def mbb({_, _, _} = point) do
        AABB3.make(point, point)
    end

    @spec mbb(t, number) :: AABB3.t()
    def mbb({x, y, z}, padding) do
        AABB3.make({x - padding, y - padding, z - padding}, {x + padding, y + padding, z + padding})
    end
end