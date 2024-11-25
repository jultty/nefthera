(lang dune 3.16)

(name nefthera)

(generate_opam_files true)

(source
 (github jultty/nefthera))

(authors "Juno Takano <juno@jutty.dev>")

(maintainers "")

(license AGPL-3.0-or-later)

(documentation github.com/jultty/nefthera)

(package
 (name nefthera)
 (synopsis "A text-based RPG for your terminal")
 (description "Sëplenvon is a text-based medieval fantasy RPG for the unix terminal.")
 (depends ocaml dune)
 (tags
  (game RPG "text game" "terminal game")))
