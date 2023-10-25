#CRIANDO CTE, ESTRUTURA TEMPORÁRIA PARA A CONSULTA COM A SOMA DO VALOR DE TODOS OS GRUPOS, QUE REPRESENTA 100% DO VALOR DA RECEITA DE CADA ANO
  
WITH ReceitaComLag AS (
    SELECT
        ano_calendario,
        SUM(valor_receita_tributaria) AS total_receita
    FROM tabela_1_base_de_incidencia
    WHERE grupo = 'true'
    GROUP BY ano_calendario
)

#CONSULTA QUE VAI ME RETORNAR A PORCENTAGEM ARREDONDADA DO CRESCIMENTO EM RELAÇÃO AO ANO ANTERIOR, POR ISSO UTILIZEI A FUNÇÃO LAG, 
#PARA CONSEGUIR FAZER O CÁLCULO DA PORCENTAGEM SEMPRE BUSCANDO O VALOR DO ANO ANTERIOR E AGRUPANDO E ORDENANDO O OUTPUT COM BASE NO ANO

SELECT
    T1.ano_calendario,
    T1.total_receita,
    ROUND(
        ((T1.total_receita - LAG(T1.total_receita, 1, 0) OVER (ORDER BY T1.ano_calendario)) / 
        LAG(T1.total_receita, 1, 0) OVER (ORDER BY T1.ano_calendario)) * 100, 2) || '%' AS porcentagem_crescimento_receita
FROM ReceitaComLag T1
ORDER BY T1.ano_calendario;
