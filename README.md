# me524-lab1-brasileirao

Predição do Campeonato Brasileiro 2026 por métodos de Monte Carlo — Laboratório 1 de ME524 (Unicamp, 2026). A partir dos jogos já disputados, estima a força de ataque/defesa de cada time, simula os jogos pendentes segundo um modelo Poisson e usa as simulações para estimar probabilidades de título, rebaixamento e desempate.

## Objetivos / Perguntas a Responder

* Qual a probabilidade de cada time ser campeão, e de ser rebaixado?
* Qual a probabilidade do campeonato ser decidido pelos critérios de desempate?
* Qual o valor esperado de pontos do campeão?
* Quantos pontos garantem ≥90% de chance de título, ou ≥95% de chance de escapar do rebaixamento?
* Qual a variabilidade (via bootstrap) das estimativas de força de cada time?

Lista completa em [`docs/enunciado.md`](docs/enunciado.md).

## Arquitetura

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

## Dados

O dataset [`data/raw/brasileirao_2026.csv`](data/raw/brasileirao_2026.csv) tem os 380 jogos do campeonato (20 times, 38 rodadas). 278 jogos já disputados (rodadas 1–20 completas); 102 pendentes (a partir da rodada 21), com os gols em branco — são o que a simulação precisa preencher.

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
  brasileirao_mc/          # Pacote principal
    dados.R                # Carregamento e filtros do CSV (implementado)
    estimativas.R          # Estimação de θ/ϕ por time (TODO — núcleo avaliado)
    simulacao.R            # Simulação Poisson dos jogos pendentes (TODO — núcleo avaliado)
    classificacao.R        # Cálculo da tabela de classificação (implementado)
    bootstrap.R            # IC via bootstrap para θ/ϕ (TODO — núcleo avaliado)
tests/
  testthat/                # Testes unitários (testthat)
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
