use loja_de_roupa;

-- TRIGGER 1

DROP TRIGGER IF EXISTS trg_AtualizarEstoqueAposVenda;

DELIMITER $$

CREATE TRIGGER trg_AtualizarEstoqueAposVenda
AFTER INSERT ON ItemVendaProduto
FOR EACH ROW
BEGIN
    UPDATE Estoque
    SET qtdEstoque = qtdEstoque - NEW.quantidade
    WHERE idProduto = NEW.idProduto;
END $$

DELIMITER ;


-- TRIGGER 2


DROP TRIGGER IF EXISTS trg_PrevenirEstoqueNegativo;
DROP TRIGGER IF EXISTS trg_PrevenirEstoqueNegativoVenda;

DELIMITER $$

CREATE TRIGGER trg_PrevenirEstoqueNegativo
BEFORE UPDATE ON Estoque
FOR EACH ROW
BEGIN
    -- Verifica se a nova quantidade de estoque é negativa
    IF NEW.qtdEstoque < 0 THEN
        -- Sinaliza um erro para abortar a operação
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Quantidade em estoque não pode ser negativa.';
    END IF;
END $$

CREATE TRIGGER trg_PrevenirEstoqueNegativoVenda
BEFORE INSERT ON ItemVendaProduto
FOR EACH ROW
BEGIN
    DECLARE v_estoqueAtual INT;
    SELECT qtdEstoque INTO v_estoqueAtual
    FROM Estoque
    WHERE idProduto = NEW.idProduto;

    IF v_estoqueAtual < NEW.quantidade THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Quantidade solicitada excede o estoque disponível para este produto.';
    END IF;
END $$

DELIMITER ;


-- TRIGGER 3

DROP TRIGGER IF EXISTS trg_ValidarDataPromocao;
DROP TRIGGER IF EXISTS trg_ValidarDataPromocaoUpdate;

DELIMITER $$


CREATE TRIGGER trg_ValidarDataPromocao
BEFORE INSERT ON Promoção
FOR EACH ROW
BEGIN
    IF NEW.dataFim < NEW.dataInicio THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: A data final da promoção não pode ser anterior à data de início.';
    END IF;
END $$


CREATE TRIGGER trg_ValidarDataPromocaoUpdate
BEFORE UPDATE ON Promoção
FOR EACH ROW
BEGIN
    IF NEW.dataFim < NEW.dataInicio THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: A data final da promoção não pode ser anterior à data de início.';
    END IF;
END $$

DELIMITER ;



-- TRIGGER 4

DROP TRIGGER IF EXISTS trg_RegistrarNovoCliente;


CREATE TABLE IF NOT EXISTS LogNovoCliente (
    idLog INT AUTO_INCREMENT PRIMARY KEY,
    cpfCliente VARCHAR(14) NOT NULL,
    nomeCliente VARCHAR(45),
    dataHoraCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$



CREATE TRIGGER trg_RegistrarNovoCliente
AFTER INSERT ON Cliente
FOR EACH ROW
BEGIN
    INSERT INTO LogNovoCliente (cpfCliente, nomeCliente)
    VALUES (NEW.cpf, NEW.nome);
END $$

DELIMITER ;


-- TRIGGER 5 

DROP TRIGGER IF EXISTS trg_AtualizarValorTotalVenda_AI;
DROP TRIGGER IF EXISTS trg_AtualizarValorTotalVenda_AD;
DROP TRIGGER IF EXISTS trg_AtualizarValorTotalVenda_AU;

DELIMITER $$


CREATE TRIGGER trg_AtualizarValorTotalVenda_AI
AFTER INSERT ON ItemVendaProduto
FOR EACH ROW
BEGIN
    UPDATE Venda
    SET valorTotal = (SELECT SUM(quantidade * precoUnitario) FROM ItemVendaProduto WHERE idVenda = NEW.idVenda)
    WHERE idVenda = NEW.idVenda;
END $$



CREATE TRIGGER trg_AtualizarValorTotalVenda_AU
AFTER UPDATE ON ItemVendaProduto
FOR EACH ROW
BEGIN
    UPDATE Venda
    SET valorTotal = (SELECT SUM(quantidade * precoUnitario) FROM ItemVendaProduto WHERE idVenda = NEW.idVenda)
    WHERE idVenda = NEW.idVenda;
END $$



CREATE TRIGGER trg_AtualizarValorTotalVenda_AD
AFTER DELETE ON ItemVendaProduto
FOR EACH ROW
BEGIN
    UPDATE Venda
    SET valorTotal = (SELECT IFNULL(SUM(quantidade * precoUnitario), 0) FROM ItemVendaProduto WHERE idVenda = OLD.idVenda)
    WHERE idVenda = OLD.idVenda;
END $$

DELIMITER ;


-- TRIGGER 6 

DROP TRIGGER IF EXISTS trg_AuditarAtualizacaoPrecoProduto;


CREATE TABLE IF NOT EXISTS LogPrecoProduto (
    idLog INT AUTO_INCREMENT PRIMARY KEY,
    idProduto INT NOT NULL,
    nome_produto VARCHAR(60),
    precoAntigo DECIMAL(6,2),
    precoNovo DECIMAL(6,2),
    dataHoraAlteracao DATETIME DEFAULT CURRENT_TIMESTAMP,
    -- ALTERAÇÃO AQUI: Removido o "DEFAULT USER()"
    usuarioAlteracao VARCHAR(100)
);

-- Agora, o script da trigger (que já está correto em relação a essa parte, pois não usava USER() lá)
DELIMITER $$



CREATE TRIGGER trg_AuditarAtualizacaoPrecoProduto
AFTER UPDATE ON Produto
FOR EACH ROW
BEGIN
    -- Se o preço realmente mudou
    IF OLD.preco <> NEW.preco THEN
        INSERT INTO LogPrecoProduto (idProduto, nome_produto, precoAntigo, precoNovo, usuarioAlteracao)
        VALUES (NEW.idProduto, NEW.nome_produto, OLD.preco, NEW.preco, CURRENT_USER()); -- Usando CURRENT_USER() dentro do INSERT
    END IF;
END $$

DELIMITER ;