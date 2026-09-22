"""Testes de `dados.py` (carregamento e filtros de jogos disputados/pendentes)."""

from __future__ import annotations

import pandas as pd
import pytest

from brasileirao_mc.dados import carregar_jogos, jogos_disputados, jogos_pendentes

CSV_EXEMPLO = """rodada,time_mandante,gols_mandante,time_visitante,gols_visitante
1,A,2,B,1
1,C,,D,
"""


@pytest.fixture
def csv_path(tmp_path):
    caminho = tmp_path / "jogos.csv"
    caminho.write_text(CSV_EXEMPLO)
    return str(caminho)


def test_carregar_jogos_le_todas_as_linhas(csv_path):
    jogos = carregar_jogos(csv_path)
    assert len(jogos) == 2


def test_carregar_jogos_valida_colunas(tmp_path):
    caminho = tmp_path / "invalido.csv"
    caminho.write_text("rodada,time_mandante\n1,A\n")

    with pytest.raises(ValueError):
        carregar_jogos(str(caminho))


def test_jogos_disputados_e_pendentes(csv_path):
    jogos = carregar_jogos(csv_path)

    assert len(jogos_disputados(jogos)) == 1
    assert len(jogos_pendentes(jogos)) == 1
    assert jogos_pendentes(jogos).iloc[0]["time_mandante"] == "C"
