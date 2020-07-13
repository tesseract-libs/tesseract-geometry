defmodule Tesseract.Math.Vec4 do
  @type t :: {number, number, number, number}

  @spec make() :: t
  def make(), do: {0.0, 0.0, 0.0, 0.0}

  @spec make(number, number, number, number) :: t
  def make(x, y, z, w), do: {x, y, z, w}
  
  @spec make({number, number, number, number}) :: t
  def make({_x, _y, _z, _w} = v4), do: v4

  @spec new() :: t
  def new(), do: {0.0, 0.0, 0.0, 0.0}

  @spec new(number, number, number, number) :: t
  def new(x, y, z, w), do: {x, y, z, w}
  
  @spec new({number, number, number, number}) :: t
  def new({_x, _y, _z, _w} = v4), do: v4

  def x({x, _, _, _}), do: x
  def y({_, y, _, _}), do: y
  def z({_, _, z, _}), do: z
  def w({_, _, _, w}), do: w
  def xyz({x, y, z, _}), do: {x, y, z}
end