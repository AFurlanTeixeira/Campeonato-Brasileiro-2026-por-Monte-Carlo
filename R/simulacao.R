#' Simulacao Monte Carlo dos jogos pendentes.
#'
#' Ver `.ai/modelagem.md` (ADR-001) para o modelo de gols dado pelo
#' enunciado. Nucleo estatistico do laboratorio -- implementacao e
#' responsabilidade do grupo (parte avaliada).

#' Simula o placar de um jogo via Poisson (ADR-001).
#'
#' @param theta_mandante taxa de gols marcados do time mandante.
#' @param phi_mandante taxa de gols sofridos do time mandante.
#' @param theta_visitante taxa de gols marcados do time visitante.
#' @param phi_visitante taxa de gols sofridos do time visitante.
#' @param seed semente do gerador de numeros aleatorios, passada
#'   explicitamente para reprodutibilidade (ver `.ai/padroes-codigo.md`).
#' @return vetor nomeado `c(gols_mandante = ..., gols_visitante = ...)`.
#'
#' TODO(grupo): implementar a amostragem Poisson com os parametros
#' `(theta_mandante + phi_visitante) / 2` e
#' `(theta_visitante + phi_mandante) / 2`.
simular_jogo <- function(theta_mandante, phi_mandante, theta_visitante, phi_visitante, seed) {
  stop("simular_jogo ainda nao implementado")
}

#' Simula todos os jogos pendentes de uma temporada, uma vez.
#'
#' @param jogos_pendentes jogos ainda nao realizados (ver `jogos_pendentes()`
#'   em `R/dados.R`).
#' @param parametros theta/phi por time (saida de `estimar_parametros()`).
#' @param seed semente do gerador de numeros aleatorios.
#' @return copia de `jogos_pendentes` com `gols_mandante`/`gols_visitante`
#'   preenchidos com os resultados simulados.
#'
#' TODO(grupo): aplicar `simular_jogo()` a cada linha, usando os parametros
#' do mandante e do visitante de cada jogo.
simular_temporada <- function(jogos_pendentes, parametros, seed) {
  stop("simular_temporada ainda nao implementado")
}
