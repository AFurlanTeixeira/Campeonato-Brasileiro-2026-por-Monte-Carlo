# 🏆 Predição do Campeonato Brasileiro 2026 por Monte Carlo
 
### 📌 Sobre o Projeto
 
Laboratório 1 da disciplina **ME524 - Computação Aplicada à Estatística** (Unicamp, 2026). O objetivo é usar métodos de **Monte Carlo** para simular os jogos ainda não realizados do Campeonato Brasileiro 2026 e estimar probabilidades de eventos como título, rebaixamento e desempate.
 
- **Disciplina:** ME524
- **Entrega:** relatório em grupo (3 a 4 integrantes), com código e texto explicativo

---

### 📄 Dados
- `brasileirao_2026.csv`:
    - Base com todos os 380 jogos do campeonato (20 times, 38 rodadas).
    - Colunas: `rodada`, `time_mandante`, `gols_mandante`, `time_visitante`, `gols_visitante`.
    - Jogos ainda não realizados ficam com os gols em branco — são o que precisa ser simulado.

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

## 🔍 Profiling do Dataset

O dataset [`data/raw/brasileirao_2026.csv`](data/raw/brasileirao_2026.csv) 
- **Total de jogos:** 380 (20 times × 38 rodadas).
- **Jogos disputados:** 278, cobrindo integralmente da rodada 1 até a rodada 20.
- **Jogos pendentes (a simular):** 102, com a primeira ocorrência na rodada 21 (pendências intercaladas até a rodada 38).
- **Gols marcados nos jogos disputados:** 742.
- **Valores nulos:** apenas em `gols_mandante`/`gols_visitante` dos jogos ainda não realizados.

---


## 🧮 Modelo Proposto e Arquitetura

```
data/raw/brasileirao_2026.csv
        │
        ▼
 estimar θ/ϕ por time (jogos disputados)
        │
        ▼
 simular jogos pendentes (Poisson) ──── repetir N vezes (Monte Carlo)
        │
        ▼
 calcular classificação de cada simulação
        │
        ▼
 agregar → probabilidades por time + bootstrap (IC de θ/ϕ)
```

Detalhes das decisões do modelo em [`.ai/modelagem.md`](.ai/modelagem.md).

---

## Configuração do Projeto

### Pré-requisitos

| Ferramenta | Versão mínima |
|-----------|--------------|
| R | 4.5.0 |

### Instalação

```r
install.packages("renv")
renv::restore()                   # instala as dependências travadas em renv.lock
```

### Variáveis de Ambiente (opcional)

```bash
cp .env.example .env
# Edite .env se quiser fixar N_SIMULACOES / RANDOM_SEED / DATA_PATH
```

Consulte [`.env.example`](.env.example) para a lista completa.

---

## Rodando localmente

```bash
Rscript scripts/run_simulation.R --n-simulacoes 10000 --seed 42
```

### Testes

```r
testthat::test_dir("tests/testthat")   # ou: devtools::test()
```

---

## Estrutura de Pastas

```
data/
  raw/                     # Dataset original do enunciado (versionado, não editar)
  processed/               # Artefatos gerados pela simulação (fora do git)
docs/
  enunciado.md             # Resumo do enunciado e das perguntas
  respostas.md             # Esqueleto para registrar as respostas do grupo
  lab1.pdf                 # Enunciado completo (adicionar aqui)
scripts/
  run_simulation.R         # CLI que roda a simulação Monte Carlo completa
R/
  dados.R                  # Carregamento e filtros do CSV (implementado)
  estimativas.R            # Estimação de θ/ϕ por time (TODO — núcleo avaliado)
  simulacao.R              # Simulação Poisson dos jogos pendentes (TODO — núcleo avaliado)
  classificacao.R          # Cálculo da tabela de classificação (implementado)
  bootstrap.R              # IC via bootstrap para θ/ϕ (TODO — núcleo avaliado)
tests/
  testthat/                # Testes unitários (testthat)
DESCRIPTION                # Metadados do projeto e dependências (renv/testthat)
```

## Contexto para IAs

A pasta `.ai/` contém os arquivos de contexto e diretrizes do projeto para uso com ferramentas de IA (Claude Code, Cursor, Copilot, etc.):

| Arquivo | Descrição |
|---------|-----------|
| [.ai/contexto.md](.ai/contexto.md) | Visão geral: stack, fluxo principal e índice dos demais arquivos |
| [.ai/padroes-codigo.md](.ai/padroes-codigo.md) | Padrões R e de testes usados no projeto |
| [.ai/modelagem.md](.ai/modelagem.md) | Decisões do modelo estatístico dadas pelo enunciado |

## Documentação

| Arquivo | Descrição |
|---------|-----------|
| [docs/enunciado.md](docs/enunciado.md) | Resumo do enunciado e das perguntas a responder |
| [docs/respostas.md](docs/respostas.md) | Esqueleto para o relatório final do grupo |

---

### 🧪 Roteiro de Execução
 
1. Estimar θ e ϕ para cada time a partir dos jogos já disputados.
2. Criar uma função que calcule a classificação completa do campeonato (pontos, vitórias, saldo de gols) a partir de uma tabela de resultados.
3. Simular os jogos pendentes (rodadas 29–38) segundo o modelo Poisson proposto.
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
 

