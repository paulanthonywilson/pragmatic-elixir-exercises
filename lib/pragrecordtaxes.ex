
defmodule PragRecordTaxes do
  defrecord PragOrder, id: nil, state: nil, net_amount: nil
  defrecord PragFullOrder, id: nil, state: nil, net_amount: nil, total_amount: nil


  def add_taxes taxrates, orders do
    orders |> Enum.map fn order ->
      rate = Keyword.get taxrates, order.state, 0
      PragFullOrder[id: order.id, state: order.state, net_amount: order.net_amount, total_amount: order.net_amount + order.net_amount * rate]
    end
  end

  def decode_state state_string do
    case state_string do
      ":NC" -> :NC
      ":OK" -> :OK
      ":MA" -> :MA
      ":CA" -> :CA
      ":TX" -> :TX
    end
  end

  def read_csv_line line do
    [id, state, net_amount] = line |> String.strip |> String.split(",")
    PragOrder[id: binary_to_integer(id), state: decode_state(state), net_amount: binary_to_float(net_amount)]
  end


  def process_file filename, tax_rates do
    {:ok, records} = File.open filename, [:read], fn file ->
      IO.read(file, :line) # discard first line
      file |> IO.stream(:line)
           |> Enum.map &read_csv_line(&1)
    end
    add_taxes(tax_rates, records)
  end
end
