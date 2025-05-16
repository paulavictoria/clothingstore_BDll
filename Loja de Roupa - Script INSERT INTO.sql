-- INSERTS DAS TABELAS 


INSERT INTO Categoria (idCategoria, nome_categoria) VALUES
(1, 'Camisetas'),
(2, 'Calças'),
(3, 'Vestidos'),
(4, 'Shorts'),
(5, 'Saias'),
(6, 'Blusas'),
(7, 'Jaquetas'),
(8, 'Moletons'),
(9, 'Macacões'),
(10, 'Acessórios');

INSERT INTO Produto (
  idProduto, nome_produto, descricao, preco, tamanho, cor, marca, idCategoria
) VALUES
(1, 'Camiseta Básica Branca', 'Camiseta de algodão branca unissex', 49.90, 'M', 'Branco', 'Hering', 1),
(2, 'Calça Jeans Slim', 'Calça jeans azul modelo slim fit', 129.90, '42', 'Azul', 'Levi\'s', 2),
(3, 'Vestido Floral Curto', 'Vestido curto com estampa floral', 99.90, 'P', 'Rosa', 'Zara', 3),
(4, 'Short Jeans Feminino', 'Short jeans com cintura alta', 79.90, 'M', 'Azul Claro', 'C&A', 4),
(5, 'Saia Plissada', 'Saia plissada midi elegante', 89.90, 'G', 'Preto', 'Renner', 5),
(6, 'Blusa Manga Longa', 'Blusa básica de manga longa em algodão', 59.90, 'M', 'Cinza', 'Riachuelo', 6),
(7, 'Jaqueta Jeans Oversized', 'Jaqueta jeans oversized com bolsos', 159.90, 'G', 'Jeans', 'Forever 21', 7),
(8, 'Moletom Capuz Masculino', 'Moletom com capuz e bolso canguru', 109.90, 'GG', 'Preto', 'Nike', 8),
(9, 'Macacão Pantacourt', 'Macacão modelo pantacourt com amarração', 139.90, 'M', 'Verde', 'Amaro', 9),
(10, 'Cinto de Couro', 'Cinto de couro legítimo com fivela metálica', 59.90, 'Único', 'Marrom', 'Aramis', 10);


INSERT INTO Cliente (cpf, nome, telefone, endereco) VALUES
('111.111.111-12', 'Ana Paula Costante', '(81) 99888-0001', 'Rua das Rosas, 123 - Recife/PE'),
('222.222.222-22', 'Bruno Henrique Costa', '(81) 99888-0002', 'Av. Boa Viagem, 2000 - Recife/PE'),
('333.333.333-33', 'Carla Dias Lima', '(81) 99888-0003', 'Rua Imperial, 555 - Recife/PE'),
('444.444.444-44', 'Daniel Souza Melo', '(81) 99888-0004', 'Rua Amélia, 150 - Recife/PE'),
('555.555.555-55', 'Eduarda Gomes Silva', '(81) 99888-0005', 'Rua do Futuro, 320 - Recife/PE'),
('666.666.666-66', 'Fernando Barros', '(81) 99888-0006', 'Rua Real da Torre, 874 - Recife/PE'),
('777.777.777-77', 'Gabriela Nunes', '(81) 99888-0007', 'Rua Benfica, 99 - Recife/PE'),
('888.888.888-88', 'Hugo Andrade', '(81) 99888-0008', 'Rua dos Palmares, 456 - Recife/PE'),
('999.999.999-99', 'Isabela Castro', '(81) 99888-0009', 'Rua do Hospício, 1030 - Recife/PE'),
('000.000.000-00', 'João Vitor Marques', '(81) 99888-0010', 'Av. Norte, 300 - Recife/PE');


