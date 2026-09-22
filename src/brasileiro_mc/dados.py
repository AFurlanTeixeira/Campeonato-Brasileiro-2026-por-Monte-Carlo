"""Carregamento dos dados brutos do campeonato.

Sem transformação de negócio aqui — só leitura e validação estrutural do
CSV. As colunas de gols dos jogos ainda não realizados ficam como NaN
(pandas já faz essa conversão automaticamente ao ler o CSV).
"""

from __future__ import annotations

import pandas as pd

COLUNAS_ESPERADAS = [
    "rodada",
    "time_mandante",
    "gols_mandante",
    "time_visitante",
    "gols_visitante",
]


def carregar_jogos(caminho: str) -> pd.DataFrame:
    """Lê o CSV de jogos do campeonato.

    Args:
        caminho: caminho para o `brasileirao_2026.csv` (ex.: `data/raw/...`).

    Returns:
        DataFrame com uma linha por jogo. Jogos ainda não realizados têm
        `gols_mandante`/`gols_visitante` como `NaN`.

    Raises:
        ValueError: se alguma coluna esperada estiver faltando no CSV.
    """
    jogos = pd.read_csv(caminho)

    faltando = set(COLUNAS_ESPERADAS) - set(jogos.columns)
    if faltando:
        raise ValueError(f"Colunas faltando no CSV: {sorted(faltando)}")

    return jogos


def jogos_disputados(jogos: pd.DataFrame) -> pd.DataFrame:
    """Filtra apenas os jogos que já têm resultado (gols preenchidos)."""
    return jogos.dropna(subset=["gols_mandante", "gols_visitante"])


def jogos_pendentes(jogos: pd.DataFrame) -> pd.DataFrame:
    """Filtra os jogos ainda não realizados (gols em branco) — o que precisa
    ser simulado."""
    return jogos[jogos["gols_mandante"].isna()]
