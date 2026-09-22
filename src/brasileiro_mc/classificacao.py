"""Cálculo da tabela de classificação a partir de uma tabela de resultados.

Utilitário mecânico (ranking + critérios de desempate do enunciado) —
independente do modelo estatístico, por isso já vem implementado. Usado tanto
para ver a classificação atual (só jogos disputados) quanto, dentro do loop
de Monte Carlo, para calcular a classificação final de cada temporada
simulada.
"""

from __future__ import annotations

import pandas as pd

PONTOS_VITORIA = 3
PONTOS_EMPATE = 1
PONTOS_DERROTA = 0
TIMES_REBAIXADOS = 4

_COLUNAS_TABELA = [
    "pontos",
    "vitorias",
    "empates",
    "derrotas",
    "gols_marcados",
    "gols_sofridos",
    "saldo_gols",
    "jogos",
]


def calcular_classificacao(jogos: pd.DataFrame) -> pd.DataFrame:
    """Calcula a tabela de classificação a partir de uma tabela de jogos.

    Args:
        jogos: jogos com `gols_mandante`/`gols_visitante` preenchidos (só
            jogos já disputados, ou já simulados). Colunas esperadas:
            `time_mandante`, `gols_mandante`, `time_visitante`, `gols_visitante`.

    Returns:
        DataFrame indexado por time, ordenado da 1ª à última colocação
        (critérios: pontos → vitórias → saldo de gols → gols marcados, do
        enunciado), com as colunas em `_COLUNAS_TABELA` mais `posicao` e
        `rebaixado`.
    """
    times = pd.unique(jogos[["time_mandante", "time_visitante"]].values.ravel())
    tabela = pd.DataFrame(0, index=times, columns=_COLUNAS_TABELA)

    # Implementação simples via loop, por clareza. Como esta função roda uma
    # vez por temporada simulada (N vezes no laço de Monte Carlo), vale a
    # pena revisitar com uma versão vetorizada (groupby/agg) se N grande
    # deixar a simulação lenta — ver `.ai/padroes-codigo.md`.
    for jogo in jogos.itertuples(index=False):
        _atualizar_time(tabela, jogo.time_mandante, jogo.gols_mandante, jogo.gols_visitante)
        _atualizar_time(tabela, jogo.time_visitante, jogo.gols_visitante, jogo.gols_mandante)

    tabela["saldo_gols"] = tabela["gols_marcados"] - tabela["gols_sofridos"]

    tabela = tabela.sort_values(
        by=["pontos", "vitorias", "saldo_gols", "gols_marcados"],
        ascending=False,
    )
    tabela["posicao"] = range(1, len(tabela) + 1)
    tabela["rebaixado"] = tabela["posicao"] > (len(tabela) - TIMES_REBAIXADOS)

    return tabela


def _atualizar_time(tabela: pd.DataFrame, time: str, gols_pro: int, gols_contra: int) -> None:
    tabela.loc[time, "jogos"] += 1
    tabela.loc[time, "gols_marcados"] += gols_pro
    tabela.loc[time, "gols_sofridos"] += gols_contra

    if gols_pro > gols_contra:
        tabela.loc[time, "vitorias"] += 1
        tabela.loc[time, "pontos"] += PONTOS_VITORIA
    elif gols_pro == gols_contra:
        tabela.loc[time, "empates"] += 1
        tabela.loc[time, "pontos"] += PONTOS_EMPATE
    else:
        tabela.loc[time, "derrotas"] += 1
        tabela.loc[time, "pontos"] += PONTOS_DERROTA
