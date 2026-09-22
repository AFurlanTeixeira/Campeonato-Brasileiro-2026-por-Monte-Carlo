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

parser <- OptionParser(description = "Simulacao Monte Carlo do Campeonato Brasileiro 2026")
parser <- add_option(parser, "--data-path", type = "character",
  default = Sys.getenv("DATA_PATH", "data/raw/brasileirao_2026.csv"),
  help = "Caminho do CSV de jogos.")
parser <- add_option(parser, "--n-simulacoes", type = "integer",
  default = as.integer(Sys.getenv("N_SIMULACOES", 10000)),
  help = "Numero de repeticoes da simulacao Monte Carlo.")
parser <- add_option(parser, "--seed", type = "integer",
  default = as.integer(Sys.getenv("RANDOM_SEED", 42)),
  help = "Seed do gerador de numeros aleatorios.")

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
