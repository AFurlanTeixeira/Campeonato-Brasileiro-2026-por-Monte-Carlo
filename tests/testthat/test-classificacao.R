# Testes de `calcular_classificacao()`.
#
# Usa uma "mini-liga" de 3-6 times fabricada a mao, com resultado esperado
# calculado manualmente -- inclusive um empate em pontos para exercitar os
# criterios de desempate (vitorias -> saldo de gols -> gols marcados).

test_that("ordena por pontos", {
  jogos <- data.frame(
    time_mandante = c("A", "B", "C"),
    gols_mandante = c(3, 1, 0),
    time_visitante = c("B", "C", "A"),
    gols_visitante = c(0, 1, 2),
    stringsAsFactors = FALSE
  )

  tabela <- calcular_classificacao(jogos)

  # A: 2 vitorias (6 pts) > C: 1 empate (1 pt) > B: 1 empate (1 pt),
  # mas B e C empatam em pontos -- desempate por saldo de gols decide.
  expect_equal(rownames(tabela), c("A", "C", "B"))
  expect_equal(tabela["A", "pontos"], 6)
  expect_equal(tabela["A", "vitorias"], 2)
})

test_that("desempate por saldo de gols", {
  # B e C terminam com os mesmos pontos e vitorias; C tem saldo melhor.
  jogos <- data.frame(
    time_mandante = c("A", "A", "B", "C"),
    gols_mandante = c(0, 0, 3, 5),
    time_visitante = c("B", "C", "D", "D"),
    gols_visitante = c(0, 0, 0, 0),
    stringsAsFactors = FALSE
  )

  tabela <- calcular_classificacao(jogos)

  expect_equal(tabela["B", "pontos"], tabela["C", "pontos"])
  expect_equal(tabela["B", "vitorias"], tabela["C", "vitorias"])
  expect_true(tabela["C", "saldo_gols"] > tabela["B", "saldo_gols"])
  expect_true(which(rownames(tabela) == "C") < which(rownames(tabela) == "B"))
})

test_that("marca rebaixados", {
  # 6 times, 4 sao rebaixados (TIMES_REBAIXADOS) -- so os 2 primeiros ficam de fora.
  jogos <- data.frame(
    time_mandante = c("A", "A", "B", "C", "D", "E"),
    gols_mandante = c(3, 3, 3, 3, 0, 0),
    time_visitante = c("B", "C", "D", "E", "F", "F"),
    gols_visitante = c(0, 0, 0, 0, 0, 0),
    stringsAsFactors = FALSE
  )

  tabela <- calcular_classificacao(jogos)

  expect_equal(sum(tabela$rebaixado), 4)
  expect_false(tabela["A", "rebaixado"])
})
