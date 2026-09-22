#' Intervalos de confianca para theta/phi via bootstrap.
#'
#' Ver `.ai/modelagem.md` (ADR-003): reamostragem com reposicao dos jogos de
#' cada time, recalculando theta/phi em cada amostra. Nucleo estatistico do
#' laboratorio -- implementacao e responsabilidade do grupo (parte
#' avaliada).

#' Gera `n_reamostragens` estimativas de theta/phi por time via bootstrap.
#'
#' Para cada time, reamostra com reposicao os jogos que ele disputou (na
#' mesma representacao "uma linha por participacao em jogo" usada em
#' `estimar_parametros()`) e recalcula theta/phi em cada amostra.
#'
#' @param jogos_disputados jogos ja disputados (ver `jogos_disputados()` em
#'   `R/dados.R`).
#' @param n_reamostragens numero de amostras bootstrap.
#' @param seed semente do gerador de numeros aleatorios.
#' @return data.frame longo com uma linha por (time, reamostragem), colunas
#'   `time`, `theta` e `phi` -- pronto para calcular percentis (IC) ou
#'   plotar.
bootstrap_parametros <- function(jogos_disputados, n_reamostragens, seed) {
  set.seed(seed)

  times <- sort(unique(c(jogos_disputados$time_mandante, jogos_disputados$time_visitante)))
  marcados <- c(jogos_disputados$gols_mandante, jogos_disputados$gols_visitante)
  sofridos <- c(jogos_disputados$gols_visitante, jogos_disputados$gols_mandante)
  time_emp <- c(jogos_disputados$time_mandante, jogos_disputados$time_visitante)

  por_time <- lapply(times, function(time_atual) {
    indices <- which(time_emp == time_atual)
    n_jogos <- length(indices)
    reamostras <- replicate(n_reamostragens, sample(indices, n_jogos, replace = TRUE))

    data.frame(
      time = time_atual,
      theta = colMeans(matrix(marcados[reamostras], nrow = n_jogos)),
      phi = colMeans(matrix(sofridos[reamostras], nrow = n_jogos))
    )
  })

  do.call(rbind, por_time)
}

#' Calcula o IC por percentis a partir de amostras bootstrap.
#'
#' @param amostras valores de theta ou phi obtidos via bootstrap para um
#'   unico time.
#' @param confianca nivel de confianca (ex.: 0.95 para IC de 95%).
#' @return vetor `c(limite_inferior, limite_superior)`.
intervalo_confianca <- function(amostras, confianca = 0.95) {
  alfa <- 1 - confianca
  stats::quantile(amostras, probs = c(alfa / 2, 1 - alfa / 2), names = FALSE)
}
