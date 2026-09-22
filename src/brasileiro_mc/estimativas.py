"""Estimação de θ (ataque) e ϕ (defesa) por time.

Ver `.ai/modelagem.md` (ADR-002) para a definição dada pelo enunciado:
θ = média de gols marcados por jogo; ϕ = média de gols sofridos por jogo,
considerando apenas os jogos já disputados.

Núcleo estatístico do laboratório — implementação é responsabilidade do
grupo (parte avaliada).
"""

from __future__ import annotations

import pandas as pd


def estimar_parametros(jogos_disputados: pd.DataFrame) -> pd.DataFrame:
    """Estima θ e ϕ para cada time a partir dos jogos já disputados.

    Args:
        jogos_disputados: jogos com `gols_mandante`/`gols_visitante`
            preenchidos (ver `dados.jogos_disputados`).

    Returns:
        DataFrame indexado por time, com colunas `theta` e `phi`.

    TODO(grupo): implementar o estimador (ADR-002 em `.ai/modelagem.md`).
    Lembrar que cada jogo contribui para o ataque/defesa de dois times (o
    mandante e o visitante), cada um com seus próprios gols marcados/sofridos
    naquele jogo.
    """
    raise NotImplementedError("estimar_parametros ainda não implementado")