INSERT INTO Funcionário (cpf, nome, cargo, telefone, endereco, email, sexo) VALUES
('111.111.111-11', 'Carlos Eduardo Santos', 'Vendedor', '(81) 99988-0001', 'Rua das Flores, 123 - Recife/PE', 'carlos.santos@email.com', 'Masculino'),
('222.222.222-22', 'Fernanda Oliveira Lima', 'Caixa', '(81) 99988-0002', 'Av. Boa Vista, 200 - Recife/PE', 'fernanda.lima@email.com', 'Feminino'),
('333.333.333-33', 'Gustavo Pereira Silva', 'Gerente', '(81) 99988-0003', 'Rua Imperial, 555 - Recife/PE', 'gustavo.silva@email.com', 'Masculino'),
('444.444.444-44', 'Larissa Rodrigues', 'Vendedora', '(81) 99988-0004', 'Rua da Aurora, 800 - Recife/PE', 'larissa.rodrigues@email.com', 'Feminino'),
('555.555.555-55', 'Ricardo Almeida Costa', 'Estoquista', '(81) 99988-0005', 'Rua Real da Torre, 100 - Recife/PE', 'ricardo.costa@email.com', 'Masculino'),
('666.666.666-66', 'Mariana Souza Silva', 'Assistente de Marketing', '(81) 99988-0006', 'Rua do Futuro, 320 - Recife/PE', 'mariana.silva@email.com', 'Feminino'),
('777.777.777-77', 'João Pedro Martins', 'Segurança', '(81) 99988-0007', 'Rua Palmares, 230 - Recife/PE', 'joao.martins@email.com', 'Masculino'),
('888.888.888-88', 'Amanda Costa Nunes', 'Gerente de Vendas', '(81) 99988-0008', 'Av. Norte, 500 - Recife/PE', 'amanda.nunes@email.com', 'Feminino'),
('999.999.999-99', 'Vinícius Pereira Mendes', 'Supervisor', '(81) 99988-0009', 'Rua das Pedras, 450 - Recife/PE', 'vinicius.mendes@email.com', 'Masculino'),
('123.456.789-00', 'Patrícia Ribeiro Silva', 'Coordenadora de Recursos Humanos', '(81) 99988-0010', 'Rua do Hospício, 200 - Recife/PE', 'patricia.silva@email.com', 'Feminino');

INSERT INTO venda (idVenda, dataVenda, valorTotal, descontoTotal, formaPagamento, statusEntrega, cpf_cliente, cpf_funcionario) VALUES
(1, '2025-05-01', 199.80, 10.00, 'Cartão de Crédito', 'Entregue', '111.111.111-11', '117.115.714-01'),
(2, '2025-05-02', 109.90, 0.00, 'Pix', 'Pendente', '222.222.222-22', '119.986.125-14'),
(3, '2025-05-03', 149.90, 5.00, 'Dinheiro', 'Entregue', '333.333.333-33', '121.845.541-54'),
(4, '2025-05-04', 59.90, 0.00, 'Cartão de Débito', 'Em transporte', '444.444.444-44', '128.114.742-15'),
(5, '2025-05-05', 89.90, 10.00, 'Cartão de Crédito', 'Cancelado', '555.555.555-55', '351.192.129-02'),
(6, '2025-05-06', 199.90, 0.00, 'Pix', 'Entregue', '666.666.666-66', '789.478.123-04'),
(7, '2025-05-07', 129.90, 20.00, 'Dinheiro', 'Entregue', '777.777.777-77', '913.878.442-10'),
(8, '2025-05-08', 59.90, 0.00, 'Cartão de Débito', 'Em transporte', '888.888.888-88', '914.778.512-25'),
(9, '2025-05-09', 109.90, 5.00, 'Pix', 'Pendente', '999.999.999-99', '987.555.211-11'),
(10, '2025-05-10', 89.90, 0.00, 'Dinheiro', 'Entregue', '000.000.000-00', '991.878.742-35');


INSERT INTO Fornecedor (idFornecedor, nome, email, telefone, endereco) VALUES
(1, 'Tecidos Brasil', 'contato@tecidosbrasil.com', '(81) 91234-5678', 'Rua das Costuras, 123 - Recife'),
(2, 'Moda Fashion', 'atendimento@modafashion.com.br', '(81) 99876-5432', 'Av. Estilo, 456 - Olinda'),
(3, 'Estilo Rápido', 'vendas@estilorapido.com', '(81) 98765-4321', 'Travessa da Moda, 77 - Jaboatão'),
(4, 'Malhas do Agreste', 'malhas@agreste.com', '(81) 99444-1122', 'Rua das Malharias, 21 - Caruaru'),
(5, 'Distribuidora Roupas LTDA', 'distribuidora@roupas.com', '(81) 98111-2233', 'Av. Comércio, 989 - Paulista'),
(6, 'Tecelagem Moderna', 'moderna@tecelagem.com.br', '(81) 99666-7788', 'Rua dos Fios, 333 - Cabo de Santo Agostinho'),
(7, 'Fio Certo', 'contato@fiocerto.com', '(81) 99333-8877', 'Alameda Têxtil, 55 - Igarassu'),
(8, 'Confecções Silva', 'silva@confeccoes.com', '(81) 98222-3344', 'Rua do Algodão, 100 - Camaragibe'),
(9, 'Top Malhas', 'vendas@topmalhas.com', '(81) 97777-8899', 'Av. Central, 212 - Abreu e Lima'),
(10, 'Nova Têxtil', 'novatextil@fornecedores.com', '(81) 98888-7766', 'Rua Nova, 321 - Moreno'),
(11, 'Global Fios', 'global@fios.com', '(81) 97654-3210', 'Rua Global, 456 - Recife');

