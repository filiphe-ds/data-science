#RANKING DAS 5 MAIORES CARGAS TRIBUTÁRIAS POR VALOR TOTAL, ORDENADA POR QUANTIDADE DE VEZES QUE APARECEM ENTRE AS 5 MAIORES E SEU RESPECTIVO VALOR AGREGADO
#FOI REALIZADA UMA SUBCONSULTA PARA CRIAR O RANKING POR ANO E ORDENADO PELOS MAIORES VALORES DE CADA SUBGRUPO, QUE REPRESENTA CADA IMPOSTO NÃO AGREGADO
#NA CONSULTA BUSCAMOS CONTAR QUANTAS VEZES CADA REGISTRO APARECE ENTRE OS 5 PRIMEIROS E TRAZER ESSE OUTPUT E TAMBÉM O VALOR TOTAL DE CARGA TRIBUTÁRIA ARRECADADO AO LONGO DOS ANOS

WITH rankeamento AS (
    SELECT 
        descricao,
        valor_receita_tributaria,
        ano_calendario,
        RANK() OVER (PARTITION BY ano_calendario ORDER BY valor_receita_tributaria DESC) AS rank
    FROM tabela_1_base_de_incidencia
    WHERE subgrupo = 'true'
)

SELECT
    r.descricao,
    COUNT(*) AS quantidade,
    SUM(r.valor_receita_tributaria) AS soma_valor_receita
FROM (
    SELECT
        descricao,
        ano_calendario,
        valor_receita_tributaria,
        RANK() OVER (PARTITION BY ano_calendario ORDER BY valor_receita_tributaria DESC) AS rank
    FROM rankeamento
    WHERE rank <= 5
) AS r
GROUP BY r.descricao
ORDER BY quantidade DESC;
