Code.require_file "test_helper.exs", __DIR__

defmodule CharListsTest do
  use ExUnit.Case

  test "detect single character strings" do
    assert MyCharList.list_printable?([])
    assert MyCharList.list_printable?(' ')
    assert !MyCharList.list_printable?([31])
    assert !MyCharList.list_printable?([127])
    assert MyCharList.list_printable?('~')
    assert MyCharList.list_printable?('Now is the winter of our discount tents')
    assert !MyCharList.list_printable?([?n, 31, ?o])
  end

  test "anagram" do
    assert MyCharList.anagram?('now', 'won')
    assert !MyCharList.anagram?('nows', 'won')
    assert !MyCharList.anagram?('now', 'ton')
    assert !MyCharList.anagram?('now', 'wow')
  end
end

defmodule MyDqsTest do
  use ExUnit.Case
  test "centre" do
    assert MyDqs.centre(["cat", "zebra", "elephant"]) ==
"  cat
 zebra
elephant"
  end
  test "max_length" do
    assert MyDqs.max_length(["cat", "zebra", "elephant", "dog"]) == 8
    assert MyDqs.max_length([]) == 0
  end


  test "capitalise sentences" do
    assert MyDqs.capitalise_sentences("oh") == "Oh"
    assert MyDqs.capitalise_sentences("oh") == "Oh"
    assert MyDqs.capitalise_sentences("oh. mY. dOg.") == "Oh. My. Dog."
  end
end



