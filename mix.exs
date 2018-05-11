defmodule TesseractGeometry.MixProject do
  use Mix.Project

  def project do
    [
      app: :tesseract_geometry,
      version: "0.1.1",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      source_url: "https://github.com/tesseract-libs/tesseract-geometry",
      homepage_url: "http://tesseract.games"
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
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end

  defp description() do
    "Common geometry utilities for Tesseract library bundle."
  end

  defp package() do
    [
      name: "tesseract_geometry",
      maintainers: ["Urban Soban"],
      licenses: ["MIT"],
      links: %{
        "github" => "https://github.com/tesseract-libs/tesseract-geometry",
        "tesseract.games" => "http://tesseract.games"
      },
      organisation: "tesseract",
      files: ["lib", "test", "config", "mix.exs", "README*", "LICENSE*"]
    ]
  end
end
