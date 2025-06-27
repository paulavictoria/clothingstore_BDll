-- FUNCTION 1 


DROP FUNCTION IF EXISTS CalcularValorTotalVenda;

DELIMITER $$

CREATE FUNCTION CalcularValorTotalVenda(p_idVenda INT)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE v_valorTotal DECIMAL(10,2);

    SELECT SUM(quantidade * precoUnitario)
    INTO v_valorTotal
    FROM ItemVendaProduto
    WHERE idVenda = p_idVenda;

    RETURN IFNULL(v_valorTotal, 0.00);
END $$

DELIMITER ;


-- FUNCTION 2 

DROP FUNCTION IF EXISTS ObterQtdEstoqueProduto;

DELIMITER $$

CREATE FUNCTION ObterQtdEstoqueProduto(p_idProduto INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v_qtdEstoque INT;

    SELECT qtdEstoque
    INTO v_qtdEstoque
    FROM Estoque
    WHERE idProduto = p_idProduto;

    RETURN IFNULL(v_qtdEstoque, 0);
END $$

DELIMITER ;


-- FUNCTION 3 

DROP FUNCTION IF EXISTS VerificarProdutoEmPromocaoAtiva;

DELIMITER $$

CREATE FUNCTION VerificarProdutoEmPromocaoAtiva(p_idProduto INT)
RETURNS BOOLEAN
READS SQL DATA
BEGIN
    DECLARE v_emPromocao BOOLEAN DEFAULT FALSE;
    DECLARE v_dataAtual DATE;
    SET v_dataAtual = CURDATE(); -- Ou NOW() se precisar de hora também

    SELECT TRUE
    INTO v_emPromocao
    FROM PromocaoProduto pp
    JOIN Promoção pr ON pp.idPromocao = pr.idPromocao
    WHERE pp.idProduto = p_idProduto
      AND v_dataAtual BETWEEN pr.dataInicio AND pr.dataFim
    LIMIT 1; -- Apenas um resultado é suficiente para saber se está em promoção

    RETURN v_emPromocao;
END $$

DELIMITER ;


-- FUNCTION 4 

DROP FUNCTION IF EXISTS CalcularIdadeFuncionario;

DELIMITER $$

CREATE FUNCTION CalcularIdadeFuncionario(p_cpfFuncionario VARCHAR(14))
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v_dataNascimento DATE;
    DECLARE v_idade INT;

    SELECT dataNascimento
    INTO v_dataNascimento
    FROM Funcionário
    WHERE cpf = p_cpfFuncionario;

    IF v_dataNascimento IS NULL THEN
        RETURN NULL; 
    END IF;

    SET v_idade = TIMESTAMPDIFF(YEAR, v_dataNascimento, CURDATE());

    IF (MONTH(CURDATE()) < MONTH(v_dataNascimento)) OR
       (MONTH(CURDATE()) = MONTH(v_dataNascimento) AND DAY(CURDATE()) < DAY(v_dataNascimento)) THEN
        SET v_idade = v_idade - 1;
    END IF;

    RETURN v_idade;
END $$

DELIMITER ;


-- FUNCTION 5 

DROP FUNCTION IF EXISTS ObterNomeCategoriaProduto;

DELIMITER $$

CREATE FUNCTION ObterNomeCategoriaProduto(p_idProduto INT)
RETURNS VARCHAR(45)
READS SQL DATA
BEGIN
    DECLARE v_nomeCategoria VARCHAR(45);

    SELECT c.nome_categoria
    INTO v_nomeCategoria
    FROM Produto p
    JOIN Categoria c ON p.idCategoria = c.idCategoria
    WHERE p.idProduto = p_idProduto;

    RETURN v_nomeCategoria;
END $$

DELIMITER ;


-- FUNCTION 6

DROP FUNCTION IF EXISTS CalcularDescontoAplicadoItem;

DELIMITER $$

CREATE FUNCTION CalcularDescontoAplicadoItem(p_idItemVenda INT)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE v_desconto DECIMAL(10,2) DEFAULT 0.00;
    DECLARE v_precoUnitario DECIMAL(6,2);
    DECLARE v_quantidade INT;
    DECLARE v_idProduto INT;
    DECLARE v_idVenda INT;
    DECLARE v_dataVenda DATE;

    -- Obter detalhes do item de venda
    SELECT ivp.precoUnitario, ivp.quantidade, ivp.idProduto, ivp.idVenda
    INTO v_precoUnitario, v_quantidade, v_idProduto, v_idVenda
    FROM ItemVendaProduto ivp
    WHERE ivp.idItem = p_idItemVenda;

    -- Se o item de venda não existir, retorna 0
    IF v_idProduto IS NULL THEN
        RETURN 0.00;
    END IF;

    -- Obter a data da venda
    SELECT dataVenda
    INTO v_dataVenda
    FROM Venda
    WHERE idVenda = v_idVenda;

    SELECT
        CASE
            WHEN pr.tipoDesconto = 'Porcentagem' THEN (v_precoUnitario * v_quantidade) * (pr.valorDesconto / 100)
            WHEN pr.tipoDesconto = 'Valor Fixo' THEN pr.valorDesconto
            ELSE 0
        END
    INTO v_desconto
    FROM PromocaoProduto pp
    JOIN Promoção pr ON pp.idPromocao = pr.idPromocao
    WHERE pp.idProduto = v_idProduto
      AND v_dataVenda BETWEEN pr.dataInicio AND pr.dataFim
    ORDER BY pr.valorDesconto DESC 
    LIMIT 1;

    RETURN IFNULL(v_desconto, 0.00);
END $$

DELIMITER ;