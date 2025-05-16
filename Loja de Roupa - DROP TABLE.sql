USE loja_de_roupa;

-- destruição das views
DROP VIEW IF EXISTS vw_relatorio_vendas_completo;
DROP VIEW IF EXISTS vw_clientes_frequentes;
DROP VIEW IF EXISTS vw_produtos_estoque_baixo;
DROP VIEW IF EXISTS vw_funcionarios_vendas;
DROP VIEW IF EXISTS vw_vendas_com_desconto;
DROP VIEW IF EXISTS vw_promocoes_ativas;
DROP VIEW IF EXISTS vw_faturamento_diario;
DROP VIEW IF EXISTS vw_vendas_por_forma_pagamento;
DROP VIEW IF EXISTS vw_produtos_nao_vendidos;
DROP VIEW IF EXISTS vw_clientes_por_genero;

-- remoção das constraints
ALTER TABLE PromocaoProduto DROP FOREIGN KEY idPromocao;
ALTER TABLE PromocaoProduto DROP FOREIGN KEY idProduto;
ALTER TABLE ItemVendaProduto DROP FOREIGN KEY idProduto;
ALTER TABLE ItemVendaProduto DROP FOREIGN KEY idVenda;
ALTER TABLE Venda DROP FOREIGN KEY cpfCliente;
ALTER TABLE Venda DROP FOREIGN KEY cpfFuncionario;
ALTER TABLE Produto DROP FOREIGN KEY idCategoria;
ALTER TABLE Produto DROP FOREIGN KEY idFornecedor;
ALTER TABLE Estoque DROP FOREIGN KEY idProduto;

-- destruição das tabelas
DROP TABLE IF EXISTS PromocaoProduto;
DROP TABLE IF EXISTS ItemVendaProduto;
DROP TABLE IF EXISTS Estoque;
DROP TABLE IF EXISTS Venda;
DROP TABLE IF EXISTS Promocao;
DROP TABLE IF EXISTS Produto;
DROP TABLE IF EXISTS Fornecedor;
DROP TABLE IF EXISTS Funcionario;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Categoria;

