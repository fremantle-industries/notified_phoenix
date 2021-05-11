defmodule NotifiedPhoenix.Receivers.Speech do
  defimpl Notified.Receiver do
    def send(_receiver, _notification) do
      :ok
    end
  end
end
