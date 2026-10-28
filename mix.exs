defmodule YamlRustler.MixProject do
  use Mix.Project

  @version "0.3.0"
  @source_url "https://github.com/pluralsh/yaml_rustler"

  def project do
    [
      app: :yaml_rustler,
      version: @version,
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: "Fast YAML parsing using Rust's yaml-rust2 via Rustler",
      name: "YamlRustler",
      source_url: @source_url,
      homepage_url: @source_url,
      docs: docs()
    ]
  end

  defp package do
    [
      name: "yaml_rustler",
      files: ~w(lib .formatter.exs mix.exs README* LICENSE* CHANGELOG*
                native/yamlrustler/src native/yamlrustler/Cargo.toml
                native/yamlrustler/Cargo.lock native/yamlrustler/.cargo/config.toml
                checksum-*.exs),
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      # This will display the README on the main page
      main: "readme",
      extras: ["README.md", "CHANGELOG.md"],
      source_ref: "v#{@version}"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Only needed when building the NIF from source (YAML_RUSTLER_BUILD=1)
      {:rustler, ">= 0.0.0", optional: true, runtime: false},
      {:rustler_precompiled, "~> 0.8", runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      # For benchmarking
      {:benchee, "~> 1.5", only: :dev},
      # For benchmarking
      {:fast_yaml, "~> 1.0", only: :dev}
    ]
  end
end
