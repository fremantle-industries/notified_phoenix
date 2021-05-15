defmodule NotifiedPhoenix.Receivers.BrowserNotification do
  @type t :: %__MODULE__{}

  @enforce_keys ~w[]a
  defstruct ~w[]a

  defimpl Notified.Receiver do
    def send(_receiver, _notification) do
      :ok
    end
  end
end
