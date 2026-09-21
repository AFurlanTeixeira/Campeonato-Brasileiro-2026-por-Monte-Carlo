# Padrões de Código

## R

- Documentar toda função pública com roxygen2, incluindo os tipos esperados (`#' @param jogos data.frame`, `#' @return data.frame`).
- Comentários roxygen2 curtos explicando entrada, saída e a fórmula/regra aplicada — não só o "o quê", mas o "porquê" quando envolver uma escolha do modelo.
- `snake_case` para funções e variáveis, um arquivo `.R` por responsabilidade (ver `CLAUDE.md` → Módulos).
- Nada de efeitos colaterais em funções de estimativa/simulação: recebem dados, retornam data.frames novos (facilita testar e comparar modelos na atividade extra).

## Aleatoriedade e reprodutibilidade

- Sempre fixar a semente explicitamente com `set.seed(seed)` no início da simulação (ou isolar o efeito com `withr::with_seed(seed, ...)`) — nunca depender do estado global do RNG sem registrar o seed usado. Passar o `seed` explicitamente como parâmetro para toda função que amostra valores aleatórios.
- O `seed` usado em cada execução deve ficar registrado (log ou no próprio relatório), para os resultados serem reproduzíveis pelo grupo e pelo professor.

## Testes

- Testes unitários em `tests/testthat/`, espelhando os módulos de `R/` (arquivos `test-*.R`).
- Priorizar testes de `classificacao.R` (lógica determinística de desempate) com tabelas pequenas e resultado esperado calculado à mão.
- Para `estimativas.R`/`simulacao.R`, testar propriedades estatísticas (ex.: médias simuladas convergindo para o valor esperado com N grande) em vez de valores exatos — são funções estocásticas.

## O que evitar

- Números mágicos: constantes como pontos por vitória/empate, número de times rebaixados etc. devem ser nomeadas (`PONTOS_VITORIA <- 3`), não hardcoded no meio do código.
- Loops explícitos (`for`) onde uma operação vetorizada do R (`dplyr`/`vapply`/operadores vetoriais nativos) resolve — o enunciado pede eficiência ("menor número de operações repetidas possíveis").
