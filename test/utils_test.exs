Code.require_file "test_helper.exs", __DIR__

defmodule SumTest do
  use ExUnit.Case

  test "sum of empty" do
    assert Sum.of [] == 0
  end
end
