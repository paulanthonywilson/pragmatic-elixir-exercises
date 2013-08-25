defmodule MyList do
  def all?([], _fun), do: true
  def all?([h|t], fun), do: fun.(h) && all?(t, fun)

  def each([], _), do: :ok
  def each([h|t], fun) do
    fun.(h)
    each(t, fun)
  end


  def filter([], _fun), do: []
  def filter(list = [h|_], fun), do: filter(list, fun, fun.(h))
  def filter([h|t], fun, true), do: [h | filter(t,fun)]
  def filter([_|t], fun, false), do: filter(t,fun)


  def split(list,n) when n < 0 do
    {l,r} = split(Enum.reverse(list), -n)
    {Enum.reverse(r), Enum.reverse(l)}
  end

  def split(list, n), do: _split([], list, n)

  defp _split(l, r, 0), do: {l,r}
  defp _split(l, [], _), do: {l,[]}
  defp _split(l,[h|t], n), do: _split(l ++ [h], t, n-1)


  def flatten([]), do: []
  def flatten([h|t]) when is_list(h), do: flatten(h) ++ flatten(t)
  def flatten([h|t]), do: [h] ++ flatten(t)

end


