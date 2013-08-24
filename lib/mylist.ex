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
end
