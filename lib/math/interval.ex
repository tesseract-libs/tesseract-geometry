defmodule Tesseract.Math.Interval do
  defguard is_valid_interval(s, e) when is_number(s) and is_number(e) and s <= e

  def make(s, e) when is_number(s) and is_number(e) do
    {min(s, e), max(s, e)}
  end

  def start_value({s, e}) when is_valid_interval(s, e), do: s

  def end_value({s, e}) when is_valid_interval(s, e), do: e

  # Does interval A intersect interval B?
  def intersects?({a_min, a_max}, {b_min, b_max})
    when is_valid_interval(a_min, a_max) and is_valid_interval(b_min, b_max)
  do
    b_min <= a_max && b_max >= a_min
  end

  def is_point?({a, a}), do: true
  def is_point?(_), do: false
end