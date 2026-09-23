# Respostas — Laboratório 1

> Resultados de N = 10.000 réplicas (seed 524) da simulação Monte Carlo.
> Código completo e reprodutível em [`relatorio.Rmd`](relatorio.Rmd)
> (renderiza para `relatorio.html`, com os gráficos); aqui ficam só os
> números e a interpretação. Ver as perguntas completas em
> [`enunciado.md`](enunciado.md).

## 1. Probabilidade de cada time ser campeão

A disputa pelo título está concentrada em Flamengo e Palmeiras, que já
lideram a tabela atual com folga — juntos somam quase 98% de chance.

| Time | P(campeão) | Erro MC |
|---|---:|---:|
| Flamengo | 54,6% | ±0,5 p.p. |
| Palmeiras | 43,4% | ±0,5 p.p. |
| Athletico-PR | 1,3% | ±0,1 p.p. |
| Fluminense | 0,6% | ±0,1 p.p. |
| Bahia | 0,1% | ±0,03 p.p. |
| Cruzeiro | 0,02% | ±0,01 p.p. |
| Demais 14 times | 0% nas 10.000 réplicas | — |

## 2. Probabilidade de cada time ser rebaixado

| Time | P(rebaixamento) | Erro MC |
|---|---:|---:|
| Chapecoense | 99,7% | ±0,06 p.p. |
| Remo | 95,5% | ±0,2 p.p. |
| Internacional | 58,5% | ±0,5 p.p. |
| Vitória | 49,8% | ±0,5 p.p. |
| Mirassol | 37,4% | ±0,5 p.p. |
| Grêmio | 24,7% | ±0,4 p.p. |
| Vasco | 20,7% | ±0,4 p.p. |
| Botafogo | 5,1% | ±0,2 p.p. |
| Corinthians | 4,6% | ±0,2 p.p. |
| Coritiba | 2,0% | ±0,1 p.p. |
| São Paulo | 1,2% | ±0,1 p.p. |
| Santos | 0,6% | ±0,1 p.p. |
| Bragantino | 0,2% | ±0,04 p.p. |
| Atlético-MG | 0,06% | ±0,02 p.p. |
| Athletico-PR, Bahia, Cruzeiro, Flamengo, Fluminense, Palmeiras | 0% | — |

A disputa pelo Z4 é a mais indefinida do campeonato: Internacional, Vitória,
Mirassol, Grêmio e Vasco têm entre 21% e 59% de chance de cair — nenhum
deles está "salvo" nem "condenado".

## 3. Probabilidade de decisão por critério de desempate

O enunciado admite duas leituras do que conta como "decidido pelo
desempate". **Decisão do grupo: adotamos a opção (a)** — o desempate que
decide o título — como resposta oficial.

- **(a) Empate no título** (1º e 2º lugares terminam com os mesmos
  pontos) — **resposta oficial**: **6,8%** das réplicas (erro MC
  ±0,25 p.p.).
- (b) Empate na última vaga de rebaixamento (16º e 17º lugares com os
  mesmos pontos) — mantido como referência, não é a resposta adotada:
  20,0% das réplicas (erro MC ±0,4 p.p.).

## 4. Valor esperado de pontos do campeão

- **Média: 76,5 pontos** (erro MC ±0,03).
- Intervalo de predição 95% entre réplicas: **[70, 83] pontos** — descreve
  a variabilidade dos pontos do campeão de uma réplica para outra, não a
  incerteza sobre a média (que é o erro MC acima).

## 5. Pontos para ≥90% de chance de ser campeão

Igual à pergunta 3, o enunciado admite duas leituras — e elas divergem
nas mesmas réplicas, não é ruído de simulação:

- **Leitura A** (menor pontuação que garante ≥90% empiricamente, olhando
  todos os times em todas as posições): **79 pontos**.
- **Leitura B** (percentil 90 da pontuação do vice-campeão): **76 pontos**.

_Decisão do grupo: escolher qual é a resposta oficial da pergunta 5, ou
reportar as duas com essa ressalva (como na pergunta 3)._

## 6. Pontos para ≥95% de chance de não ser rebaixado

Mesma ambiguidade da pergunta 5:

- **Leitura A** (menor pontuação que garante ≥95% empiricamente): **45
  pontos**.
- **Leitura B** (percentil 95 da pontuação do 17º colocado): **44 pontos**.

_Decisão do grupo: escolher qual é a resposta oficial da pergunta 6, ou
reportar as duas com essa ressalva._

## Classificação esperada (consolidado das 10.000 réplicas)

