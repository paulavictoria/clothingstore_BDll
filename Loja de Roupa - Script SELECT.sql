
-- 1. Produtos em estoque com suas quantidades e datas
SELECT p.nome_produto, e.qtdEstoque, e.data_deEntrada
FROM Produto p
JOIN Estoque e ON p.idProduto = e.idProduto;

-- 2. Vendas acima de R$ 150
SELECT * FROM Venda WHERE valorTotal > 150;

-- 3. Produtos que nunca foram vendidos
SELECT * FROM Produto 
WHERE idProduto NOT IN (SELECT DISTINCT idProduto FROM ItemVendaProduto);

-- 4. Estoque abaixo de 10 unidades
SELECT p.nome_produto, e.qtdEstoque
FROM Produto p
JOIN Estoque e ON p.idProduto = e.idProduto
WHERE e.qtdEstoque < 10;

-- 5. Média de valor total das vendas
SELECT AVG(valorTotal) AS mediaVendas FROM Venda;

-- 6. Vendas feitas no mês atual
SELECT * FROM Venda WHERE MONTH(dataVenda) = MONTH(CURDATE());

-- 7. Produtos em estoque com suas quantidades
SELECT p.nome_produto, e.qtdEstoque, e.data_deEntrada
FROM Produto p
JOIN Estoque e ON p.idProduto = e.idProduto;

-- 8. Produtos com promoções ativas
SELECT p.nome_produto, pr.descricao, pr.valorDesconto
FROM Produto p
JOIN PromocaoProduto pp ON p.idProduto = pp.idProduto
JOIN Promoção pr ON pp.idPromocao = pr.idPromocao
WHERE CURDATE() BETWEEN pr.dataInicio AND pr.dataFim;

-- 9. Produtos que nunca foram vendidos
SELECT * FROM Produto
WHERE idProduto NOT IN (SELECT DISTINCT idProduto FROM ItemVendaProduto);

-- 10. Promoções expiradas
SELECT * FROM Promoção WHERE dataFim < CURDATE();

-- 11. Estoque abaixo de 10 unidades
SELECT p.nome_produto, e.qtdEstoque
FROM Produto p
JOIN Estoque e ON p.idProduto = e.idProduto
WHERE e.qtdEstoque < 10;

-- 12. Produtos com fornecedores cadastrados
SELECT DISTINCT p.nome_produto
FROM Produto p
JOIN FornecedorProduto fp ON p.idProduto = fp.idProduto;

-- 13. Produtos e fornecedores
SELECT p.nome_produto, f.nome AS fornecedor
FROM Produto p
JOIN FornecedorProduto fp ON p.idProduto = fp.idProduto
JOIN Fornecedor f ON fp.idFornecedor = f.idFornecedor;

-- 14. Total vendido no mês atual
SELECT SUM(valorTotal) AS totalMes
FROM Venda
WHERE MONTH(dataVenda) = MONTH(CURDATE())
  AND YEAR(dataVenda) = YEAR(CURDATE());

-- 15. Formas de pagamento mais usadas
SELECT formaPagamento, COUNT(*) AS quantidade
FROM Venda
GROUP BY formaPagamento
ORDER BY quantidade DESC;

-- 16. Vendas com valor total superior à média
SELECT * FROM Venda
WHERE valorTotal > (
    SELECT AVG(valorTotal) FROM Venda
);

-- 17. Produtos vendidos em promoções
SELECT DISTINCT p.nome_produto, pr.descricao AS promoção
FROM ItemVendaProduto ivp
JOIN Produto p ON ivp.idProduto = p.idProduto
JOIN PromocaoProduto pp ON p.idProduto = pp.idProduto
JOIN Promoção pr ON pp.idPromocao = pr.idPromocao;

-- 18. Produtos com promoções que terminam nesta semana
SELECT p.nome_produto, pr.descricao, pr.dataFim
FROM Produto p
JOIN PromocaoProduto pp ON p.idProduto = pp.idProduto
JOIN Promoção pr ON pp.idPromocao = pr.idPromocao
WHERE WEEK(pr.dataFim) = WEEK(CURDATE());

-- 19. Total de vendas por forma de pagamento
SELECT formaPagamento, COUNT(*) AS totalVendas, SUM(valorTotal) AS totalArrecadado
FROM Venda
GROUP BY formaPagamento;

-- 20. Produtos com estoque abaixo de 26 unidades
SELECT p.nome_produto, e.qtdEstoque, e.data_deEntrada
FROM Produto p
JOIN Estoque e ON p.idProduto = e.idProduto
WHERE e.qtdEstoque < 26;
