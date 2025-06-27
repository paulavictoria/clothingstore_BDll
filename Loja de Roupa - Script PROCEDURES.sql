-- PROCEDURE 1


drop procedure if exists AtualizarStatusEntregaVenda;

DELIMITER $$

CREATE PROCEDURE AtualizarStatusEntregaVenda(
    IN p_idVenda INT,
    IN p_novoStatus VARCHAR(50)
)
BEGIN
    DECLARE v_vendaExiste INT;
    DECLARE v_observacoesExistente VARCHAR(255);

    -- 1. Verifica se a venda existe
    SELECT COUNT(*) INTO v_vendaExiste
    FROM Venda
    WHERE idVenda = p_idVenda;

    IF v_vendaExiste > 0 THEN
        -- 2. Atualiza o status da entrega
        UPDATE Venda
        SET statusEntrega = p_novoStatus
        WHERE idVenda = p_idVenda;

        -- 3. Verifica se o status é 'Entregue' e se não há observações para adicionar uma padrão
        IF p_novoStatus = 'Entregue' THEN
            SELECT observacoes INTO v_observacoesExistente
            FROM Venda
            WHERE idVenda = p_idVenda;

            IF v_observacoesExistente IS NULL OR v_observacoesExistente = '' THEN
                UPDATE Venda
                SET observacoes = CONCAT(IFNULL(observacoes, ''), ' Produto entregue com sucesso.')
                WHERE idVenda = p_idVenda;
            END IF;
        END IF;

        -- 4. Seleciona o registro atualizado para confirmação
        SELECT 'Status de entrega atualizado com sucesso.' AS Mensagem,
               idVenda, dataVenda, statusEntrega, observacoes
        FROM Venda
        WHERE idVenda = p_idVenda;
    ELSE
        -- Retorna mensagem se a venda não for encontrada
        SELECT 'Erro: Venda não encontrada.' AS Mensagem, NULL AS idVenda, NULL AS dataVenda, NULL AS statusEntrega, NULL AS observacoes;
    END IF;
END $$

DELIMITER ;

-- PROCEDURE 2

drop procedure if exists AdicionarProdutoNovaPromocao;

DELIMITER $$

CREATE PROCEDURE AdicionarProdutoNovaPromocao(
    IN p_descricaoPromocao VARCHAR(255),
    IN p_tipoDesconto VARCHAR(15),
    IN p_valorDesconto DECIMAL(6,2),
    IN p_dataInicio DATE,
    IN p_dataFim DATE,
    IN p_idProduto INT
)
BEGIN
    DECLARE v_idNovaPromocao INT;
    DECLARE v_produtoExiste INT;
    DECLARE v_promocaoAtivaConflitante INT;

    -- 1. Verifica se o produto existe
    SELECT COUNT(*) INTO v_produtoExiste
    FROM Produto
    WHERE idProduto = p_idProduto;

    IF v_produtoExiste = 0 THEN
        SELECT 'Erro: Produto não encontrado.' AS Mensagem;
    ELSE
        -- 2. Verifica se o produto já tem uma promoção ativa conflitante no período
        SELECT COUNT(pp.idProduto) INTO v_promocaoAtivaConflitante
        FROM PromocaoProduto pp
        JOIN Promoção pr ON pp.idPromocao = pr.idPromocao
        WHERE pp.idProduto = p_idProduto
          AND pr.dataInicio <= p_dataFim AND pr.dataFim >= p_dataInicio;

        IF v_promocaoAtivaConflitante > 0 THEN
            SELECT 'Alerta: Este produto já possui uma promoção ativa no período especificado. Nova promoção não foi adicionada.' AS Mensagem;
        ELSE
            -- 3. Insere a nova promoção (gerando um novo ID)
            SELECT IFNULL(MAX(idPromocao), 0) + 1 INTO v_idNovaPromocao FROM Promoção;
            INSERT INTO Promoção (idPromocao, descricao, tipoDesconto, valorDesconto, dataInicio, dataFim)
            VALUES (v_idNovaPromocao, p_descricaoPromocao, p_tipoDesconto, p_valorDesconto, p_dataInicio, p_dataFim);

            -- 4. Associa o produto à nova promoção
            INSERT INTO PromocaoProduto (idPromocao, idProduto)
            VALUES (v_idNovaPromocao, p_idProduto);

            SELECT CONCAT('Nova promoção (ID: ', v_idNovaPromocao, ') criada e produto ', p_idProduto, ' associado com sucesso!') AS Mensagem;
        END IF;
    END IF;
