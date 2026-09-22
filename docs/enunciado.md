# Enunciado — Resumo

Documento completo em [`lab1.pdf`](lab1.pdf).
Este arquivo é só um resumo de referência rápida.

## Contexto

Campeonato Brasileiro 2026, 20 times, 38 rodadas, 380 jogos. Critérios de
classificação: pontos → vitórias → saldo de gols → gols marcados. Rebaixamento
para os 4 últimos colocados.

## Dataset

`data/raw/brasileirao_2026.csv` — colunas `rodada`, `time_mandante`,
`gols_mandante`, `time_visitante`, `gols_visitante`. Jogos ainda não
realizados têm os gols em branco (ver profiling no `README.md`).

## Perguntas a Responder

1. Qual a probabilidade de cada time ser campeão?
2. Qual a probabilidade de cada time ser rebaixado?
3. Qual a probabilidade do campeonato ser decidido pelos critérios de desempate?
4. Qual o valor esperado do número de pontos do campeão?
5. Quantos pontos uma equipe precisa fazer para ter pelo menos 90% de chance de ser campeã?
6. Quantos pontos são necessários para uma equipe ter pelo menos 95% de chance de não ser rebaixada?

Mais: intervalos de confiança via bootstrap para θ/ϕ de cada time (com
gráfico), e uma atividade extra propondo e justificando uma melhoria no
modelo, comparada com o modelo original.

## Entrega

Relatório em grupo (3–4 alunos), com código e texto explicativo. Ver
[`respostas.md`](respostas.md) para o esqueleto de registro das respostas.
