# Carrega as funcoes de R/ antes de rodar os testes.
# Assume que os testes sao executados a partir da raiz do repositorio
# (ver README.md / CLAUDE.md).
for (arquivo in list.files("R", pattern = "\\.R$", full.names = TRUE)) {
  source(arquivo)
}
