defmodule Instream.Mixfile do
  use Mix.Project

  @url_github "https://github.com/mneudert/instream"

  def project do
    [
      app: :instream,
      name: "Instream",
      version: "0.20.0-dev",
      elixir: "~> 1.5",
      deps: deps(),
      description: "InfluxDB driver for Elixir",
      docs: docs(),
      elixirc_paths: elixirc_paths(Mix.env()),
      package: package(),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.travis": :test
      ],
      test_coverage: [tool: ExCoveralls]
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      included_applications: [:influxql]
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:excoveralls, "~> 0.10", only: :test, runtime: false},
      {:hackney, "~> 1.1"},
      {:influxql, "~> 0.2.0"},
      {:poison, "~> 3.0"},
      {:poolboy, "~> 1.5"}
    ]
  end

  defp docs do
    [
      extras: ["CHANGELOG.md", "README.md"],
      main: "readme",
      source_ref: "master",
      source_url: @url_github
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/helpers"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    %{
      files: [".formatter.exs", "CHANGELOG.md", "LICENSE", "mix.exs", "README.md", "lib"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => @url_github},
      maintainers: ["Marc Neudert"]
    }
  end
end
