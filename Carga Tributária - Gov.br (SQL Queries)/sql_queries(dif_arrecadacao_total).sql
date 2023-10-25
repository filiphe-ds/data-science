#CRIAÇÃO DE UMA COLUNA (output) PARA DAR NOME AO VALOR ENCONTRADO COM BASE NOS VALORES TOTAIS DO ANO 2002 E 2021
#COD_RECEITA_TRIBUTARIA REPRESENTA O GRUPO GERAL DOS VALOR, QUE COMPREENDE A SOMA TOTAL DOS VALORES DO ANO ESPECIFICADO PELA CLÁUSULA WHERE
 
  SELECT
    'Diferença arrecadação 2002-2021' as output,
    (SELECT valor_receita_tributaria
     FROM tabela_1_base_de_incidencia
     WHERE ano_calendario = 2021 AND cod_receita_tributaria = 0) -
    (SELECT valor_receita_tributaria
     FROM tabela_1_base_de_incidencia
     WHERE ano_calendario = 2002 AND cod_receita_tributaria = 0) as diferenca_em_reais,
     ROUND(
     ((SELECT valor_receita_tributaria
     FROM tabela_1_base_de_incidencia
     WHERE ano_calendario = 2021 AND cod_receita_tributaria = 0) - 
     (SELECT valor_receita_tributaria
     FROM tabela_1_base_de_incidencia
     WHERE ano_calendario = 2002 AND cod_receita_tributaria = 0)) / 
     (SELECT valor_receita_tributaria
     FROM tabela_1_base_de_incidencia
     WHERE ano_calendario = 2002 AND cod_receita_tributaria = 0) * 100) || '%' as diferenca_em_porcentagem
FROM tabela_1_base_de_incidencia
LIMIT 1
