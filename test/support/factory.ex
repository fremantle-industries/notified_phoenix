defmodule NotifiedPhoenix.Factory do
  use ExMachina.Ecto, repo: Notified.Repo

  def notification_factory do
    %Notified.Notification{
      message: sequence(:message, &"Notification message #{&1}")
    }
  end
end
