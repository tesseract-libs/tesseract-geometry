defmodule Tesseract.Geometry do
  
  # Vec3
  def dimensions({_, _, _}) do
    3
  end

  # Box
  def dimensions({{_, _, _}, {_, _, _}}) do
    3
  end
end