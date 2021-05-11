defmodule NotifiedPhoenix.Config do
  def to_list do
    fetch_env!(:to_list)
  end

  defp fetch_env!(key) do
    Confex.fetch_env!(:notified_phoenix, key)
  end
end
