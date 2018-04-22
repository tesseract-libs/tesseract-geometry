defmodule Tesseract.Geometry.Box do
    @type t :: {{number, number, number}, {number, number, number}}

    def add({{a_x1, a_y1, a_z1}, {a_x2, a_y2, a_z2}}, {{b_x1, b_y1, b_z1}, {b_x2, b_y2, b_z2}}) do
        {
            {min(a_x1, b_x1), min(a_y1, b_y1), min(a_z1, b_z1)},
            {max(a_x2, b_x2), max(a_y2, b_y2), max(a_z2, b_z2)}
        }
    end

    def add(boxes) when is_list(boxes) do
        boxes |> Enum.reduce(fn (container, box) -> add(container, box) end)
    end

    def volume_increase(box_a, box_b) do
        combined = add(box_a, box_b)

        volume(combined) - volume(box_a)
    end

    @spec volume(t) :: number
    def volume({{x1, y1, z1}, {x2, y2, z2}}) do
        (x2 - x1) * (y2 - y1) * (z2 - z1) 
    end

    def intersects({{a_x1, a_y1, a_z1}, {a_x2, a_y2, a_z2}}, {{b_x1, b_y1, b_z1}, {b_x2, b_y2, b_z2}}) do
        (
            (min(a_x1, a_x2) <= max(b_x1, b_x2) && max(a_x1, a_x2) >= min(b_x1, b_x2)) &&
            (min(a_y1, a_y2) <= max(b_y1, b_y2) && max(a_y1, a_y2) >= min(b_y1, b_y2)) &&
            (min(a_z1, a_z2) <= max(b_z1, b_z2) && max(a_z1, a_z2) >= min(b_z1, b_z2))
        )
    end
end