# Testes de `bootstrap_parametros()`/`intervalo_confianca()`.

test_that("bootstrap_parametros gera n_reamostragens linhas por time", {
  jogos <- data.frame(
    time_mandante = c("A", "B", "A"),
    gols_mandante = c(3, 0, 2),
    time_visitante = c("B", "A", "B"),
    gols_visitante = c(1, 2, 0),
    stringsAsFactors = FALSE
  )

  boot <- bootstrap_parametros(jogos, n_reamostragens = 50, seed = 1)

  expect_equal(nrow(boot), 100) # 2 times x 50 reamostragens
  expect_equal(sort(unique(boot$time)), c("A", "B"))
  expect_equal(sum(boot$time == "A"), 50)
})

test_that("bootstrap_parametros e reprodutivel com a mesma seed", {
  jogos <- data.frame(
    time_mandante = c("A", "B"),
    gols_mandante = c(3, 0),
    time_visitante = c("B", "A"),
    gols_visitante = c(1, 2),
    stringsAsFactors = FALSE
  )

  boot1 <- bootstrap_parametros(jogos, n_reamostragens = 20, seed = 5)
  boot2 <- bootstrap_parametros(jogos, n_reamostragens = 20, seed = 5)

  expect_equal(boot1, boot2)
})

test_that("intervalo_confianca calcula os percentis esperados", {
  amostras <- 1:100 # percentil 2.5% = 3.475, 97.5% = 97.525

  ic <- intervalo_confianca(amostras, confianca = 0.95)

  expect_length(ic, 2)
  expect_true(ic[1] < ic[2])
  expect_equal(ic, as.numeric(quantile(amostras, c(0.025, 0.975))))
})
