defmodule Tesseract.Geometry.BoxTest do
  alias Tesseract.Geometry.Box

  use ExUnit.Case, async: true

  test "Volume of a non-existent box is 0." do
    0 = Box.volume({{0, 0, 0}, {0, 0, 0}})
    0 = Box.volume({{1, 1, 1}, {1, 1, 1}})
    0 = Box.volume({{-1, -1, -1}, {-1, -1, -1}})
  end

  test "Volume of a box is computed correctly." do
    1 = Box.volume({{1, 1, 1}, {2, 2, 2}})
    1 = Box.volume({{-1, -1, -1}, {0, 0, 0}})
    1 = Box.volume({{-2, -2, -2}, {-1, -1, -1}})
    8 = Box.volume({{-1, -1, -1}, {1, 1, 1}})
  end

  test "Union of two boxes is computed correctly if either box is contained within the other." do
    {{0, 0, 0}, {2, 2, 2}} = Box.union({{0, 0, 0}, {1, 1, 1}}, {{0, 0, 0}, {2, 2, 2}})
    {{-1, -1, -1}, {1, 1, 1}} = Box.union({{0, 0, 0}, {1, 1, 1}}, {{-1, -1, -1}, {1, 1, 1}})    
    {{-1, -1, -1}, {2, 2, 2}} = Box.union({{0, 0, 0}, {1, 1, 1}}, {{-1, -1, -1}, {2, 2, 2}})
    {{1, 1, 1}, {2, 2, 2}} = Box.union({{1, 1, 1}, {2, 2, 2}}, {{1, 1, 1}, {2, 2, 2}})

    # Just flipped arguments - test commutativity.
    {{0, 0, 0}, {2, 2, 2}} = Box.union({{0, 0, 0}, {2, 2, 2}}, {{0, 0, 0}, {1, 1, 1}})
    {{-1, -1, -1}, {1, 1, 1}} = Box.union({{-1, -1, -1}, {1, 1, 1}}, {{0, 0, 0}, {1, 1, 1}})    
    {{-1, -1, -1}, {2, 2, 2}} = Box.union({{-1, -1, -1}, {2, 2, 2}}, {{0, 0, 0}, {1, 1, 1}})
    {{1, 1, 1}, {2, 2, 2}} = Box.union({{1, 1, 1}, {2, 2, 2}}, {{1, 1, 1}, {2, 2, 2}})
  end

  test "Union of two boxes is computed correctly if boxes do not overlap." do
    {{0, 0, 0}, {5, 5, 5}} = Box.union({{0, 0, 0}, {2, 2, 2}}, {{4, 4, 4}, {5, 5, 5}})
    {{-2, -2, -2}, {5, 5, 5}} = Box.union({{-2, -2, -2}, {-1, -1, -1}}, {{4, 4, 4}, {5, 5, 5}})
  end

  test "Union of two boxes is computed correctly if boxes are same." do
    {{1, 1, 1}, {2, 2, 2}} = Box.union({{1, 1, 1}, {2, 2, 2}}, {{1, 1, 1}, {2, 2, 2}})
    {{-1, -1, -1}, {-2, -2, -2}} = Box.union({{-1, -1, -1}, {-2, -2, -2}}, {{-1, -1, -1}, {-2, -2, -2}})
  end

  test "Intersection of two boxes is correctly detected." do
    true = Box.intersects?({{0, 0, 0}, {2, 2, 2}}, {{0, 0, 0}, {1, 1, 1}})
    true = Box.intersects?({{0, 0, 0}, {1, 1, 1}}, {{-1, -1, -1}, {2, 2, 2}})

    false = Box.intersects?({{1, 1, 1}, {2, 2, 2}}, {{-1, -1, -1}, {-2, -2, -2}})
  end

  test "Intersection of two boxes does not exist if boxes do not overlap." do
    nil = Box.intersection({{1, 1, 1}, {2, 2, 2}}, {{-1, -1, -1}, {-2, -2, -2}})

    # Just flipped arguments - test commutativity.
    nil = Box.intersection({{-1, -1, -1}, {-2, -2, -2}}, {{1, 1, 1}, {2, 2, 2}})
  end

  test "Intersection of boxes A and B when A is contained within B equals to A." do
    {{0, 0, 0}, {1, 1, 1}} = Box.intersection({{0, 0, 0}, {2, 2, 2}}, {{0, 0, 0}, {1, 1, 1}})
    {{0, 0, 0}, {1, 1, 1}} = Box.intersection({{-1, -1, -1}, {2, 2, 2}}, {{0, 0, 0}, {1, 1, 1}})

    # Flipped arguments - tests commutativity.
    {{0, 0, 0}, {1, 1, 1}} = Box.intersection({{0, 0, 0}, {1, 1, 1}}, {{0, 0, 0}, {2, 2, 2}})
    {{0, 0, 0}, {1, 1, 1}} = Box.intersection({{0, 0, 0}, {1, 1, 1}}, {{-1, -1, -1}, {2, 2, 2}})
  end

  test "Intersection volume between two boxes is computed correctly." do
    0 = Box.intersection_volume({{0, 0, 0}, {2, 2, 2}}, {{3, 3, 3}, {4, 4, 4}})
    0 = Box.intersection_volume({{0, 0, 0}, {0, 0, 0}}, {{0, 0, 0}, {0, 0, 0}})

    1 = Box.intersection_volume({{0, 0, 0}, {2, 2, 2}}, {{0, 0, 0}, {1, 1, 1}})
    8 = Box.intersection_volume({{0, 0, 0}, {2, 2, 2}}, {{0, 0, 0}, {2, 2, 2}})

    8 = Box.intersection_volume({{-2, -2, -2}, {0, 0, 0}}, {{-2, -2, -2}, {0, 0, 0}})
    8 = Box.intersection_volume({{-2, -2, -2}, {0, 0, 0}}, {{-2, -2, -2}, {2, 2, 2}})
  end

  test "Intersection volume between a box and a list of other boxes is computed correctly." do
    10 = Box.intersection_volume(
      {{-2, -2, -2}, {0, 0, 0}}, 
      [
        {{-2, -2, -2}, {0, 0, 0}}, 
        {{-2, -2, -2}, {-1, -1, -1}},
        {{-3, -3, -3}, {-1, -1, -1}},
        {{0, 0, 0}, {1, 1, 1}},
        {{1, 1, 1}, {4, 4, 4}}
      ]
    )
  end
end