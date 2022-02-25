defmodule Flightex.Users.Agent do
  use Agent

  alias Flightex.Users.User

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def save(%User{cpf: cpf} = user) do
    Agent.update(__MODULE__, &Map.put(&1, cpf, user))
  end

  def get(cpf) do
    agent = Agent.get(__MODULE__, &Map.get(&1, cpf))

    if !!agent, do: {:ok, agent}, else: {:error, "User not found"}
  end
end
