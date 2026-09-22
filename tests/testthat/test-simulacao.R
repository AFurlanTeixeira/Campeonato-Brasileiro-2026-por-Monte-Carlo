# Testes de `simular_jogo()`/`simular_temporada()`.
#
# Sao funcoes estocasticas: em vez de conferir valores exatos, testamos
# reprodutibilidade (mesma seed -> mesmo resultado) e propriedades
# estatisticas (media simulada convergindo para o lambda esperado com N
# grande), como orienta `.ai/padroes-codigo.md`.

test_that("simular_jogo e reprodutivel com a mesma seed", {
  placar1 <- simular_jogo(1.5, 1.0, 1.2, 0.8, seed = 42)
  placar2 <- simular_jogo(1.5, 1.0, 1.2, 0.8, seed = 42)

  expect_equal(placar1, placar2)
  expect_named(placar1, c("gols_mandante", "gols_visitante"))
})

test_that("simular_jogo converge para o lambda esperado (ADR-001)", {
  theta_mandante <- 2
  phi_mandante <- 1
  theta_visitante <- 1
  phi_visitante <- 1.5

  lambda_mandante_esperado <- (theta_mandante + phi_visitante) / 2
  lambda_visitante_esperado <- (theta_visitante + phi_mandante) / 2

  gols_mandante <- vapply(1:2000, function(s) {
    placar <- simular_jogo(theta_mandante, phi_mandante, theta_visitante, phi_visitante, seed = s)
    placar[["gols_mandante"]]
  }, numeric(1))

  expect_equal(mean(gols_mandante), lambda_mandante_esperado, tolerance = 0.1)
})

test_that("simular_temporada preenche todos os jogos pendentes", {
  parametros <- data.frame(
    theta = c(2, 1),
    phi = c(1, 1.5),
    row.names = c("A", "B")
  )
  pendentes <- data.frame(
    rodada = c(1, 2),
    time_mandante = c("A", "B"),
    gols_mandante = c(NA, NA),
    time_visitante = c("B", "A"),
    gols_visitante = c(NA, NA),
    stringsAsFactors = FALSE
  )

  simulados <- simular_temporada(pendentes, parametros, seed = 7)

  expect_equal(nrow(simulados), 2)
  expect_false(anyNA(simulados$gols_mandante))
  expect_false(anyNA(simulados$gols_visitante))
  expect_true(all(simulados$gols_mandante >= 0))
})

test_that("simular_temporada e reprodutivel com a mesma seed", {
  parametros <- data.frame(theta = 1.3, phi = 1.1, row.names = "A")
  pendentes <- data.frame(
    rodada = 1,
    time_mandante = "A",
    gols_mandante = NA,
    time_visitante = "A",
    gols_visitante = NA,
    stringsAsFactors = FALSE
  )

  sim1 <- simular_temporada(pendentes, parametros, seed = 99)
  sim2 <- simular_temporada(pendentes, parametros, seed = 99)

  expect_equal(sim1, sim2)
})
