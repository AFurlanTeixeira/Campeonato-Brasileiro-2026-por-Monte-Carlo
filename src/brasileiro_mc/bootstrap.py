"""Intervalos de confiança para θ/ϕ via bootstrap.

Ver `.ai/modelagem.md` (ADR-003): reamostragem com reposição dos jogos de
cada time, recalculando θ/ϕ em cada amostra. Núcleo estatístico do
laboratório — implementação é responsabilidade do grupo (parte avaliada).
"""

from __future__ import annotations

import numpy as np
import pandas as pd


def bootstrap_parametros(
    jogos_disputados: pd.DataFrame,
    n_reamostragens: int,
    rng: np.random.Generator,
) -> pd.DataFrame:
    """Gera `n_reamostragens` estimativas de θ/ϕ por time via bootstrap.

    Args:
        jogos_disputados: jogos já disputados (ver `dados.jogos_disputados`).
        n_reamostragens: número de amostras bootstrap.
        rng: gerador de números aleatórios.

    Returns:
        DataFrame longo com uma linha por (time, reamostragem), colunas
        `theta` e `phi` — pronto para calcular percentis (IC) ou plotar.

    TODO(grupo): para cada time, reamostrar os jogos dele com reposição
    (`n_reamostragens` vezes) e recalcular θ/ϕ em cada amostra usando
    `estimativas.estimar_parametros` (ou a lógica equivalente por time).
    """
    raise NotImplementedError("bootstrap_parametros ainda não implementado")


def intervalo_confianca(amostras: pd.Series, confianca: float = 0.95) -> tuple[float, float]:
    """Calcula o IC por percentis a partir de amostras bootstrap.

    Args:
        amostras: valores de θ ou ϕ obtidos via bootstrap para um único time.
        confianca: nível de confiança (ex.: 0.95 para IC de 95%).

    Returns:
        Tupla `(limite_inferior, limite_superior)`.
    """
    alfa = 1 - confianca
    return (
        float(np.percentile(amostras, 100 * alfa / 2)),
        float(np.percentile(amostras, 100 * (1 - alfa / 2))),
    )
