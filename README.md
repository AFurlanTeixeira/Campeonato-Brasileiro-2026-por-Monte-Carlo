# 🏆 Predição do Campeonato Brasileiro 2026 por Monte Carlo

### 📌 Sobre o Projeto

Laboratório 1 da disciplina **ME524 - Computação Aplicada à Estatística** (Unicamp, 2026). O objetivo é usar métodos de **Monte Carlo** para simular os jogos ainda não realizados do Campeonato Brasileiro 2026 e estimar probabilidades de eventos como título, rebaixamento e desempate.

- **Disciplina:** ME524
- **Entrega:** relatório em grupo (3 a 4 integrantes), com código e texto explicativo

---

### 📄 Arquivos e Modelos

#### 1. Dados
- `brasileirao_2026.csv`:
    - Base com todos os 380 jogos do campeonato (20 times, 38 rodadas).
    - Colunas: `rodada`, `time_mandante`, `gols_mandante`, `time_visitante`, `gols_visitante`.
    - Jogos ainda não realizados ficam com os gols em branco — são o que precisa ser simulado.

#### 2. Enunciado
- `lab1.pdf`:
    - Descrição completa do modelo, roteiro sugerido e perguntas a responder.

---

### 🧮 Modelo Proposto

Para um jogo entre mandante `m` e visitante `v`, o número de gols de cada time é modelado como Poisson:

```
X_m ~ Poisson((θ_m + ϕ_v) / 2)
X_v ~ Poisson((θ_v + ϕ_m) / 2)
```

- `θ` (theta): taxa de gols **marcados** pelo time — média de gols marcados por jogo, considerando os jogos já disputados.
- `ϕ` (phi): taxa de gols **sofridos** pelo time — média de gols sofridos por jogo, considerando os jogos já disputados.

Critérios de desempate na classificação (nesta ordem): número de vitórias → saldo de gols → gols marcados.

---

### 🔍 Profiling do Dataset

- **Total de jogos:** 380 (20 times × 38 rodadas).
- **Jogos disputados:** 277, cobrindo integralmente da rodada 1 até a rodada 28.
- **Jogos pendentes (a simular):** 103, com a primeira ocorrência na rodada 21 (pendências intercaladas até a rodada 38).
- **Gols marcados nos jogos disputados:** 739.
- **Valores nulos:** apenas em `gols_mandante`/`gols_visitante` dos jogos ainda não realizados.

---

### 🎯 Perguntas a Responder

1. Qual a probabilidade de cada time ser campeão?
2. Qual a probabilidade de cada time ser rebaixado?
3. Qual a probabilidade do campeonato ser decidido pelos critérios de desempate?
4. Qual o valor esperado do número de pontos do campeão?
5. Quantos pontos uma equipe precisa fazer para ter pelo menos 90% de chance de ser campeã?
6. Quantos pontos são necessários para uma equipe ter pelo menos 95% de chance de não ser rebaixada?

Além disso, o laboratório pede:
- Intervalos de confiança via **bootstrap** para as estimativas de θ e ϕ de cada time.
- Uma **atividade extra**: propor e justificar uma melhoria no modelo (ex.: vantagem de mandante, θ/ϕ variando ao longo do campeonato), comparando os resultados com o modelo original.

---

### 🧪 Roteiro de Execução

1. Estimar θ e ϕ para cada time a partir dos jogos já disputados.
2. Criar uma função que calcule a classificação completa do campeonato (pontos, vitórias, saldo de gols) a partir de uma tabela de resultados.
3. Simular os jogos pendentes (rodadas 21–38) segundo o modelo Poisson proposto.
4. Repetir a simulação N vezes (Monte Carlo) e registrar as métricas necessárias para responder às perguntas.
5. Calcular intervalos de confiança via bootstrap para θ e ϕ.
6. Implementar e comparar a melhoria proposta na atividade extra.

---

### ✅ Checklist de Entregas

[ ] Estimação de θ e ϕ por time
[ ] Função de cálculo da classificação (com critérios de desempate)
[ ] Simulação Monte Carlo dos jogos pendentes
[ ] Respostas às 6 perguntas do enunciado
[ ] Intervalos de confiança via bootstrap + gráfico
[ ] Atividade extra (melhoria do modelo, justificada e comparada)
[ ] Relatório final com código e texto explicativo
