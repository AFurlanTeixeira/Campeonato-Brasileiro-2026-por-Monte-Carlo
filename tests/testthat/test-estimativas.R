# Testes de `estimar_parametros()`.
#
# Mini-liga fabricada a mao: A joga 2 vezes (1 em casa, 1 fora) e B/C jogam
# 1 vez cada, para o calculo de theta/phi por time ser facil de conferir.

test_that("estima theta e phi como medias simples", {
  jogos <- data.frame(
    time_mandante = c("A", "B"),
    gols_mandante = c(3, 0),
    time_visitante = c("B", "A"),
    gols_visitante = c(1, 2),
    stringsAsFactors = FALSE
  )

  parametros <- estimar_parametros(jogos)

  # A: marcou 3 (mandante) e 2 (visitante) em 2 jogos -> theta = 2.5
  #    sofreu 1 (mandante) e 0 (visitante) em 2 jogos -> phi = 0.5
  expect_equal(parametros["A", "theta"], 2.5)
  expect_equal(parametros["A", "phi"], 0.5)

  # B: marcou 1 (visitante) e 0 (mandante) em 2 jogos -> theta = 0.5
  #    sofreu 3 (visitante) e 2 (mandante) em 2 jogos -> phi = 2.5
  expect_equal(parametros["B", "theta"], 0.5)
  expect_equal(parametros["B", "phi"], 2.5)
})

test_that("cada time aparece uma unica vez, ordenado por nome", {
  jogos <- data.frame(
    time_mandante = c("C", "A"),
    gols_mandante = c(1, 2),
    time_visitante = c("A", "B"),
    gols_visitante = c(1, 0),
    stringsAsFactors = FALSE
  )

  parametros <- estimar_parametros(jogos)

  expect_equal(rownames(parametros), c("A", "B", "C"))
  expect_equal(nrow(parametros), 3)
})
