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
#' @param jogos_disputados jogos com `gols_mandante`/`gols_visitante`
#'   preenchidos (ver `jogos_disputados()` em `R/dados.R`).
#' @return data.frame indexado por time, com colunas `theta` e `phi`.
#'
#' TODO(grupo): implementar o estimador (ADR-002 em `.ai/modelagem.md`).
#' Lembrar que cada jogo contribui para o ataque/defesa de dois times (o
#' mandante e o visitante), cada um com seus proprios gols marcados/sofridos
#' naquele jogo.
estimar_parametros <- function(jogos_disputados) {
  stop("estimar_parametros ainda nao implementado")
}
