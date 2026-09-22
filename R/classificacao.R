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

#' Calcula a tabela de classificacao a partir de uma tabela de jogos.
#'
#' Vetorizada: cada jogo contribui uma linha para o mandante e uma para o
#' visitante (mesma ideia de `estimar_parametros()`), e as colunas sao
#' agregadas por time com `tapply()` em vez de um loop jogo a jogo -- a
#' versao anterior, com loop, levava ~12min para N=10000 temporadas
#' simuladas; ver `.ai/padroes-codigo.md`.
#'
#' @param jogos data.frame com `gols_mandante`/`gols_visitante` preenchidos
#'   (so jogos ja disputados, ou ja simulados). Colunas esperadas:
#'   `time_mandante`, `gols_mandante`, `time_visitante`, `gols_visitante`.
#' @return data.frame indexado por time (nomes de linha), ordenado da 1a a
#'   ultima colocacao (criterios: pontos -> vitorias -> saldo de gols ->
#'   gols marcados, do enunciado), com colunas `pontos`, `vitorias`,
#'   `empates`, `derrotas`, `gols_marcados`, `gols_sofridos`, `saldo_gols`,
#'   `jogos`, `posicao` e `rebaixado`.
calcular_classificacao <- function(jogos) {
  times <- sort(unique(c(jogos$time_mandante, jogos$time_visitante)))

  marcados <- c(jogos$gols_mandante, jogos$gols_visitante)
  sofridos <- c(jogos$gols_visitante, jogos$gols_mandante)
  time_emp <- c(jogos$time_mandante, jogos$time_visitante)

  vitoria <- marcados > sofridos
  empate <- marcados == sofridos
  derrota <- !(vitoria | empate)
  pontos_jogo <- PONTOS_VITORIA * vitoria + PONTOS_EMPATE * empate + PONTOS_DERROTA * derrota

  agregar <- function(x) as.numeric(tapply(x, time_emp, sum)[times])

  tabela <- data.frame(
    pontos = agregar(pontos_jogo),
    vitorias = agregar(vitoria),
    empates = agregar(empate),
    derrotas = agregar(derrota),
    gols_marcados = agregar(marcados),
    gols_sofridos = agregar(sofridos),
    jogos = agregar(rep(1, length(marcados))),
    row.names = times
  )
  tabela$saldo_gols <- tabela$gols_marcados - tabela$gols_sofridos

  ordem <- order(-tabela$pontos, -tabela$vitorias, -tabela$saldo_gols, -tabela$gols_marcados)
  tabela <- tabela[ordem, ]

  tabela$posicao <- seq_len(nrow(tabela))
  tabela$rebaixado <- tabela$posicao > (nrow(tabela) - TIMES_REBAIXADOS)

  tabela
}
