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