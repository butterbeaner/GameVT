# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Test.Repo.insert!(%Test.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Test.Novalores
alias Test.Repo
alias Test.Desafios
alias Test.Desafios.Desafio

Desafios.create_desafio("Ejemplo de desafio: esta seria la descripcion del desafio")
Novalores.create_novalor("Ejemplo 1 de disvalor: esta seria la descripcion del disvalor")
Novalores.create_novalor("Ejemplo 2 de disvalor: esta seria la descripcion del disvalor")
Novalores.create_novalor("Ejemplo 3 de disvalor: esta seria la descripcion del disvalor")
Valores.create_valor("Ejemplo 1 de valor: esta seria la descripcion del valor")
Valores.create_valor("Ejemplo 2 de valor: esta seria la descripcion del valor")
Valores.create_valor("Ejemplo 3 de valor: esta seria la descripcion del valor")
