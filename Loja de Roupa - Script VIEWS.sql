-- 1. View de produtos em estoque
CREATE VIEW vw_produtos_estoque AS
SELECT p.nome_produto, e.qtdEstoque, e.data_deEntrada
FROM Produto p
JOIN Estoque e ON p.idProduto = e.idProduto;

-- 2. View de vendas detalhadas
CREATE VIEW vw_detalhes_vendas AS
SELECT v.idVenda, v.dataVenda, p.nome_produto, ivp.precoUnitario
FROM Venda v
JOIN ItemVendaProduto ivp ON v.idVenda = ivp.idVenda
JOIN Produto p ON ivp.idProduto = p.idProduto;

-- 3. View de estoque crítico
CREATE VIEW vw_estoque_baixo AS
SELECT p.nome_produto, e.qtdEstoque
FROM Produto p
JOIN Estoque e ON p.idProduto = e.idProduto
WHERE e.qtdEstoque < 10;

-- 4. View de produtos sem vendas
CREATE VIEW vw_produtos_sem_venda AS
SELECT * FROM Produto 
WHERE idProduto NOT IN (SELECT DISTINCT idProduto FROM ItemVendaProduto);

-- 5. View de fornecedores e produtos
CREATE VIEW vw_fornecedores_produtos AS
SELECT f.nome AS nomeFornecedor, p.nome_produto
FROM Fornecedor f
JOIN FornecedorProduto fp ON f.idFornecedor = fp.idFornecedor
JOIN Produto p ON fp.idProduto = p.idProduto;

-- VIEW 6: Produtos nunca vendidos
CREATE VIEW vw_produtos_nunca_vendidos AS
SELECT * FROM Produto
WHERE idProduto NOT IN (SELECT DISTINCT idProduto FROM ItemVendaProduto);

-- VIEW 7: Promoções expiradas
CREATE VIEW vw_promocoes_expiradas AS
SELECT * FROM Promoção
WHERE dataFim < CURDATE();

-- VIEW 8: Total vendido por mês
CREATE VIEW vw_total_vendido_mes AS
SELECT DATE_FORMAT(dataVenda, '%Y-%m') AS mes, SUM(valorTotal) AS totalMes
FROM Venda
GROUP BY mes
ORDER BY mes DESC;

-- VIEW 9: Produtos e seus fornecedores
CREATE VIEW vw_produtos_fornecedores AS
SELECT p.nome_produto, f.nome AS nomeFornecedor, f.telefone
FROM Produto p
JOIN FornecedorProduto fp ON p.idProduto = fp.idProduto
JOIN Fornecedor f ON fp.idFornecedor = f.idFornecedor;

-- VIEW 10: Produtos com promoções prestes a expirar
CREATE VIEW vw_promocoes_expirando AS
SELECT pr.idPromocao, pr.descricao, p.nome_produto, pr.dataFim
FROM Promoção pr
JOIN PromocaoProduto pp ON pr.idPromocao = pp.idPromocao
JOIN Produto p ON pp.idProduto = p.idProduto
WHERE pr.dataFim BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY);

