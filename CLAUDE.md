# CLAUDE.md

Este arquivo orienta o Claude Code (claude.ai/code) ao trabalhar neste repositório.

## Overview

Laboratório 1 de ME524 (Unicamp, 2026): predição do Campeonato Brasileiro 2026
por métodos de Monte Carlo. A partir dos jogos já disputados em
`data/raw/brasileirao_2026.csv`, o projeto estima uma taxa de gols marcados
(θ) e sofridos (ϕ) por time, simula os jogos ainda não realizados segundo um
modelo Poisson, e usa as simulações para estimar probabilidades (título,
rebaixamento, desempate) e intervalos de confiança via bootstrap.

Este é um projeto de análise, não um serviço — não há endpoint, banco de
dados ou deploy. A "entrega" é um relatório (código + texto) respondendo às
perguntas do enunciado.

Docs mais profundos:
- `.ai/contexto.md` — visão geral do fluxo e índice dos demais arquivos
- `.ai/padroes-codigo.md` — padrões R e de testes usados no projeto
- `.ai/modelagem.md` — decisões do modelo estatístico dadas pelo enunciado (não a "atividade extra" — essa fica em aberto para o grupo decidir)
- `docs/enunciado.md` — resumo do enunciado e das perguntas a responder

## Commands

```bash
Rscript -e 'install.packages("renv"); renv::restore()'

Rscript -e 'testthat::test_dir("tests/testthat")'   # testes unitários (ver DESCRIPTION)
Rscript scripts/run_simulation.R                    # roda a simulação Monte Carlo completa
```

Rodar um único arquivo de teste:
```bash
Rscript -e 'testthat::test_file("tests/testthat/test-classificacao.R")'
```

## Architecture

### Fluxo

```
data/raw/brasileirao_2026.csv
  → R/dados.R            (carrega e valida os jogos)
  → R/estimativas.R      (estima θ/ϕ por time, jogos já disputados)
  → R/simulacao.R        (simula os jogos pendentes via Poisson, N vezes)
  → R/classificacao.R    (calcula a tabela final de cada simulação)
  → agrega resultados das N simulações → probabilidades por time
  → R/bootstrap.R        (IC para θ/ϕ via reamostragem com reposição)
```

### Módulos

1. **`dados.R`**: leitura do CSV, sem transformação de negócio — só tipagem e
   validação básica (colunas esperadas, tipos).
2. **`estimativas.R`**: estimadores de θ e ϕ por time a partir dos jogos já
   disputados (média de gols marcados / sofridos por jogo).
3. **`simulacao.R`**: simulação de um jogo (Poisson) e de uma temporada
   inteira (todos os jogos pendentes, repetido N vezes).
4. **`classificacao.R`**: cálculo da tabela de classificação a partir de uma
   tabela de resultados, aplicando os critérios de desempate do enunciado
   (vitórias → saldo de gols → gols marcados). Já implementado — é utilitário
   puro de ranking, independente do modelo estatístico.
5. **`bootstrap.R`**: intervalos de confiança para θ/ϕ via bootstrap.

### O que está implementado vs. pendente

`dados.R` e `classificacao.R` têm implementação completa (são utilitários
mecânicos, não a parte avaliada do laboratório). `estimativas.R`,
`simulacao.R` e `bootstrap.R` estão como esqueleto (assinatura + roxygen2
+ `TODO`) — são o núcleo estatístico que o grupo precisa implementar e que é
avaliado no laboratório.

---

## Design Decisions

Ver `.ai/modelagem.md`: modelo de gols por Poisson com parâmetros θ/ϕ,
estimador de média simples, e avaliação de variabilidade via bootstrap — como
especificado no enunciado (`docs/enunciado.md` / `lab1.pdf`). A escolha da
melhoria para a atividade extra é decisão do grupo e não está pré-definida
aqui.
