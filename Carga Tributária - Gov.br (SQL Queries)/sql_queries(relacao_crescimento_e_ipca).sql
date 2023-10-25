#ESSA QUERY TEM COMO BASE A QUERY 'CRESCIMENTO POR ANO' SOMADA AO ÍNDICE IPCA DA TABELA 'IPCA - INDICE NACIONAL DE PREÇOS AO CONSUMIDOR AMPLO' ATRAVÉS DE UMA CLÁUSULA JOIN
#PARA FAZER ESSA JOIN, UTILIZAMOS A COLUNA ANO E ANO_CALENDARIO E AMBOS OS OUTPUTS FORAM TRADUZIDOS NA FORMA DE PORCENTAGEM PARA MELHOR LEITURA
  
WITH ReceitaComLag AS (
    SELECT
        ano_calendario,
        SUM(valor_receita_tributaria) AS total_receita
    FROM tabela_1_base_de_incidencia
    WHERE grupo = 'true'
    GROUP BY ano_calendario
)

SELECT
    base.valor_receita_tributaria AS total_da_receita_tributaria,
    ROUND(
        ((T1.total_receita - LAG(T1.total_receita, 1, 0) OVER (ORDER BY T1.ano_calendario)) / 
        LAG(T1.total_receita, 1, 0) OVER (ORDER BY T1.ano_calendario)) * 100, 2) || '%' AS porcentagem_crescimento_receita,
    ipca.variacao_acumulada_no_ano_durante_o_plano_real || '%' AS IPCA,
    ipca.ano
FROM tabela_1_base_de_incidencia AS base
JOIN ipca_indice_nacional_de_precos_ao_consumidor_amplo AS ipca
ON base.ano_calendario = ipca.ano
JOIN ReceitaComLag T1
ON base.ano_calendario = T1.ano_calendario
WHERE base.cod_receita_tributaria = 0
ORDER BY base.ano_calendario;
