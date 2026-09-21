# Decisões de Modelagem

Este documento registra as decisões do modelo estatístico **dadas pelo
enunciado** (`docs/enunciado.md` / `lab1.pdf`), no formato de ADR, para
servirem de referência rápida ao implementar `estimativas.py` e
`simulacao.py`. Não inclui a atividade extra — a melhoria do modelo é uma
decisão do grupo, registrada como ADR em aberto ao final.

## ADR-001: Modelo de gols por Poisson

Para um jogo entre mandante `m` e visitante `v`:

```
X_m ~ Poisson((θ_m + ϕ_v) / 2)
X_v ~ Poisson((θ_v + ϕ_m) / 2)
```

Cada time tem uma taxa de gols marcados (θ) e uma de gols sofridos (ϕ). O
gol esperado de um time num jogo é a média entre sua própria força de ataque
e a fraqueza defensiva do adversário.

## ADR-002: Estimador de θ e ϕ

`θ_time` = média de gols marcados por jogo do time, considerando os jogos já
disputados. `ϕ_time` = média de gols sofridos por jogo, mesma base. Estimador
simples (média amostral), conforme especificado no enunciado — não é um MLE
ajustado nem considera mandante/visitante separadamente na estimativa (só no
uso do parâmetro na simulação).

## ADR-003: Variabilidade via bootstrap

Para intervalos de confiança de θ e ϕ por time: reamostragem com reposição
dos jogos de cada time, recalculando θ/ϕ em cada amostra bootstrap. Não é
bootstrap sobre os parâmetros do modelo como um todo, é por time
individualmente.

## ADR-004: Melhoria do modelo (atividade extra) — em aberto

A ser decidido pelo grupo. Candidatos sugeridos pelo enunciado: fator de
vantagem de mandante, ou θ/ϕ variando ao longo do campeonato. Registrar aqui
a decisão do grupo e a justificativa quando definida, antes de implementar em
`simulacao.py`.
