-- TESTE DE PROCEDURES 1

CALL AtualizarStatusEntregaVenda(1, 'Em transporte');

UPDATE Venda SET observacoes = NULL WHERE idVenda = 2;
CALL AtualizarStatusEntregaVenda(2, 'Entregue');


-- TESTE DE PROCEDURES 2 

CALL AdicionarProdutoNovaPromocao(
    'Promoção de Verão - Camiseta',
    'Porcentagem',
    15.00,
    '2025-07-01',
    '2025-07-31',
    1
);

SELECT * FROM Promoção ORDER BY idPromocao DESC LIMIT 1;
SELECT * FROM PromocaoProduto WHERE idProduto = 1;


CALL AdicionarProdutoNovaPromocao(
    'Promoção Duplicada de Jaqueta',
    'Valor Fixo',
    20.00,
    '2025-06-20', 
    '2025-07-10',
    7
);



-- TESTE DE PROCEDURES 3


-- Teste 1: Consultar histórico de um cliente com compras

CALL ConsultarHistoricoComprasCliente('111.111.111-12'); -- Ana Paula Costante

-- Teste 2: Consultar histórico de um cliente sem compras (ou um CPF inventado)

INSERT INTO Cliente (cpf, nome, telefone, endereco, email, sexo) VALUES
('100.000.000-01', 'Novo Cliente Sem Compras', '(81) 90000-0000', 'Rua Nova, 1 - Recife/PE', 'novo.cliente@email.com', 'Masculino');
CALL ConsultarHistoricoComprasCliente('100.000.000-01');


-- TESTE DE PROCEDURES 4


CALL GerarRelatorioEstoqueBaixo(10);


CALL GerarRelatorioEstoqueBaixo(5);


-- TESTE DE PROCEDURES 5


-- Teste 1: Remover vendas anteriores a uma data específica.

SELECT COUNT(*) FROM Venda WHERE dataVenda < '2025-05-05';
SELECT COUNT(*) FROM ItemVendaProduto ivp JOIN Venda v ON ivp.idVenda = v.idVenda WHERE v.dataVenda < '2025-05-05';


CALL RemoverVendasAntigas('2025-05-05');

SELECT * FROM Venda ORDER BY idVenda;



-- TESTE DE PROCEDURES 6


CALL AtualizarPrecoProdutoECalcularImpacto(1, 55.00, 30); 


CALL AtualizarPrecoProdutoECalcularImpacto(999, 10.00, 30);

