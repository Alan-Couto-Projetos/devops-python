# devops\app\main.py

# Criação da função.
def teorema_bayes(pBa, pA, pNotA, pNotBa):
    """Calcula a probabilidade condicional usando o Teorema de Bayes."""
    pB = pA * pBa + pNotA * pNotBa
    return (pBa * pA) / pB

if __name__ == "__main__":
    # Exemplo: probabilidade de estar doente dado que o teste deu positivo
    pBa = 0.9      # P(Positivo | Doente)
    pA = 0.01      # P(Doente)
    pNotA = 0.99   # P(Não Doente)
    pNotBa = 0.05  # P(Positivo | Não Doente)

    resultado = teorema_bayes(pBa, pA, pNotA, pNotBa)

    # Exibe o resultado do cálculo com 4 casas decimais.
    print(f"Resultado do teorema de Bayes: {resultado:.4f}")


