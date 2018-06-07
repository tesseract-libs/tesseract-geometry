defmodule Tesseract.Geometry.Box do
    alias Tesseract.Math.Vec3

    @type t :: {{number, number, number}, {number, number, number}}

    @spec union(t, t) :: t
    def union({{a_x1, a_y1, a_z1}, {a_x2, a_y2, a_z2}}, {{b_x1, b_y1, b_z1}, {b_x2, b_y2, b_z2}}) do
        {
            {min(a_x1, b_x1), min(a_y1, b_y1), min(a_z1, b_z1)},
            {max(a_x2, b_x2), max(a_y2, b_y2), max(a_z2, b_z2)}
        }
    end

    def union(boxes) when is_list(boxes) do
        boxes |> Enum.reduce(fn (container, box) -> union(container, box) end)
    end

    @spec intersection(t, t) :: t | nil
    def intersection({{a_x1, a_y1, a_z1}, {a_x2, a_y2, a_z2}} = a, {{b_x1, b_y1, b_z1}, {b_x2, b_y2, b_z2}} = b) do
        if intersects?(a, b) do
            {
                {max(a_x1, b_x1), max(a_y1, b_y1), max(a_z1, b_z1)},
                {min(a_x2, b_x2), min(a_y2, b_y2), min(a_z2, b_z2)}
            }
        else
            nil
        end
    end

    def intersects?({{a_x1, a_y1, a_z1}, {a_x2, a_y2, a_z2}}, {{b_x1, b_y1, b_z1}, {b_x2, b_y2, b_z2}}) do
        (
            (min(a_x1, a_x2) <= max(b_x1, b_x2) && max(a_x1, a_x2) >= min(b_x1, b_x2)) &&
            (min(a_y1, a_y2) <= max(b_y1, b_y2) && max(a_y1, a_y2) >= min(b_y1, b_y2)) &&
            (min(a_z1, a_z2) <= max(b_z1, b_z2) && max(a_z1, a_z2) >= min(b_z1, b_z2))
        )
    end

    @spec volume(t) :: number
    def volume({{x1, y1, z1}, {x2, y2, z2}}) do
        (x2 - x1) * (y2 - y1) * (z2 - z1) 
    end

    @spec intersection_volume(t, t) :: number | nil
    def intersection_volume(box_a, box_b) do
        case intersection(box_a, box_b) do
            nil -> 
                0

            intersection_box -> 
                volume(intersection_box)
        end
    end

    @spec center(t) :: Vec3.t
    def center({a, b}) do
        diag = b |> Vec3.subtract(a) |> Vec3.scale(0.5)
        a |> Vec3.add(diag)
    end
end