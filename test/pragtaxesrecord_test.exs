Code.require_file "test_helper.exs", __DIR__

defmodule PragRecordTaxesTest do
  use ExUnit.Case
  Record.import PragRecordTaxes.PragOrder, as: :order
  Record.import PragRecordTaxes.PragFullOrder, as: :full_order

  @tax_rates  [ NC: 0.075, TX: 0.08 ]
  def tax_rates, do: @tax_rates

  test "adds taxes to TX and NC" do
    orders = [
      order(id: 123, state: :NC, net_amount: 100.00),
      order(id: 125, state: :TX, net_amount:  24.00),
      ]
    with_taxes = PragRecordTaxes.add_taxes(tax_rates, orders)
    assert with_taxes == [
      full_order(id: 123, state: :NC, net_amount: 100.00, total_amount: 107.50),
      full_order(id: 125, state: :TX, net_amount:  24.00, total_amount:  25.92),
      ]

  end

  test "states without taxes" do
    orders = [
      order(id: 128, state: :MA, net_amount:  10.00),
      order(id: 129, state: :CA, net_amount: 102.00),
      ]
    with_taxes = PragRecordTaxes.add_taxes(tax_rates, orders)
    assert with_taxes == [
      full_order(id: 128, state: :MA, net_amount:  10.00, total_amount: 10.00),
      full_order(id: 129, state: :CA, net_amount: 102.00, total_amount: 102.00),
      ]
  end

  test "processes the csv file" do
    fixture_file = "#{Path.dirname(__FILE__)}/taxes_fixture.csv"
    processed = PragRecordTaxes.process_file(fixture_file, tax_rates)
    expected =
    [
      full_order(id: 123, state: :NC, net_amount:  100.00, total_amount: 107.50),
      full_order(id: 124, state: :OK, net_amount:  35.50, total_amount: 35.5),
      full_order(id: 125, state: :TX, net_amount:  24.00, total_amount: 25.92),
      full_order(id: 126, state: :TX, net_amount:  44.80, total_amount: 48.384),
      full_order(id: 127, state: :NC, net_amount:  25.00, total_amount: 26.875),
      full_order(id: 128, state: :MA, net_amount:  10.00, total_amount: 10.00),
      full_order(id: 129, state: :CA, net_amount:  102.00, total_amount: 102.00),
      full_order(id: 130, state: :NC, net_amount:  50.00, total_amount: 53.75),
      ]
    List.zip([processed, expected]) |> Enum.each fn {l, r} ->
      assert l == r
    end
    assert processed == expected
  end

  test "read csv line" do
    assert PragRecordTaxes.read_csv_line("123,:NC,100.00") == order(id: 123, state: :NC, net_amount:  100.00)
  end


end
