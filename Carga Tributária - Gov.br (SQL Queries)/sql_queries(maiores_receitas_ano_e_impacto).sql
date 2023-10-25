#CÓDIGO REFERENTE AO ANO 2021, PARA VERIFICAR OUTROS ANOS BASTA ALTERAR ANO_CALENDARIO DAS CLÁUSULAS WHERE PARA O ANO DESEJADO
#CÓDIGO FAZ A BUSCA DA RECEITA TOTAL USANDO LIKE, TAMBÉM PODERIA SER FEITA POR BUSCA PELO CÓDIGO DO IMPOSTO, MAS DEIXEI ASSIM PARA TERMOS DE VARIAÇÃO
#O LIMIT FOI DEIXADO COM 5 PARA MOSTRAR AS 5 MAIORES, MAS PODE SER ALTERADO PARA O VALOR DESEJADO
#PARA INCLUIR A SINAL DE PORCENTAGEM AO FINAL DO OUTPUT DA COLUNA PERC_IMPACTO_RECEITA_TOTAL, FOI UTILIZADO O MODO || % PELA FACILIDADE
  
SELECT
    descricao,
    valor_receita_tributaria,
    ROUND(
    valor_receita_tributaria / (SELECT
        valor_receita_tributaria
        FROM tabela_1_base_de_incidencia
        WHERE descricao LIKE 'Total da Receita%' AND ano_calendario = 2021) * 100) || '%' as perc_impacto_receita_total,
    ano_calendario
FROM tabela_1_base_de_incidencia
WHERE ano_calendario = 2021 AND subgrupo = 'true'
ORDER BY valor_receita_tributaria DESC
LIMIT 5
