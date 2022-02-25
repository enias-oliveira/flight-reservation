defmodule Flightex.Bookings.Agent do
  use Agent

  alias Flightex.Bookings.Booking

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def save(%Booking{id: id} = booking) do
    Agent.update(__MODULE__, &Map.put(&1, id, booking))
    {:ok, id}
  end

  def get(uuid) do
    agent = Agent.get(__MODULE__, &Map.get(&1, uuid))

    if agent, do: {:ok, agent}, else: {:error, "Booking not found"}
  end
end
