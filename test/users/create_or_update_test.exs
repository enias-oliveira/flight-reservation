defmodule Flightex.Users.CreateOrUpdateTest do
  use ExUnit.Case, async: true

  alias Flightex.Users.Agent

  describe "call/1" do
    setup do
      Agent.start_link(%{})
      # O Agent.start_link vai iniciar os 2 agents antes do teste
      # Deve ser implementado para os testes passarem
      :ok
    end

    test "when all params are valid, return a tuple" do
      params = %{
        name: "Jp",
        email: "jp@banana.com",
        cpf: "12345678900"
      }

      Flightex.create_or_update_user(params)

      {_ok, response} = Agent.get(params.cpf)

      expected_response = %Flightex.Users.User{
        cpf: "12345678900",
        email: "jp@banana.com",
        id: response.id,
        name: "Jp"
      }

      assert response == expected_response
    end

    test "when cpf is a integer, returns an error" do
      params = %{
        name: "Jp",
        email: "jp@banana.com",
        cpf: 12_345_678_900
      }

      expected_response = {:error, "Cpf must be a String"}

      response = Flightex.create_or_update_user(params)

      assert response == expected_response
    end
  end
end
