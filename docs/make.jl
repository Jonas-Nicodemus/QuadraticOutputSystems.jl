using QuadraticOutputSystems
using Documenter, DocumenterCitations

DocMeta.setdocmeta!(QuadraticOutputSystems, :DocTestSetup, :(using QuadraticOutputSystems); recursive=true)

bib = CitationBibliography(joinpath(@__DIR__, "..", "CITATION.bib"))

makedocs(;
    modules=[QuadraticOutputSystems],
    authors="Jonas Nicodemus <jonas.nicodemus@icloud.com> and contributors",
    sitename="QuadraticOutputSystems.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Jonas-Nicodemus.github.io/QuadraticOutputSystems.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "API" => "API.md",
    ],
    plugins=[bib],
)

deploydocs(;
    repo="github.com/Jonas-Nicodemus/QuadraticOutputSystems.jl",
    devbranch="main",
)
