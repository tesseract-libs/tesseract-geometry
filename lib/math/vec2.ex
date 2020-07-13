defmodule Tesseract.Math.Vec2 do
  @type t :: {number, number}

  @spec new() :: t
  def new(), do: {0, 0}
  @spec new(number, number) :: t
  def new(x, y), do: {x, y}
  @spec new(number, number) :: t
  def new({x, y}), do: {x, y} 

  @spec add(t, t) :: t
  def add({a_x, a_y}, {b_x, b_y}) do
    {a_x + b_x, a_y + b_y}
  end

  @spec subtract(t, t) :: t
  def subtract({a_x, a_y}, {b_x, b_y}) do
    {a_x - b_x, a_y - b_y}
  end

  @spec multiply(t, t) :: t
  def multiply({a_x, a_y}, {b_x, b_y}) do
    {a_x * b_x, a_y * b_y}
  end

  @spec scale(t, number) :: t
  def scale({x, y}, scale) do
    {x * scale, y * scale}
  end

  @spec dot(t, t) :: number
  def dot({a_x, a_y}, {b_x, b_y}) do
    a_x * b_x + a_y * b_y
  end

  @spec length(t) :: number
  def length({x, y}) do
    :math.sqrt(x*x + y*y)
  end

  @spec normalize(t) :: t
  def normalize(a) do
    scale(a, 1 / __MODULE__.length(a))
  end
end