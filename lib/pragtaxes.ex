defmodule Pragtaxes do
  def add_taxes taxrates, orders do 
    orders |> Enum.map fn [id: id, ship_to: state, net_amount: amount] ->
      rate = Keyword.get taxrates, state, 0
      [id: id, ship_to: state, net_amount: amount, total_amount: amount + amount * rate]
    end
  end
end
