use loja_de_roupa;

-- 1. Relatórios de vendas com informações de cliente e funcionários

select 
 V.idVenda,
    V.dataVenda,
    V.valorTotal,
    V.descontoTotal,
    V.formaPagamento,
    V.statusEntrega,
    C.nome AS nome_cliente,
    F.nome AS nome_funcionario
		from 
	 Venda AS V
JOIN
    Cliente AS C ON V.cpf_cliente = C.cpf
JOIN
    Funcionário AS F ON V.cpf_funcionario = F.cpf;
    
-- 2. Listar produtos com categoria e preço
SELECT
    p.nome_produto,
    c.nome_categoria,
    p.preco
FROM
    Produto p
JOIN
    Categoria c ON p.idCategoria = c.idCategoria;
    
-- 3. Visualizar as vendas realizadas por um funcionário específico, com data e valor da venda

SELECT
    f.nome AS NomeFuncionario,
    v.idVenda,
    v.dataVenda,
    v.valorTotal
FROM
    Funcionário f
JOIN
    Venda v ON f.cpf = v.cpf_funcionario
WHERE
    f.cpf = '117.115.714-01';
    
-- 4. Select pra calcular o valor total e o desconto total de uma venda especifica
 
SELECT
    idVenda,
    valorTotal,
    descontoTotal
FROM
    Venda
WHERE
    idVenda = 3;

-- 5. Clientes que mais realizaram compras

SELECT
    c.nome,
    COUNT(v.idVenda) AS TotalCompras
FROM
    Cliente c
JOIN
    Venda v ON c.cpf = v.cpf_cliente
GROUP BY
    c.cpf, c.nome
HAVING
    COUNT(v.idVenda) > 1;
    
    
    -- 6. Produtos mais vendidos (top 5 mais vendidos)
    
SELECT
    p.nome_produto,
    SUM(ivp.quantidade) AS QuantidadeTotalVendida
FROM
    Produto p
JOIN
    ItemVendaProduto ivp ON p.idProduto = ivp.idProduto
GROUP BY
    p.nome_produto
ORDER BY
    QuantidadeTotalVendida DESC
LIMIT 5; 

-- 7.  Receita total gerada por vendas do mês de maio

SELECT
    SUM(valorTotal) AS ReceitaTotal
FROM
    Venda
WHERE
    DATE_FORMAT(dataVenda, '%Y-%m') = '2025-05';


-- 8. Quantidade atual da cada produto

SELECT
    p.nome_produto,
    e.qtdEstoque
FROM
    Produto p
JOIN
    Estoque e ON p.idProduto = e.idProduto;
    
    
    -- 9. Venda com maior valor total
    
SELECT
    v.idVenda,
    v.valorTotal,
    c.nome AS NomeCliente,
    f.nome AS NomeFuncionario
FROM
    Venda v
JOIN
    Cliente c ON v.cpf_cliente = c.cpf
JOIN
    Funcionário f ON v.cpf_funcionario = f.cpf
ORDER BY
    v.valorTotal DESC
LIMIT 1;
    
    
    -- 10. Contabilizar o numero de vendas por cada funcionario
    
SELECT
    f.nome AS NomeFuncionario,
    COUNT(v.idVenda) AS NumeroDeVendas
FROM
    Funcionário f
LEFT JOIN
    Venda v ON f.cpf = v.cpf_funcionario
GROUP BY
    f.nome
ORDER BY
    NumeroDeVendas DESC;
    
    
    -- 11. Identificar os produtos que nunca foram associados a uma promoção
    
SELECT
    p.nome_produto,
    p.descricao
FROM
    Produto p
WHERE
    p.idProduto NOT IN (SELECT DISTINCT idProduto FROM PromocaoProduto); 
    
    
    -- 12. Listar as vendas que foram pagas com uma forma de pagamento especificado no where
    
SELECT
    v.idVenda,
    v.dataVenda,
    v.valorTotal,
    v.formaPagamento,
    c.nome AS NomeCliente
FROM
    Venda v
JOIN
    Cliente c ON v.cpf_cliente = c.cpf
WHERE
    v.formaPagamento = 'Cartão de Crédito';
    
    -- 13. Listar as vendas que foram pagas com uma forma de pagamento especificado no where "pix"

SELECT
       v.idVenda,
    v.dataVenda,
    v.valorTotal,
    v.formaPagamento,
    c.nome AS NomeCliente
FROM
    Venda v
JOIN
    Cliente c ON v.cpf_cliente = c.cpf
WHERE
    v.formaPagamento = 'Pix';
    
    -- 14. Calcular o valor médio de uma venda
    
SELECT
    AVG(valorTotal) AS ValorMedioVenda
FROM
    Venda;
    
    
    -- 15. Listar os funcionários e o total de vendas que cada um gerou
    
SELECT
    f.nome AS NomeFuncionario,
    SUM(v.valorTotal) AS TotalVendasGeradas
FROM
    Funcionário f
LEFT JOIN
    Venda v ON f.cpf = v.cpf_funcionario
GROUP BY
    f.nome
ORDER BY
    TotalVendasGeradas DESC;
    
    
    -- 16. Encontrar as categorias de produtos que têm estoque baixo
    
SELECT
    cat.nome_categoria,
    SUM(e.qtdEstoque) AS EstoqueTotalNaCategoria
FROM
    Categoria cat
JOIN
    Produto p ON cat.idCategoria = p.idCategoria
JOIN
    Estoque e ON p.idProduto = e.idProduto
GROUP BY
    cat.nome_categoria
HAVING
    SUM(e.qtdEstoque) < 50;
    
    
    -- 17. Determinar o dia da semana com o maior volume de vendas
    
SELECT
    DAYNAME(dataVenda) AS DiaDaSemana,
    COUNT(idVenda) AS NumeroDeVendas
FROM
    Venda
GROUP BY
    DiaDaSemana
ORDER BY
    NumeroDeVendas DESC
LIMIT 1;


-- 18. Produtos em estoque que nunca foram vendidos

SELECT
    p.nome_produto,
    p.descricao,
    e.qtdEstoque
FROM
    Produto p
JOIN
    Estoque e ON p.idProduto = e.idProduto
WHERE
    p.idProduto NOT IN (SELECT DISTINCT idProduto FROM ItemVendaProduto);
    
    
    -- 19. Clientes que compraram produtos de uma categoria específica
    
SELECT DISTINCT
    c.nome AS NomeCliente,
    c.email
FROM
    Cliente c
JOIN
    Venda v ON c.cpf = v.cpf_cliente
JOIN
    ItemVendaProduto ivp ON v.idVenda = ivp.idVenda
JOIN
    Produto p ON ivp.idProduto = p.idProduto
JOIN
    Categoria cat ON p.idCategoria = cat.idCategoria
WHERE
    cat.nome_categoria = 'Calças';
    
    
    -- 20. Valor total de vendas por forma de pagamento
    
SELECT
    formaPagamento,
    SUM(valorTotal) AS ValorTotalVendido
FROM
    Venda
GROUP BY
    formaPagamento
ORDER BY
    ValorTotalVendido DESC;

