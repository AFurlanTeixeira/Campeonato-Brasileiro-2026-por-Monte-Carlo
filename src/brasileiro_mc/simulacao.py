"""Simulação Monte Carlo dos jogos pendentes.

Ver `.ai/modelagem.md` (ADR-001) para o modelo de gols dado pelo enunciado.
Núcleo estatístico do laboratório — implementação é responsabilidade do
grupo (parte avaliada).
"""

from __future__ import annotations

import numpy as np
import pandas as pd


def simular_jogo(
    theta_mandante: float,
    phi_mandante: float,
    theta_visitante: float,
    phi_visitante: float,
    rng: np.random.Generator,
) -> tuple[int, int]:
    """Simula o placar de um jogo via Poisson (ADR-001).

    Args:
        theta_mandante: taxa de gols marcados do time mandante.
        phi_mandante: taxa de gols sofridos do time mandante.
        theta_visitante: taxa de gols marcados do time visitante.
        phi_visitante: taxa de gols sofridos do time visitante.
        rng: gerador de números aleatórios (`numpy.random.default_rng(seed)`),
            passado explicitamente para reprodutibilidade (ver
            `.ai/padroes-codigo.md`).

    Returns:
        Tupla `(gols_mandante, gols_visitante)`.

    TODO(grupo): implementar a amostragem Poisson com os parâmetros
    `(theta_mandante + phi_visitante) / 2` e `(theta_visitante + phi_mandante) / 2`.
    """
    raise NotImplementedError("simular_jogo ainda não implementado")


def simular_temporada(
    jogos_pendentes: pd.DataFrame,
    parametros: pd.DataFrame,
    rng: np.random.Generator,
) -> pd.DataFrame:
    """Simula todos os jogos pendentes de uma temporada, uma vez.

    Args:
        jogos_pendentes: jogos ainda não realizados (ver `dados.jogos_pendentes`).
        parametros: θ/ϕ por time (saída de `estimativas.estimar_parametros`).
        rng: gerador de números aleatórios.

    Returns:
        Cópia de `jogos_pendentes` com `gols_mandante`/`gols_visitante`
        preenchidos com os resultados simulados.

    TODO(grupo): aplicar `simular_jogo` a cada linha, usando os parâmetros do
    mandante e do visitante de cada jogo.
    """
    raise NotImplementedError("simular_temporada ainda não implementado")
