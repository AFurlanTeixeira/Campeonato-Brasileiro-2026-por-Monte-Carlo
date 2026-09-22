# Testes de `dados.R` (carregamento e filtros de jogos disputados/pendentes).

.csv_exemplo <- c(
  "rodada,time_mandante,gols_mandante,time_visitante,gols_visitante",
  "1,A,2,B,1",
  "1,C,,D,"
)

.criar_csv_temp <- function(linhas) {
  caminho <- tempfile(fileext = ".csv")
  writeLines(linhas, caminho)
  caminho
}

test_that("carregar_jogos le todas as linhas", {
  caminho <- .criar_csv_temp(.csv_exemplo)

  jogos <- carregar_jogos(caminho)
  expect_equal(nrow(jogos), 2)
})

test_that("carregar_jogos valida colunas", {
  caminho <- .criar_csv_temp(c("rodada,time_mandante", "1,A"))

  expect_error(carregar_jogos(caminho))
})

test_that("jogos_disputados e jogos_pendentes filtram corretamente", {
  caminho <- .criar_csv_temp(.csv_exemplo)
  jogos <- carregar_jogos(caminho)

  expect_equal(nrow(jogos_disputados(jogos)), 1)
  expect_equal(nrow(jogos_pendentes(jogos)), 1)
  expect_equal(jogos_pendentes(jogos)$time_mandante[1], "C")
})