END $$

DELIMITER ;

-- PROCEDURE 3 

drop procedure if exists ConsultarHistoricoComprasCliente;

DELIMITER $$

CREATE PROCEDURE ConsultarHistoricoComprasCliente(
    IN p_cpfCliente VARCHAR(14)
)
BEGIN
    DECLARE v_totalCompras INT;

    -- 1. Conta o número de compras do cliente
    SELECT COUNT(*) INTO v_totalCompras
    FROM Venda
    WHERE cpf_cliente = p_cpfCliente;

    IF v_totalCompras > 0 THEN
        -- 2. Seleciona o histórico de compras detalhado
        SELECT
            v.idVenda,
            v.dataVenda,
            v.valorTotal AS ValorTotalVenda,
            p.nome_produto,
            ivp.quantidade,
            ivp.precoUnitario,
            (ivp.quantidade * ivp.precoUnitario) AS SubtotalItem,
            pr.descricao AS PromocaoAplicada,
            pr.valorDesconto,
            pr.tipoDesconto
        FROM
            Venda v
        JOIN
            ItemVendaProduto ivp ON v.idVenda = ivp.idVenda
        JOIN
            Produto p ON ivp.idProduto = p.idProduto
        LEFT JOIN -- LEFT JOIN para incluir itens sem promoção
            PromocaoProduto pp ON p.idProduto = pp.idProduto
        LEFT JOIN
            Promoção pr ON pp.idPromocao = pr.idPromocao AND v.dataVenda BETWEEN pr.dataInicio AND pr.dataFim
        WHERE
            v.cpf_cliente = p_cpfCliente
        ORDER BY
            v.dataVenda DESC, v.idVenda, p.nome_produto;
    ELSE
        -- 3. Retorna mensagem se o cliente não tiver compras
        SELECT 'Este cliente não possui histórico de compras ou não foi encontrado.' AS Mensagem;
    END IF;
END $$

DELIMITER ;


-- PROCEDURE 4 

drop procedure if exists GerarRelatorioEstoqueBaixo;

DELIMITER $$

CREATE PROCEDURE GerarRelatorioEstoqueBaixo(
    IN p_limiteEstoque INT
)
BEGIN
    DECLARE v_countEstoqueBaixo INT;

    -- 1. Conta quantos produtos estão com estoque abaixo do limite
    SELECT COUNT(*) INTO v_countEstoqueBaixo
    FROM Estoque
    WHERE qtdEstoque < p_limiteEstoque;

    IF v_countEstoqueBaixo > 0 THEN
        -- 2. Seleciona os produtos com estoque baixo
        SELECT
            p.nome_produto,
            p.marca,
            c.nome_categoria,
            e.qtdEstoque,
            f.nome AS FornecedorPrincipal -- Considerando que FornecedorProduto é N:N, aqui pega o primeiro associado
        FROM
            Produto p
        JOIN
            Estoque e ON p.idProduto = e.idProduto
        JOIN
            Categoria c ON p.idCategoria = c.idCategoria
        LEFT JOIN -- LEFT JOIN para produtos que podem não ter fornecedor associado
            FornecedorProduto fp ON p.idProduto = fp.idProduto
        LEFT JOIN
            Fornecedor f ON fp.idFornecedor = f.idFornecedor
        WHERE
            e.qtdEstoque < p_limiteEstoque
        ORDER BY
            e.qtdEstoque ASC, p.nome_produto;
    ELSE
        -- 3. Retorna mensagem se não houver produtos com estoque baixo
        SELECT 'Nenhum produto com estoque abaixo do limite especificado.' AS Mensagem;
    END IF;
END $$

DELIMITER ;


-- PROCEDURE 5 


drop procedure if exists RemoverVendasAntigas;

DELIMITER $$

