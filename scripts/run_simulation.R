#!/usr/bin/env Rscript
# CLI para rodar a simulacao Monte Carlo completa da temporada.
#
# Exemplo:
#   Rscript scripts/run_simulation.R --n-simulacoes 10000 --seed 42
#
# Defaults vem de variaveis de ambiente (ver `.env.example`) quando nao
# passados via flag.

suppressPackageStartupMessages(library(optparse))

for (arquivo in list.files("R", pattern = "\\.R$", full.names = TRUE)) {
  source(arquivo)
}

default_data_path <- Sys.getenv("DATA_PATH", "data/raw/brasileirao_2026.csv")
default_n_simulacoes <- as.integer(Sys.getenv("N_SIMULACOES", 10000))
default_seed <- as.integer(Sys.getenv("RANDOM_SEED", 42))

option_list <- list(
  make_option("--data-path", default = default_data_path, help = "Caminho do CSV de jogos."),
  make_option("--n-simulacoes", default = default_n_simulacoes, help = "Numero de simulacoes."),
  make_option("--seed", default = default_seed, help = "Seed do gerador de numeros aleatorios.")
)

parser <- OptionParser(
  description = "Simulacao Monte Carlo do Campeonato Brasileiro 2026",
  option_list = option_list
)
args <- parse_args(parser)

jogos <- carregar_jogos(args$data_path)
disputados <- jogos_disputados(jogos)
pendentes <- jogos_pendentes(jogos)

cat(sprintf("Jogos disputados: %d | pendentes: %d\n", nrow(disputados), nrow(pendentes)))

parametros <- estimar_parametros(disputados)

resultados <- vector("list", args$n_simulacoes)
for (i in seq_len(args$n_simulacoes)) {
  temporada_simulada <- simular_temporada(pendentes, parametros, args$seed)
  completa <- NULL # TODO(grupo): concatenar `disputados` + `temporada_simulada`
  resultados[[i]] <- calcular_classificacao(completa)
}

# TODO(grupo): agregar `resultados` (lista de tabelas, uma por simulacao)
# para responder as perguntas em `docs/respostas.md` -- ex.: proporcao de
# simulacoes em que cada time termina na posicao 1 (probabilidade de
# titulo), ultimas 4 posicoes (probabilidade de rebaixamento), etc.
