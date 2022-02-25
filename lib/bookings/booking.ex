defmodule Flightex.Bookings.Booking do
  @keys [:complete_date, :local_origin, :local_destination, :user_id, :id]
  @enforce_keys @keys
  defstruct @keys

  def build(complete_date, local_origin, local_destination, user_id) do
    {:ok,
     %__MODULE__{
       id: UUID.uuid4(),
       complete_date: complete_date,
       local_destination: local_destination,
       local_origin: local_origin,
       user_id: user_id
     }}
  end
end

defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings.{Booking, Agent}

  def call(%{
        complete_date: complete_date,
        local_destination: local_destination,
        local_origin: local_origin,
        user_id: user_id
      }) do
    case Booking.build(complete_date, local_origin, local_destination, user_id) do
      {:ok, user} -> Agent.save(user)
      {:error, _reason} = error -> error
    end
  end
end
