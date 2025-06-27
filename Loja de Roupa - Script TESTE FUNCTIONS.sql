-- TESTE FUNCTION 1

-- Teste 1: Calcular o valor total de uma venda existente (idVenda = 1)
SELECT CalcularValorTotalVenda(1) AS ValorTotalVenda1;

-- Teste 2: Usar a função em uma consulta para listar todas as vendas com seus totais calculados
SELECT
    idVenda,
    dataVenda,
    valorTotal AS ValorRegistrado,
    CalcularValorTotalVenda(idVenda) AS ValorCalculadoPelaFuncao
FROM
    Venda
LIMIT 5;


-- TESTE FUNCTION 2


-- Teste 1: Obter a quantidade em estoque do Produto 1 (Camiseta Básica Branca)
SELECT ObterQtdEstoqueProduto(1) AS EstoqueProduto1;

-- Teste 2: Usar a função em uma consulta para listar produtos e seus estoques
SELECT
    nome_produto,
    ObterQtdEstoqueProduto(idProduto) AS EstoqueAtual
FROM
    Produto
ORDER BY
    EstoqueAtual ASC
LIMIT 5;



-- TESTE FUNCTION 3

-- Teste 1: Verificar se o Produto 7 (Jaqueta Jeans Oversized) está em promoção ativa (deve ser TRUE)
SELECT VerificarProdutoEmPromocaoAtiva(7) AS Produto7EmPromocao;

-- Teste 2: Usar a função em uma consulta para listar todos os produtos e indicar se estão em promoção
SELECT
    idProduto,
    nome_produto,
    VerificarProdutoEmPromocaoAtiva(idProduto) AS EmPromocaoAtiva
FROM
    Produto
LIMIT 5;




-- TESTE FUNCTION 4


-- Teste 1: Calcular a idade do funcionário com CPF '991.878.742-35' (Carlos Eduardo Santos, nascido em 1990-05-15)
SELECT CalcularIdadeFuncionario('991.878.742-35') AS IdadeCarlos;

-- Teste 2: Usar a função em uma consulta para listar funcionários e suas idades
SELECT
    nome,
    cargo,
    CalcularIdadeFuncionario(cpf) AS Idade
FROM
    Funcionário
ORDER BY
    Idade DESC
LIMIT 5;


-- TESTE FUNCTION 5


-- Teste 1: Obter o nome da categoria do Produto 1 (Camiseta Básica Branca)
SELECT ObterNomeCategoriaProduto(1) AS CategoriaProduto1;

-- Teste 2: Obter o nome da categoria do Produto 2 (Calça Jeans Slim)
SELECT ObterNomeCategoriaProduto(2) AS CategoriaProduto2;

-- Teste 3: Usar a função em uma consulta para listar produtos e suas categorias
SELECT
    p.nome_produto,
    ObterNomeCategoriaProduto(p.idProduto) AS NomeCategoria
FROM
    Produto p
LIMIT 5;



-- TESTE FUNCTION 6


-- Teste 1: Usar a função em uma consulta para listar itens de venda e o desconto aplicado a cada um
SELECT
    ivp.idItem,
    ivp.idVenda,
    p.nome_produto,
    ivp.precoUnitario,
    ivp.quantidade,
    CalcularDescontoAplicadoItem(ivp.idItem) AS DescontoAplicado
FROM
    ItemVendaProduto ivp
JOIN
    Produto p ON ivp.idProduto = p.idProduto
LIMIT 5;
