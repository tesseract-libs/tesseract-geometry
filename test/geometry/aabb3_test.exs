defmodule Tesseract.Geometry.AABB3Test do
  alias Tesseract.Geometry.AABB3

  use ExUnit.Case, async: true

  test "Volume of a non-existent box is 0." do
    0 = AABB3.volume(AABB3.make({{0, 0, 0}, {0, 0, 0}}))
    0 = AABB3.volume(AABB3.make({{1, 1, 1}, {1, 1, 1}}))
    0 = AABB3.volume(AABB3.make({{-1, -1, -1}, {-1, -1, -1}}))
  end

  test "Volume of a box is computed correctly." do
    1 = AABB3.volume(AABB3.make({{1, 1, 1}, {2, 2, 2}}))
    1 = AABB3.volume(AABB3.make({{-1, -1, -1}, {0, 0, 0}}))
    1 = AABB3.volume(AABB3.make({{-2, -2, -2}, {-1, -1, -1}}))
    8 = AABB3.volume(AABB3.make({{-1, -1, -1}, {1, 1, 1}}))
  end

  test "Union of two boxes is computed correctly if either box is contained within the other." do
    {{0, 0, 0}, {2, 2, 2}} = AABB3.union(AABB3.make({{0, 0, 0}, {1, 1, 1}}), AABB3.make({{0, 0, 0}, {2, 2, 2}}))
    {{-1, -1, -1}, {1, 1, 1}} = AABB3.union(AABB3.make({{0, 0, 0}, {1, 1, 1}}), AABB3.make({{-1, -1, -1}, {1, 1, 1}}))    
    {{-1, -1, -1}, {2, 2, 2}} = AABB3.union(AABB3.make({{0, 0, 0}, {1, 1, 1}}), AABB3.make({{-1, -1, -1}, {2, 2, 2}}))
    {{1, 1, 1}, {2, 2, 2}} = AABB3.union(AABB3.make({{1, 1, 1}, {2, 2, 2}}), AABB3.make({{1, 1, 1}, {2, 2, 2}}))

    # Just flipped arguments - test commutativity.
    {{0, 0, 0}, {2, 2, 2}} = AABB3.union(AABB3.make({{0, 0, 0}, {2, 2, 2}}), AABB3.make({{0, 0, 0}, {1, 1, 1}}))
    {{-1, -1, -1}, {1, 1, 1}} = AABB3.union(AABB3.make({{-1, -1, -1}, {1, 1, 1}}), AABB3.make({{0, 0, 0}, {1, 1, 1}}))    
    {{-1, -1, -1}, {2, 2, 2}} = AABB3.union(AABB3.make({{-1, -1, -1}, {2, 2, 2}}), AABB3.make({{0, 0, 0}, {1, 1, 1}}))
    {{1, 1, 1}, {2, 2, 2}} = AABB3.union(AABB3.make({{1, 1, 1}, {2, 2, 2}}), AABB3.make({{1, 1, 1}, {2, 2, 2}}))
  end

  test "Union of two boxes is computed correctly if boxes do not overlap." do
    {{0, 0, 0}, {5, 5, 5}} = AABB3.union(AABB3.make({{0, 0, 0}, {2, 2, 2}}), AABB3.make({{4, 4, 4}, {5, 5, 5}}))
    {{-2, -2, -2}, {5, 5, 5}} = AABB3.union(AABB3.make({{-2, -2, -2}, {-1, -1, -1}}), AABB3.make({{4, 4, 4}, {5, 5, 5}}))
  end

  test "Union of two boxes is computed correctly if boxes are same." do
    {{1, 1, 1}, {2, 2, 2}} = AABB3.union(AABB3.make({{1, 1, 1}, {2, 2, 2}}), AABB3.make({{1, 1, 1}, {2, 2, 2}}))
    {{-2, -2, -2}, {-1, -1, -1}} = AABB3.union(AABB3.make({{-1, -1, -1}, {-2, -2, -2}}), AABB3.make({{-1, -1, -1}, {-2, -2, -2}}))
  end

  test "Intersection of two boxes is correctly detected." do
    true = AABB3.intersects?(AABB3.make({{0, 0, 0}, {2, 2, 2}}), AABB3.make({{0, 0, 0}, {1, 1, 1}}))
    true = AABB3.intersects?(AABB3.make({{0, 0, 0}, {1, 1, 1}}), AABB3.make({{-1, -1, -1}, {2, 2, 2}}))

    false = AABB3.intersects?(AABB3.make({{1, 1, 1}, {2, 2, 2}}), AABB3.make({{-1, -1, -1}, {-2, -2, -2}}))
  end

  test "Intersection of two boxes does not exist if boxes do not overlap." do
    nil = AABB3.intersection(AABB3.make({{1, 1, 1}, {2, 2, 2}}), AABB3.make({{-1, -1, -1}, {-2, -2, -2}}))

    # Just flipped arguments - test commutativity.
    nil = AABB3.intersection(AABB3.make({{-1, -1, -1}, {-2, -2, -2}}), AABB3.make({{1, 1, 1}, {2, 2, 2}}))
  end

  test "Intersection of boxes A and B when A is contained within B equals to A." do
    {{0, 0, 0}, {1, 1, 1}} = AABB3.intersection(AABB3.make({{0, 0, 0}, {2, 2, 2}}), AABB3.make({{0, 0, 0}, {1, 1, 1}}))
    {{0, 0, 0}, {1, 1, 1}} = AABB3.intersection(AABB3.make({{-1, -1, -1}, {2, 2, 2}}), AABB3.make({{0, 0, 0}, {1, 1, 1}}))

    # Flipped arguments - tests commutativity.
    {{0, 0, 0}, {1, 1, 1}} = AABB3.intersection(AABB3.make({{0, 0, 0}, {1, 1, 1}}), AABB3.make({{0, 0, 0}, {2, 2, 2}}))
    {{0, 0, 0}, {1, 1, 1}} = AABB3.intersection(AABB3.make({{0, 0, 0}, {1, 1, 1}}), AABB3.make({{-1, -1, -1}, {2, 2, 2}}))
  end

  test "Intersection volume between two boxes is computed correctly." do
    0 = AABB3.intersection_volume(AABB3.make({{0, 0, 0}, {2, 2, 2}}), AABB3.make({{3, 3, 3}, {4, 4, 4}}))
    0 = AABB3.intersection_volume(AABB3.make({{0, 0, 0}, {0, 0, 0}}), AABB3.make({{0, 0, 0}, {0, 0, 0}}))

    1 = AABB3.intersection_volume(AABB3.make({{0, 0, 0}, {2, 2, 2}}), AABB3.make({{0, 0, 0}, {1, 1, 1}}))
    8 = AABB3.intersection_volume(AABB3.make({{0, 0, 0}, {2, 2, 2}}), AABB3.make({{0, 0, 0}, {2, 2, 2}}))

    8 = AABB3.intersection_volume(AABB3.make({{-2, -2, -2}, {0, 0, 0}}), AABB3.make({{-2, -2, -2}, {0, 0, 0}}))
    8 = AABB3.intersection_volume(AABB3.make({{-2, -2, -2}, {0, 0, 0}}), AABB3.make({{-2, -2, -2}, {2, 2, 2}}))
  end

  test "Center of a box is computed correctly." do
    {0.5, 0.5, 0.5} = AABB3.center(AABB3.make({{0, 0, 0}, {1, 1, 1}}))
    {-0.5, -0.5, -0.5} = AABB3.center(AABB3.make({{-1, -1, -1}, {0, 0, 0}}))

    {-3.0, -3.0, -3.0} = AABB3.center(AABB3.make({{-4, -4, -4}, {-2, -2, -2}}))
    {0.5, -2.0, -1.0} = AABB3.center(AABB3.make({{-2, -3, -4}, {3, -1, 2}}))
  end
end