CREATE PROCEDURE RemoverVendasAntigas(
    IN p_dataLimite DATE
)
BEGIN
    DECLARE v_vendasDeletadas INT DEFAULT 0;
    DECLARE v_itensDeletados INT DEFAULT 0;

    -- 1. Conta os itens de venda a serem deletados (opcional, para visualização)
    SELECT COUNT(*) INTO v_itensDeletados
    FROM ItemVendaProduto ivp
    JOIN Venda v ON ivp.idVenda = v.idVenda
    WHERE v.dataVenda < p_dataLimite;

    -- 2. Deleta os itens de venda relacionados (primeiro, devido à chave estrangeira)
    DELETE ivp FROM ItemVendaProduto ivp
    JOIN Venda v ON ivp.idVenda = v.idVenda
    WHERE v.dataVenda < p_dataLimite;

    -- 3. Deleta as vendas antigas e conta quantas foram
    DELETE FROM Venda
    WHERE dataVenda < p_dataLimite;

    -- Obtém o número de vendas que foram realmente deletadas
    SET v_vendasDeletadas = ROW_COUNT();

    -- 4. Retorna a confirmação e a quantidade de registros removidos
    SELECT CONCAT('Operação concluída. ', v_vendasDeletadas, ' vendas e seus ', v_itensDeletados, ' itens relacionados foram removidos antes de ', p_dataLimite, '.') AS Mensagem;

END $$

DELIMITER ;


-- PROCEDURE 6 -- DROP PROCEDURE IF EXISTS AtualizarPrecoProdutoECalcularImpacto;

drop procedure if exists AtualizarPrecoProdutoECalcularImpacto;

DELIMITER $$



CREATE PROCEDURE AtualizarPrecoProdutoECalcularImpacto(
    IN p_idProduto INT,
    IN p_novoPreco DECIMAL(6,2),
    IN p_diasAnalise INT -- Número de dias para analisar vendas antes e depois
)
BEGIN
    DECLARE v_produtoExiste INT;
    DECLARE v_precoAntigo DECIMAL(6,2);
    DECLARE v_dataAtualizacao DATETIME;
    DECLARE v_mediaVendasAntes DECIMAL(10,2);
    DECLARE v_mediaVendasDepois DECIMAL(10,2);

    -- 1. Verifica se o produto existe e armazena o preço antigo
    -- Correção aqui: Separa a verificação de existência da obtenção do preço.
    SELECT COUNT(*) INTO v_produtoExiste
    FROM Produto
    WHERE idProduto = p_idProduto;

    IF v_produtoExiste = 0 THEN
        SELECT 'Erro: Produto não encontrado.' AS Mensagem;
    ELSE
        -- Obtém o preço antigo APENAS SE o produto existe
        SELECT preco INTO v_precoAntigo
        FROM Produto
        WHERE idProduto = p_idProduto;

        -- 2. Atualiza o preço do produto
        SET v_dataAtualizacao = NOW(); -- Marca o momento da atualização
        UPDATE Produto
        SET preco = p_novoPreco
        WHERE idProduto = p_idProduto;

        -- 3. Calcula a média de vendas (quantidade) antes da atualização de preço
        SELECT AVG(ivp.quantidade) INTO v_mediaVendasAntes
        FROM ItemVendaProduto ivp
        JOIN Venda v ON ivp.idVenda = v.idVenda
        WHERE ivp.idProduto = p_idProduto
          AND v.dataVenda < DATE(v_dataAtualizacao) -- Vendas antes do dia da atualização
          AND v.dataVenda >= DATE_SUB(DATE(v_dataAtualizacao), INTERVAL p_diasAnalise DAY); -- No período de análise

        -- 4. Calcula a média de vendas (quantidade) depois da atualização de preço (se houver vendas recentes)
        SELECT AVG(ivp.quantidade) INTO v_mediaVendasDepois
        FROM ItemVendaProduto ivp
        JOIN Venda v ON ivp.idVenda = v.idVenda
        WHERE ivp.idProduto = p_idProduto
          AND v.dataVenda >= DATE(v_dataAtualizacao) -- Vendas a partir do dia da atualização
          AND v.dataVenda <= NOW(); -- Até agora

        -- Retorna os resultados
        SELECT
            CONCAT('Preço do produto ', p_idProduto, ' atualizado de R$', v_precoAntigo, ' para R$', p_novoPreco, '.') AS MensagemAtualizacao,
            'Análise de vendas (quantidade média):' AS TituloAnalise,
            IFNULL(v_mediaVendasAntes, 0) AS MediaVendasAntes, -- Usar IFNULL para caso não haja vendas no período
            IFNULL(v_mediaVendasDepois, 0) AS MediaVendasDepois; -- Usar IFNULL para caso não haja vendas no período
    END IF;
END $$

DELIMITER ;


