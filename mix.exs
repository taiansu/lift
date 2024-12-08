defmodule Lift.MixProject do
  use Mix.Project

  def project do
    [
      app: :lift,
      version: "0.1.0",
      elixir: "~> 1.0",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Lift",
      source_url: "https://github.com/taiansu/lift"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp description do
    "Lift functions for working with multi-level nested lists"
  end

  defp package do
    [
      files: ~w(lib .formatter.exs mix.exs README* * LICENSE*),
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/taiansu/lift"}
    ]
  end
end
