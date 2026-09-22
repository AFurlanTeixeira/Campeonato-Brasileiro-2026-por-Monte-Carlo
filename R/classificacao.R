#' Calculo da tabela de classificacao a partir de uma tabela de resultados.
#'
#' Utilitario mecanico (ranking + criterios de desempate do enunciado) --
#' independente do modelo estatistico, por isso ja vem implementado. Usado
#' tanto para ver a classificacao atual (so jogos disputados) quanto, dentro
#' do loop de Monte Carlo, para calcular a classificacao final de cada
#' temporada simulada.

PONTOS_VITORIA <- 3
PONTOS_EMPATE <- 1
PONTOS_DERROTA <- 0
TIMES_REBAIXADOS <- 4

.COLUNAS_TABELA <- c(
  "pontos", "vitorias", "empates", "derrotas",
  "gols_marcados", "gols_sofridos", "saldo_gols", "jogos"
)

#' Calcula a tabela de classificacao a partir de uma tabela de jogos.
#'
#' @param jogos data.frame com `gols_mandante`/`gols_visitante` preenchidos
#'   (so jogos ja disputados, ou ja simulados). Colunas esperadas:
#'   `time_mandante`, `gols_mandante`, `time_visitante`, `gols_visitante`.
#' @return data.frame indexado por time (nomes de linha), ordenado da 1a a
#'   ultima colocacao (criterios: pontos -> vitorias -> saldo de gols ->
#'   gols marcados, do enunciado), com as colunas em `.COLUNAS_TABELA` mais
#'   `posicao` e `rebaixado`.
calcular_classificacao <- function(jogos) {
  times <- unique(c(jogos$time_mandante, jogos$time_visitante))

  tabela <- as.data.frame(matrix(
    0L, nrow = length(times), ncol = length(.COLUNAS_TABELA),
    dimnames = list(times, .COLUNAS_TABELA)
  ))

  # Implementacao simples via loop, por clareza. Como esta funcao roda uma
  # vez por temporada simulada (N vezes no laco de Monte Carlo), vale a pena
  # revisitar com uma versao vetorizada (dplyr::group_by/summarise) se N
  # grande deixar a simulacao lenta -- ver `.ai/padroes-codigo.md`.
  for (i in seq_len(nrow(jogos))) {
    jogo <- jogos[i, ]
    tabela <- .atualizar_time(tabela, jogo$time_mandante, jogo$gols_mandante, jogo$gols_visitante)
    tabela <- .atualizar_time(tabela, jogo$time_visitante, jogo$gols_visitante, jogo$gols_mandante)
  }

  tabela$saldo_gols <- tabela$gols_marcados - tabela$gols_sofridos

  ordem <- order(-tabela$pontos, -tabela$vitorias, -tabela$saldo_gols, -tabela$gols_marcados)
  tabela <- tabela[ordem, ]

  tabela$posicao <- seq_len(nrow(tabela))
  tabela$rebaixado <- tabela$posicao > (nrow(tabela) - TIMES_REBAIXADOS)

  tabela
}

.atualizar_time <- function(tabela, time, gols_pro, gols_contra) {
  tabela[time, "jogos"] <- tabela[time, "jogos"] + 1
  tabela[time, "gols_marcados"] <- tabela[time, "gols_marcados"] + gols_pro
  tabela[time, "gols_sofridos"] <- tabela[time, "gols_sofridos"] + gols_contra

  if (gols_pro > gols_contra) {
    tabela[time, "vitorias"] <- tabela[time, "vitorias"] + 1
    tabela[time, "pontos"] <- tabela[time, "pontos"] + PONTOS_VITORIA
  } else if (gols_pro == gols_contra) {
    tabela[time, "empates"] <- tabela[time, "empates"] + 1
    tabela[time, "pontos"] <- tabela[time, "pontos"] + PONTOS_EMPATE
  } else {
    tabela[time, "derrotas"] <- tabela[time, "derrotas"] + 1
    tabela[time, "pontos"] <- tabela[time, "pontos"] + PONTOS_DERROTA
  }

  tabela
}
