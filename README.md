# Dashboard de Vendas com SQL e Power BI

Este projeto é um dashboard interativo que analisa dados de vendas utilizando SQL para consultas e Power BI para visualização. O objetivo é proporcionar uma visão clara e detalhada das vendas, ajudando na tomada de decisões e na análise de desempenho.


## Visão Geral

O dashboard fornece uma análise detalhada das vendas de produtos, incluindo informações sobre clientes, funcionários, e categorias de produtos. Ele é projetado para ajudar a visualizar e interpretar dados complexos de vendas de forma intuitiva e interativa.

## Estrutura do Projeto

O projeto está organizado da seguinte forma:

- **/docs**: Contém o diagrama do banco de dados e o arquivo do Power BI.
  - `diagrama_banco.png`: Diagrama do banco de dados que ilustra a estrutura e as relações entre tabelas.
  - `dashboard.pbix`: Arquivo do Power BI com o dashboard interativo.

- **/sql**: Contém o código SQL utilizado para consultar os dados.
  - `consultas.sql`: Código SQL para gerar os dados usados no dashboard.

- **README.md**: Este arquivo de documentação.

## Código SQL

O código SQL é utilizado para extrair e processar dados de vendas do banco de dados. Ele inclui consultas que agregam informações sobre produtos, clientes, funcionários e categorias, e calculam o total das vendas. 

### Exemplo de Consulta SQL

A consulta principal utilizada para gerar os dados para o dashboard é:

```sql
SELECT
    PR.ProdutoId,
    PR.Descricao AS Produtos,
    PR.Unidades,
    PR.Descontinuado,
    PE.DataEntrega,
    PE.DataPedido,
    PE.Frete,
    F.FuncionarioId,
    F.Cargo,
    F.Salario,
    E.Cidade,
    E.Pais,
    CL.NomeCompleto AS Clientes,
    CA.Descricao AS Categoria,
    DP.Quantidade,
    SUM((DP.Preco * DP.Quantidade) - DP.Desconto + PE.Frete) AS Vendas
FROM
    TB_PRODUTO PR
JOIN
    TB_DETALHE_PEDIDO DP ON DP.ProdutoId = PR.ProdutoId
JOIN
    TB_PEDIDO PE ON PE.NumeroPedido = DP.NumeroPedido
JOIN
    TB_CATEGORIA CA ON CA.CategoriaId = PR.CategoriaId
JOIN
    TB_FUNCIONARIO F ON F.FuncionarioId = PE.FuncionarioId
JOIN
    TB_CLIENTE CL ON CL.ClienteId = PE.ClienteId
JOIN
    TB_ENDERECO E ON E.ClienteId = CL.ClienteId
GROUP BY
    PR.ProdutoId,
    PR.Descricao,
    PR.Unidades,
    PR.Descontinuado,
    PE.DataEntrega,
    PE.DataPedido,
    PE.Frete,
    F.FuncionarioId,
    F.Cargo,
    F.Salario,
    E.Cidade,
    E.Pais,
    CL.NomeCompleto,
    CA.Descricao,
    DP.Quantidade
ORDER BY
    Vendas;