Pontos médios, posição média e as probabilidades das perguntas 1 e 2 lado a
lado, ordenado pela posição média:

| Pos. | Time | Pontos médios | Posição média | P(título) | P(rebaixamento) |
|---:|---|---:|---:|---:|---:|
| 1 | Flamengo | 74,2 | 1,5 | 54,6% | 0,0% |
| 2 | Palmeiras | 73,8 | 1,7 | 43,4% | 0,0% |
| 3 | Athletico-PR | 64,2 | 3,9 | 1,3% | 0,0% |
| 4 | Fluminense | 63,1 | 4,4 | 0,6% | 0,0% |
| 5 | Bahia | 60,3 | 5,6 | 0,1% | 0,0% |
| 6 | Cruzeiro | 59,0 | 6,0 | 0,0% | 0,0% |
| 7 | Atlético-MG | 55,3 | 8,0 | 0,0% | 0,1% |
| 8 | Bragantino | 53,4 | 8,8 | 0,0% | 0,2% |
| 9 | Santos | 52,6 | 9,6 | 0,0% | 0,6% |
| 10 | São Paulo | 51,6 | 10,0 | 0,0% | 1,2% |
| 11 | Coritiba | 50,4 | 11,2 | 0,0% | 2,0% |
| 12 | Corinthians | 49,0 | 11,9 | 0,0% | 4,6% |
| 13 | Botafogo | 48,8 | 12,0 | 0,0% | 5,1% |
| 14 | Vasco | 45,3 | 14,2 | 0,0% | 20,7% |
| 15 | Grêmio | 44,7 | 14,6 | 0,0% | 24,7% |
| 16 | Mirassol | 43,3 | 15,5 | 0,0% | 37,4% |
| 17 | Vitória | 41,9 | 16,1 | 0,0% | 49,8% |
| 18 | Internacional | 41,3 | 16,5 | 0,0% | 58,5% |
| 19 | Remo | 34,9 | 18,7 | 0,0% | 95,5% |
| 20 | Chapecoense | 29,7 | 19,8 | 0,0% | 99,7% |

## Variabilidade das estimativas (bootstrap)

- B = 1.000 reamostragens por time (jogos com reposição), IC por percentis
  95%. Gráfico completo (θ e ϕ, todos os times) em `relatorio.html`.
- **IC mais largos** (estimativa menos precisa): Palmeiras
  (θ ∈ [1,21; 2,14]), Atlético-MG (θ ∈ [0,89; 1,81]), Botafogo
  (θ ∈ [1,04; 1,93]).
- **IC mais estreitos** (estimativa mais precisa): Mirassol
  (θ ∈ [0,90; 1,45]), Santos (θ ∈ [1,19; 1,81]), Bahia (θ ∈ [1,21; 1,86]).
- Essa incerteza **não propaga** para as perguntas 1 e 2 — na simulação
  Monte Carlo, θ/ϕ entram como constantes fixas, então `P(título)` e
  `P(rebaixamento)` carregam só erro Monte Carlo, não erro de estimação.

## Atividade extra

**Melhoria proposta:** _(decisão do grupo — ver ADR-004 em
[`.ai/modelagem.md`](../.ai/modelagem.md); proposta de baixo custo já
esboçada em `relatorio.Rmd`)_

A limitação mais evidente do modelo atual é a ausência de vantagem de
mandante. Nos jogos já disputados:

| | Mandante | Visitante |
|---|---:|---:|
| Gols por jogo (média) | 1,51 | 1,15 |
| % de vitórias | 46,4% | 25,9% |

(27,7% de empates.) O mandante marca mais e vence bem mais — mas θ/ϕ
combinam gols em casa e fora, então o modelo trata os dois lados como
equivalentes. Uma proposta de baixo custo (discutida em `relatorio.Rmd`) é
um fator multiplicativo único aplicado aos λ de mandante/visitante, sem
alterar o resto do pipeline:

```
h = √(gols mandante médio / gols visitante médio) = √(1,51 / 1,15) ≈ 1,145
```

Com esse `h`, os λ da simulação passariam de `(theta_mandante +
phi_visitante) / 2` e `(theta_visitante + phi_mandante) / 2` para
`lambda_mandante * h` e `lambda_visitante / h` — a mudança fica isolada em
`R/simulacao.R`, sem afetar `estimativas.R`, `classificacao.R` ou
`bootstrap.R`.

**Comparação com o modelo original:** _(resultados lado a lado, depois que
o grupo decidir e implementar a melhoria)_
