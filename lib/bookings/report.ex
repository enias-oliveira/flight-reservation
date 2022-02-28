defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent

  def generate(filename) do
    File.write(filename, build_bookings_list())
  end

  defp build_bookings_list(),
    do: Agent.get_all() |> Enum.map(fn {_order_id, order} -> parse_to_csv_line(order) end)

  defp parse_to_csv_line(%{
         user_id: user_id,
         local_origin: local_origin,
         local_destination: local_destination,
         complete_date: complete_date
       }) do
    "#{user_id},#{local_origin},#{local_destination},#{complete_date}"
  end
end
