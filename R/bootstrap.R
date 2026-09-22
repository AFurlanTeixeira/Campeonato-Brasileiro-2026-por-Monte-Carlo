#' Intervalos de confianca para theta/phi via bootstrap.
#'
#' Ver `.ai/modelagem.md` (ADR-003): reamostragem com reposicao dos jogos de
#' cada time, recalculando theta/phi em cada amostra. Nucleo estatistico do
#' laboratorio -- implementacao e responsabilidade do grupo (parte
#' avaliada).

#' Gera `n_reamostragens` estimativas de theta/phi por time via bootstrap.
#'
#' @param jogos_disputados jogos ja disputados (ver `jogos_disputados()` em
#'   `R/dados.R`).
#' @param n_reamostragens numero de amostras bootstrap.
#' @param seed semente do gerador de numeros aleatorios.
#' @return data.frame longo com uma linha por (time, reamostragem), colunas
#'   `theta` e `phi` -- pronto para calcular percentis (IC) ou plotar.
#'
#' TODO(grupo): para cada time, reamostrar os jogos dele com reposicao
#' (`n_reamostragens` vezes) e recalcular theta/phi em cada amostra usando
#' `estimar_parametros()` (ou a logica equivalente por time).
bootstrap_parametros <- function(jogos_disputados, n_reamostragens, seed) {
  stop("bootstrap_parametros ainda nao implementado")
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
