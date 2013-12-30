defmodule Pragtaxes do
  def add_taxes taxrates, orders do
    orders |> Enum.map fn [id: id, ship_to: state, net_amount: amount] ->
      rate = Keyword.get taxrates, state, 0
      [id: id, ship_to: state, net_amount: amount, total_amount: amount + amount * rate]
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
    [id, ship_to, net_amount] = line |> String.strip |> String.split(",")
    [id: binary_to_integer(id), ship_to: decode_state(ship_to), net_amount: binary_to_float(net_amount)]
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
