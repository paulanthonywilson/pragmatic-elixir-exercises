defmodule MyCharList do
  @min_printable  32 # space
  @max_printable  ?~

  def list_printable?([]), do: true
  def list_printable?([h|_]) when h < @min_printable or h > @max_printable, do: false
  def list_printable?([_|t]), do: list_printable?(t)





  def anagram?(l, r) do 
    Enum.sort(l) == Enum.sort(r)
  end

end

defmodule MyDqs do
  def centre(dqs_list) do
    max = max_length(dqs_list)
    dqs_list 
      |> Enum.map(fn(dqs) ->
      fill = String.duplicate(" ", trunc((max -   String.length(dqs)) / 2))
      fill <> dqs
    end)
      |> Enum.join "\n"
  end

  def max_length(dqs_list) do
    dqs_list |> Enum.reduce(0, fn(x, acc) -> max(String.length(x), acc) end)
  end
end

