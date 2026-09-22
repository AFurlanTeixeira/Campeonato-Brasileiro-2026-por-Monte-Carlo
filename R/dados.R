#' Carregamento dos dados brutos do campeonato.
#'
#' Sem transformacao de negocio aqui -- so leitura e validacao estrutural do
#' CSV. As colunas de gols dos jogos ainda nao realizados ficam como `NA`
#' (`read.csv` ja faz essa conversao automaticamente ao ler campos vazios).

COLUNAS_ESPERADAS <- c(
  "rodada", "time_mandante", "gols_mandante", "time_visitante", "gols_visitante"
)

#' Le o CSV de jogos do campeonato.
#'
#' @param caminho caminho para o `brasileirao_2026.csv` (ex.: `data/raw/...`).
#' @return data.frame com uma linha por jogo. Jogos ainda nao realizados tem
#'   `gols_mandante`/`gols_visitante` como `NA`.
carregar_jogos <- function(caminho) {
  jogos <- read.csv(caminho, stringsAsFactors = FALSE)

  faltando <- setdiff(COLUNAS_ESPERADAS, names(jogos))
  if (length(faltando) > 0) {
    stop(sprintf("Colunas faltando no CSV: %s", paste(sort(faltando), collapse = ", ")))
  }

  jogos
}

#' Filtra apenas os jogos que ja tem resultado (gols preenchidos).
#'
#' @param jogos data.frame de jogos (ver `carregar_jogos()`).
#' @return subconjunto de `jogos` sem `NA` em `gols_mandante`/`gols_visitante`.
jogos_disputados <- function(jogos) {
  jogos[!is.na(jogos$gols_mandante) & !is.na(jogos$gols_visitante), ]
}

#' Filtra os jogos ainda nao realizados (gols em branco) -- o que precisa
#' ser simulado.
#'
#' @param jogos data.frame de jogos (ver `carregar_jogos()`).
#' @return subconjunto de `jogos` com `gols_mandante` igual a `NA`.
jogos_pendentes <- function(jogos) {
  jogos[is.na(jogos$gols_mandante), ]
}
