Code.require_file "test_helper.exs", __DIR__

defmodule MyListTest do
  use ExUnit.Case

  # This should be a Macro, but I haven't done those yet :-/
  def assert_equiv_fun function_under_test_atom do
      under5 = fn n -> n < 5 end
      fn(list) ->
        assert apply(MyList, function_under_test_atom, [list, under5]) ==
               apply(Enum, function_under_test_atom, [list, under5])
      end
  end


  test "all?" do

    assert_equiv = assert_equiv_fun(:all?)
    assert_equiv.([])
    assert_equiv.([1])
    assert_equiv.([5])
    assert_equiv.([1,3,4])
    assert_equiv.([1,3,4, 5])
  end

  test "filter" do
    assert_equiv = assert_equiv_fun(:filter)

    assert_equiv.([])
    assert_equiv.([5])
    assert_equiv.([4])
    assert_equiv.([3,4,5,6,2])
  end

  test "each" do
    # mmm, how do I test this without side-effects????
    assert MyList.each([], IO.puts(&1)) == :ok
    assert MyList.each([1], IO.puts(&1)) == :ok
    assert MyList.each([1, 2], IO.puts(&1)) == :ok
  end

  test "split" do
    assert_equiv = fn(list, n)-> assert MyList.split(list, n) == Enum.split(list, n) end
    assert_equiv.([],0)
    assert_equiv.([],1)


    assert_equiv.([1,2,3],0)
    assert_equiv.([1,2,3],1)
    assert_equiv.([1,2,3],2)
    assert_equiv.([1,2,3],3)
    assert_equiv.([1,2],3)


    assert_equiv.([],-1)


    assert_equiv.([1,2,3],-1)
    assert_equiv.([1,2,3],-2)
    assert_equiv.([1,2,3],-3)
    assert_equiv.([1,2],-3)


    assert_equiv.([1,2,3, 4, 5],-2)

  end


  test "flatten" do
    assert_equiv = fn(list)-> assert MyList.flatten(list) == List.flatten(list) end

    assert_equiv.([])
    assert_equiv.([1,2,3])

    assert_equiv.([1,2,[3]])
    assert_equiv.([1, [2, [2]], 3])
    assert_equiv.([1, [2, [[2,2]]], 3])

  end


end
