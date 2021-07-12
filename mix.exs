defmodule NotifiedPhoenix.MixProject do
  use Mix.Project

  # Also change package.json version
  @version "0.0.5"

  def project do
    [
      app: :notified_phoenix,
      version: @version,
      elixir: "~> 1.11",
      package: package(),
      start_permanent: Mix.env() == :prod,
      description: description(),
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      test_coverage: [tool: ExCoveralls]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:notified, "~> 0.0.6"},
      {:phoenix_html, "~> 2.14"},
      {:phoenix_live_view, "~> 0.15"},
      {:ex_machina, "~> 2.7", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:dialyxir, "~> 1.0", only: :dev, runtime: false},
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false},
      {:assert_html, ">= 0.0.1", only: :test},
      {:ex_unit_notifier, "~> 1.0", only: :test},
      {:excoveralls, "~> 0.10", only: :test}
    ]
  end

  defp description do
    "Phoenix view helpers for notified"
  end

  defp package do
    %{
      licenses: ["MIT"],
      maintainers: ["Alex Kwiatkowski"],
      links: %{"GitHub" => "https://github.com/fremantle-industries/notified_phoenix"},
      files: ~w(lib priv LICENSE mix.exs package.json README.md)
    }
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
