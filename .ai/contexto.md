# Contexto do Projeto

## Visão Geral

Laboratório 1 de ME524 — predição do Campeonato Brasileiro 2026 por Monte
Carlo. Ver `docs/enunciado.md` para o enunciado completo e `README.md` para
como rodar o projeto.

## Stack

- R 4.5.0
- `dplyr` / `tidyr` para manipulação de dados e amostragem aleatória
- `stats` (opcional, para distribuições/testes estatísticos auxiliares)
- `ggplot2` para os gráficos de intervalo de confiança
- `testthat` + `covr` para testes

## Fluxo Principal

```
CSV (jogos) → estimar θ/ϕ por time → simular jogos pendentes (Poisson, N vezes)
  → calcular classificação de cada simulação → agregar probabilidades
  → bootstrap para IC de θ/ϕ
```

## Índice de Documentos

| Arquivo | Conteúdo |
|---|---|
| [.ai/padroes-codigo.md](padroes-codigo.md) | Padrões de código R e de testes |
| [.ai/modelagem.md](modelagem.md) | Decisões do modelo estatístico dadas pelo enunciado |
| [docs/enunciado.md](../docs/enunciado.md) | Resumo do enunciado e das perguntas a responder |
| [docs/respostas.md](../docs/respostas.md) | Esqueleto para registrar as respostas do grupo |