INSERT INTO Promoção (idPromocao, descricao, tipoDesconto, valorDesconto, dataInicio, dataFim) VALUES
(1, 'Promoção de Inverno - Jaquetas com 10% OFF', 'Porcentagem', 10.00, '2025-05-01', '2025-05-15'),
(2, 'Semana do Cliente - R$20 de desconto em compras acima de R$100', 'Valor Fixo', 20.00, '2025-05-02', '2025-05-09'),
(3, 'Liquidação de Blusas - 5% OFF', 'Porcentagem', 5.00, '2025-05-03', '2025-05-10'),
(4, 'Frete Grátis + R$10 OFF em pedidos selecionados', 'Valor Fixo', 10.00, '2025-05-04', '2025-05-20'),
(5, 'Cintos e Acessórios com 15% de desconto', 'Porcentagem', 15.00, '2025-05-05', '2025-05-18'),
(6, 'Festival de Moda - R$30 OFF nas compras acima de R$150', 'Valor Fixo', 30.00, '2025-05-06', '2025-05-15'),
(7, 'Desconto Relâmpago em Camisetas - 10%', 'Porcentagem', 10.00, '2025-05-07', '2025-05-10'),
(8, 'Oferta Especial em Vestidos - R$15 OFF', 'Valor Fixo', 15.00, '2025-05-08', '2025-05-13'),
(9, 'Promoção Dia das Mães - até 20% OFF', 'Porcentagem', 20.00, '2025-05-09', '2025-05-12'),
(10, 'Semana Jeans - R$10 OFF em calças e jaquetas', 'Valor Fixo', 10.00, '2025-05-10', '2025-05-17'),
(11, 'Última Chance - Blusas com 5% de desconto', 'Porcentagem', 5.00, '2025-05-11', '2025-05-14');

INSERT INTO Produto (idProduto, nome_produto, descricao, preco, tamanho, cor, marca, idCategoria)
VALUES (11, 'Regata Esportiva', 'Regata dry fit para atividades físicas', 39.90, 'M', 'Azul Marinho', 'Adidas', 1);

INSERT INTO PromocaoProduto (idPromocao, idProduto) VALUES -- essa tabela só existe pq tem um relacionamento n:m e se eu for alterar a restrição vou ter q alterar novamente todos os dados
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11);


INSERT INTO Estoque (idEstoque, idProduto, qtdEstoque, data_deEntrada, dataSaida) VALUES
(101, 1, 50, '2025-04-15', '2025-05-01'),
(203, 2, 30, '2025-04-17', '2025-05-02'),
(307, 3, 20, '2025-04-18', '2025-05-03'),
(412, 4, 40, '2025-04-19', '2025-05-04'),
(509, 5, 25, '2025-04-20', '2025-05-05'),
(611, 6, 35, '2025-04-21', '2025-05-06'),
(718, 7, 15, '2025-04-22', '2025-05-07'),
(820, 8, 45, '2025-04-23', '2025-05-08'),
(934, 9, 10, '2025-04-24', '2025-05-09'),
(1007, 10, 60, '2025-04-25', '2025-05-10'),
(1113, 11, 55, '2025-04-26', '2025-05-11');

INSERT INTO MapeamentoPromocao (idAntigo, idNovo) VALUES
(1, 1001),
(2, 1003),
(3, 1005),
(4, 1010),
(5, 1020),
(6, 1030),
(7, 1040),
(8, 1050),
(9, 1060),
(10, 1070),
(11, 1080);