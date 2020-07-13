defmodule Tesseract.Math.Vec3 do
  @type t :: {number, number, number}

  @spec make() :: t
  def make(), do: {0.0, 0.0, 0.0}

  @spec make(number, number, number) :: t
  def make(x, y, z), do: {x, y, z}
  
  @spec make({number, number, number}) :: t
  def make({x, y, z}), do: {x, y, z}

  def x({x_value, _y_value, _z_value}), do: x_value
  def x({_x_value, y_value, z_value}, x_value), do: {x_value, y_value, z_value}
  def y({_x_value, y_value, _z_value}), do: y_value
  def y({x_value, _y_value, z_value}, y_value), do: {x_value, y_value, z_value}
  def z({_x_value, _y_value, z_value}), do: z_value
  def z({x_value, y_value, _z_value}, z_value), do: {x_value, y_value, z_value}

  @spec add(t, t) :: t
  def add({a_x, a_y, a_z}, {b_x, b_y, b_z}) do
    {a_x + b_x, a_y + b_y, a_z + b_z}
  end

  @spec subtract(t, t) :: t
  def subtract({a_x, a_y, a_z}, {b_x, b_y, b_z}) do
    {a_x - b_x, a_y - b_y, a_z - b_z}
  end

  @spec multiply(t, t) :: t
  def multiply({a_x, a_y, a_z}, {b_x, b_y, b_z}) do
    {a_x * b_x, a_y * b_y, a_z * b_z}
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

  def angle(a, b) do
    :math.acos(dot(a,b) / (__MODULE__.length(a) * __MODULE__.length(b)))
  end

  @spec length(t) :: number
  def length({x, y, z}) do
    :math.sqrt(x*x + y*y + z*z)
  end

  @spec normalize(t) :: t
  def normalize(a) do
    scale(a, 1 / __MODULE__.length(a))
  end
end