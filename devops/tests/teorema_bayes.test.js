// teorema_bayes.test.js

// Função a ser testada.
function teorema_bayes(pBa, pA, pNotA, pNotBa) {
    const pB = pA * pBa + pNotA * pNotBa;
    if (pB === 0) {
        throw new Error("Divisão por zero: a probabilidade do evento B é zero.");
    }
    return (pBa * pA) / pB;
}

// Agrupa os testes para a função.
describe('teorema_bayes', () => {

    // Teste 1: Caso de uso básico com os valores padrão.
    test('deve calcular a probabilidade condicional corretamente para valores normais', () => {
        const pBa = 0.9;
        const pA = 0.01;
        const pNotA = 0.99;
        const pNotBa = 0.05;
        // O valor exato do cálculo é 0.15384615384615385.
        // Expectativa ajustada para este valor exato para evitar erros de arredondamento.
        const resultadoEsperado = 0.15384615384615385;
        const resultado = teorema_bayes(pBa, pA, pNotA, pNotBa);
        // Precisão maior para garantir que a comparação passe.
        expect(resultado).toBeCloseTo(resultadoEsperado, 10);
    });

    // Teste 2: Caso de uso com probabilidades diferentes.
    test('deve retornar o resultado correto para um conjunto diferente de probabilidades', () => {
        const pBa = 0.8;
        const pA = 0.5;
        const pNotA = 0.5;
        const pNotBa = 0.1;
        // O valor exato do cálculo é 0.8888888888888888.
        // Expectativa ajustada para este valor exato.
        const resultadoEsperado = 0.8888888888888888;
        const resultado = teorema_bayes(pBa, pA, pNotA, pNotBa);
        // Precisão maior para garantir que a comparação passe.
        expect(resultado).toBeCloseTo(resultadoEsperado, 10);
    });

    // Teste 3: Caso de erro - divisão por zero.
    test('deve lançar um erro quando o denominador (pB) é zero', () => {
        const pBa = 0;
        const pA = 0;
        const pNotA = 1;
        const pNotBa = 0;
        // Função deve lançar um erro.
        expect(() => teorema_bayes(pBa, pA, pNotA, pNotBa)).toThrow("Divisão por zero: a probabilidade do evento B é zero.");
    });
});
