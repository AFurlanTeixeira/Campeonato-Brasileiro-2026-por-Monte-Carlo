#' Estimacao de theta (ataque) e phi (defesa) por time.
#'
#' Ver `.ai/modelagem.md` (ADR-002) para a definicao dada pelo enunciado:
#' theta = media de gols marcados por jogo; phi = media de gols sofridos por
#' jogo, considerando apenas os jogos ja disputados.
#'
#' Nucleo estatistico do laboratorio -- implementacao e responsabilidade do
#' grupo (parte avaliada).

#' Estima theta e phi para cada time a partir dos jogos ja disputados.
#'
#' Cada jogo contribui uma vez para o mandante (gols marcados/sofridos como
#' mandante) e uma vez para o visitante -- por isso os dois lados sao
#' empilhados antes de agregar por time (ADR-002).
#'
#' @param jogos_disputados jogos com `gols_mandante`/`gols_visitante`
#'   preenchidos (ver `jogos_disputados()` em `R/dados.R`).
#' @return data.frame indexado por time (nomes de linha), com colunas
#'   `theta` e `phi`.
estimar_parametros <- function(jogos_disputados) {
  times <- sort(unique(c(jogos_disputados$time_mandante, jogos_disputados$time_visitante)))

  marcados <- c(jogos_disputados$gols_mandante, jogos_disputados$gols_visitante)
  sofridos <- c(jogos_disputados$gols_visitante, jogos_disputados$gols_mandante)
  time_emp <- c(jogos_disputados$time_mandante, jogos_disputados$time_visitante)

  soma_marcados <- tapply(marcados, time_emp, sum)
  soma_sofridos <- tapply(sofridos, time_emp, sum)
  n_jogos <- tapply(marcados, time_emp, length)

  data.frame(
    theta = as.numeric(soma_marcados[times] / n_jogos[times]),
    phi = as.numeric(soma_sofridos[times] / n_jogos[times]),
    row.names = times
  )
}
