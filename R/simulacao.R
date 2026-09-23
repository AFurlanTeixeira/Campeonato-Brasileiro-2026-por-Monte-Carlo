#' Simulacao Monte Carlo dos jogos pendentes.
#'
#' Ver `.ai/modelagem.md` (ADR-001) para o modelo de gols dado pelo
#' enunciado. Nucleo estatistico do laboratorio -- implementacao e
#' responsabilidade do grupo (parte avaliada).

#' Simula o placar de um jogo via Poisson (ADR-001).
#'
#' Util para simular um confronto isolado (ex.: exemplos, testes). Para uma
#' temporada inteira, prefira `simular_temporada()`, que vetoriza a
#' amostragem em vez de chamar esta funcao jogo a jogo.
#'
#' @param theta_mandante taxa de gols marcados do time mandante.
#' @param phi_mandante taxa de gols sofridos do time mandante.
#' @param theta_visitante taxa de gols marcados do time visitante.
#' @param phi_visitante taxa de gols sofridos do time visitante.
#' @param seed semente do gerador de numeros aleatorios, passada
#'   explicitamente para reprodutibilidade (ver `.ai/padroes-codigo.md`).
#' @param h fator de vantagem de mandante (atividade extra, ver
#'   `docs/relatorio.Rmd`, secao "Atividade extra"). `h = 1` (padrao)
#'   reproduz o modelo do enunciado, sem vantagem de mandante.
#' @return vetor nomeado `c(gols_mandante = ..., gols_visitante = ...)`.
simular_jogo <- function(theta_mandante, phi_mandante, theta_visitante, phi_visitante,
                         seed, h = 1) {
  set.seed(seed)

  lambda_mandante <- (theta_mandante + phi_visitante) / 2 * h
  lambda_visitante <- (theta_visitante + phi_mandante) / 2 / h

  c(
    gols_mandante = rpois(1, lambda_mandante),
    gols_visitante = rpois(1, lambda_visitante)
  )
}

#' Simula todos os jogos pendentes de uma temporada, uma vez.
#'
#' Vetorizada: os lambdas de todos os jogos pendentes sao calculados de uma
#' vez e os gols sao amostrados com duas chamadas a `rpois()`, em vez de um
#' loop jogo a jogo (ver `.ai/padroes-codigo.md`).
#'
#' @param jogos_pendentes jogos ainda nao realizados (ver `jogos_pendentes()`
#'   em `R/dados.R`).
#' @param parametros theta/phi por time, indexado por nome do time (saida de
#'   `estimar_parametros()`).
#' @param seed semente do gerador de numeros aleatorios.
#' @param h fator de vantagem de mandante (atividade extra, ver
#'   `docs/relatorio.Rmd`, secao "Atividade extra"). `h = 1` (padrao)
#'   reproduz o modelo do enunciado, sem vantagem de mandante.
#' @return copia de `jogos_pendentes` com `gols_mandante`/`gols_visitante`
#'   preenchidos com os resultados simulados.
simular_temporada <- function(jogos_pendentes, parametros, seed, h = 1) {
  set.seed(seed)

  theta_mandante <- parametros[jogos_pendentes$time_mandante, "theta"]
  phi_mandante <- parametros[jogos_pendentes$time_mandante, "phi"]
  theta_visitante <- parametros[jogos_pendentes$time_visitante, "theta"]
  phi_visitante <- parametros[jogos_pendentes$time_visitante, "phi"]

  lambda_mandante <- (theta_mandante + phi_visitante) / 2 * h
  lambda_visitante <- (theta_visitante + phi_mandante) / 2 / h

  n <- nrow(jogos_pendentes)
  jogos_pendentes$gols_mandante <- rpois(n, lambda_mandante)
  jogos_pendentes$gols_visitante <- rpois(n, lambda_visitante)

  jogos_pendentes
}
