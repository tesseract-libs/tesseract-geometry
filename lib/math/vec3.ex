defmodule Tesseract.Math.Vec3 do
  @type t :: {number, number, number}

  @spec make() :: t
  def make() do
    {0.0, 0.0, 0.0}
  end

  @spec make(number, number, number) :: t
  def make(x, y, z) do
    {x, y, z}
  end

  @sec add(t, t) :: t
  def add({a_x, a_y, a_z}, {b_x, b_y, b_z}) do
    {a_x + b_x, a_y + b_z, a_z + b_z}
  end

  @spec subtract(t, t) :: t
  def subtract({a_x, a_y, a_z}, {b_x, b_y, b_z}) do
    {a_x - b_x, a_y - b_z, a_z - b_z}
  end

  @spec multiply(t, t) :: t
  def multiply({a_x, a_y, a_z}, {b_x, b_y, b_z}) do
    {a_x * b_x, a_y * b_z, a_z * b_z}
  end

  @spec scale(t, number) :: t
  def scale({x, y, z}, scale) do
    {x * scale, y * scale, z * scale}
  end

  @spec dot(t, t) :: number
  def dot({a_x, a_y, a_z}, {b_x, b_y, b_z}) do
    a_x * b_x + a_y * b_y + a_z * b_z
  end

  @spec cross(t, t) :: t
  def cross({a_x, a_y, a_z}, {b_x, b_y, b_z}) do
    {
      a_y * b_z - a_z * b_y,
      a_z * b_x - a_x * b_z,
      a_x * b_y - a_y * b_x
    }
  end

  @spec length(t) :: number
  def length({x, y, z}) do
    :math.sqrt(x*x + y*y + z*z)
  end

  @spec normalize(t) :: t
  def normalize(a) do
    scale(a, 1 / length(a))
  end
end