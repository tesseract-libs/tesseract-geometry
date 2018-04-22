defmodule Tesseract.Geometry.Point3D do
    alias Tesseract.Geometry.Box

    @type t :: {number, number, number}

    @spec mbb(t) :: Box.t
    def mbb({x, y, z} = point) do
        {point, point}
    end

    @spec mbb(t, number) :: Box.t
    def mbb({x, y, z}, padding) do
        {{x - padding, y - padding, z - padding}, {x + padding, y + padding, z + padding}}
    end
end