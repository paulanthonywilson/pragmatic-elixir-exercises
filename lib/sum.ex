defmodule Sum do
  def of([]), do: 0
  def of([n]), do: n
  def of([h|t]) do
    h + of(t)
  end
end
