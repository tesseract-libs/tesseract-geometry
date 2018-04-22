defmodule Tesseract.Geometry.Rectangle do
    
    @type t :: {{number, number}, {number, number}}

    # TODO: make/1 function

    @spec area(t) :: number
    def area({{x1, y1}, {x2, y2}}) do
        (x2 - x1) * (y2 - y1)
    end
end