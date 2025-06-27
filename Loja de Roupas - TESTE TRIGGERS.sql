use loja_de_roupa;


-- TESTE TRIGGER 1 


-- Verificar o estoque atual do Produto 1 (Camiseta Básica Branca)
SELECT idProduto, qtdEstoque FROM Estoque WHERE idProduto = 1; 

-- Inserir um novo item na venda para o Produto 1

SELECT MAX(idVenda) FROM Venda; 
SELECT MAX(idItem) FROM ItemVendaProduto; 

INSERT INTO ItemVendaProduto (idItem, idVenda, idProduto, quantidade, precoUnitario)
VALUES (15, 10, 1, 5, 49.90); 

-- Verificar o estoque do Produto 1 novamente (deve ter diminuído em 5)
SELECT idProduto, qtdEstoque FROM Estoque WHERE idProduto = 1; 


-- TESTE TRIGGER 2


-- Teste 1: Tentar atualizar o estoque diretamente para um valor 

UPDATE Estoque SET qtdEstoque = 5 WHERE idProduto = 1;

-- Teste 2: Tentar inserir um item de venda que exceda o estoque disponível (trg_PrevenirEstoqueNegativoVenda)

SELECT idProduto, qtdEstoque FROM Estoque WHERE idProduto = 2;

-- Tentar vender 10 unidades do Produto 2

INSERT INTO ItemVendaProduto (idItem, idVenda, idProduto, quantidade, precoUnitario)
VALUES (16, 5, 2, 5, 129.90);

-- Verificar se o estoque do Produto 2 não foi alterado
SELECT idProduto, qtdEstoque FROM Estoque WHERE idProduto = 2; -- Ainda deve ser 5


-- TESTE TRIGGER 3


-- Verificar o preço atual do Produto 1 (Camiseta Básica Branca)
SELECT idProduto, nome_produto, preco FROM Produto WHERE idProduto = 1; -- Ex: 49.90

-- Verificar o log de preços antes da atualização
SELECT * FROM LogPrecoProduto WHERE idProduto = 1;

-- Atualizar o preço do Produto 1
UPDATE Produto SET preco = 52.00 WHERE idProduto = 1;

-- Verificar o novo preço do Produto 1
SELECT idProduto, nome_produto, preco FROM Produto WHERE idProduto = 1; -- Deve ser 52.00

-- Verificar o log de preços novamente (deve ter um novo registro)
SELECT * FROM LogPrecoProduto WHERE idProduto = 1;

-- Tentar atualizar o preço para o mesmo valor (não deve criar um novo registro no log)
UPDATE Produto SET preco = 52.00 WHERE idProduto = 1;
SELECT * FROM LogPrecoProduto WHERE idProduto = 1; -- Não deve ter um novo registro


-- TESTE TRIGGER 4


-- Teste 1: Tentar inserir uma promoção com dataFim anterior à dataInicio (trg_ValidarDataPromocao)

INSERT INTO Promoção (idPromocao, descricao, tipoDesconto, valorDesconto, dataInicio, dataFim)
VALUES (1090, 'Promoção Inválida', 'Porcentagem', 10.00, '2025-07-10', '2025-07-15');

-- Teste 2: Tentar atualizar uma promoção existente com dataFim anterior à dataInicio (trg_ValidarDataPromocaoUpdate)

SELECT idPromocao, dataInicio, dataFim FROM Promoção WHERE idPromocao = 1001;

-- Tentar atualizar para uma data final inválida

UPDATE Promoção SET dataFim = '2025-05-01' WHERE idPromocao = 1001;

-- Teste 3: Inserir uma promoção válida
INSERT INTO Promoção (idPromocao, descricao, tipoDesconto, valorDesconto, dataInicio, dataFim)
VALUES (1091, 'Promoção Válida', 'Porcentagem', 10.00, '2025-08-01', '2025-08-31');
SELECT * FROM Promoção WHERE idPromocao = 1091;


-- TESTE TRIGGER 5


-- Verificar o log de novos clientes antes da inserção
SELECT * FROM LogNovoCliente;

-- Inserir um novo cliente
INSERT INTO Cliente (cpf, nome, telefone, endereco, email, sexo)
VALUES ('777.777.777-78', 'Teste Trigger Cliente', '(81) 97777-7777', 'Rua da Auditoria, 1 - PE', 'teste.trigger@email.com', 'Masculino');

-- Verificar o log de novos clientes novamente (deve ter um novo registro)
SELECT * FROM LogNovoCliente ORDER BY dataHoraCadastro DESC;

-- Inserir outro novo cliente
INSERT INTO Cliente (cpf, nome, telefone, endereco, email, sexo)
VALUES ('888.888.888-89', 'Mais Um Cliente', '(81) 98888-8888', 'Av. do Log, 2 - PE', 'mais.um@email.com', 'Feminino');
SELECT * FROM LogNovoCliente ORDER BY dataHoraCadastro DESC;


-- TESTE TRIGGER 6


-- Teste 1: Inserir um novo item em uma venda existente (trg_AtualizarValorTotalVenda_AI)

SELECT idVenda, valorTotal FROM Venda WHERE idVenda = 10;

-- Adicionar um novo item à Venda 10 (Produto 6 - Blusa Manga Longa, 59.90)

INSERT INTO ItemVendaProduto (idItem, idVenda, idProduto, quantidade, precoUnitario)
VALUES (17, 10, 6, 1, 59.90);

-- O valorTotal da Venda 10 deve ser atualizado para 89.90 + 59.90 = 149.80
SELECT idVenda, valorTotal FROM Venda WHERE idVenda = 10;


-- Teste 2: Atualizar a quantidade de um item de venda (trg_AtualizarValorTotalVenda_AU)
-- Item 17 (adicionado acima): Produto 6, 1 unidade, 59.90. Venda 10: 149.80
SELECT idItem, quantidade, precoUnitario FROM ItemVendaProduto WHERE idItem = 17;

-- Atualizar a quantidade do Item 17 para 2 unidades
UPDATE ItemVendaProduto SET quantidade = 2 WHERE idItem = 17;
-- O valorTotal da Venda 10 deve ser atualizado para 89.90 + (2 * 59.90) = 89.90 + 119.80 = 209.70
SELECT idVenda, valorTotal FROM Venda WHERE idVenda = 10;


-- Teste 3: Deletar um item de venda (trg_AtualizarValorTotalVenda_AD)

SELECT idItem, quantidade, precoUnitario FROM ItemVendaProduto WHERE idItem = 17;

-- Deletar o Item 17 da Venda 10
DELETE FROM ItemVendaProduto WHERE idItem = 17;

SELECT idVenda, valorTotal FROM Venda WHERE idVenda = 10;