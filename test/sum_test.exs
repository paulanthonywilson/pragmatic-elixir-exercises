Code.require_file "test_helper.exs", __DIR__

defmodule SumTest do
  use ExUnit.Case

  test "sum of empty" do
    assert Sum.of([]) == 0
  end

  test "sum of single item list" do
    assert Sum.of([3]) == 3
  end


  test "sum of many item list" do
    assert Sum.of([1,2]) == 3
    assert Sum.of([1,2,3]) == 6
  end
end
