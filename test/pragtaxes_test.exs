Code.require_file "test_helper.exs", __DIR__

defmodule PragtaxesTest do
  use ExUnit.Case

  @tax_rates  [ NC: 0.075, TX: 0.08 ]
  def tax_rates, do: @tax_rates

  test "adds taxes to TX and NC" do
    orders = [
    [ id: 123, ship_to: :NC, net_amount: 100.00 ],
    [ id: 125, ship_to: :TX, net_amount:  24.00 ],
    ]
    with_taxes = Pragtaxes.add_taxes(tax_rates, orders)
    assert with_taxes == [
    [ id: 123, ship_to: :NC, net_amount: 100.00, total_amount: 107.50 ],
    [ id: 125, ship_to: :TX, net_amount:  24.00, total_amount:  25.92],
    ]

end

  test "states without taxes" do
    orders = [
    [ id: 128, ship_to: :MA, net_amount:  10.00 ],
    [ id: 129, ship_to: :CA, net_amount: 102.00 ],
    ]
    with_taxes = Pragtaxes.add_taxes(tax_rates, orders)
    assert with_taxes == [
    [ id: 128, ship_to: :MA, net_amount:  10.00, total_amount: 10.00 ],
    [ id: 129, ship_to: :CA, net_amount: 102.00, total_amount: 102.00 ],
    ]
  end


end
