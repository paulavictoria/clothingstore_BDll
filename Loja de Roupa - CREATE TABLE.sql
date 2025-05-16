CREATE SCHEMA IF NOT EXISTS `loja_de_roupa` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `loja_de_roupa` ;

-- -----------------------------------------------------
-- Table `loja_de_roupa`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja_de_roupa`.`categoria` (
  `idCategoria` INT NOT NULL,
  `nome_categoria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategoria`),
  UNIQUE INDEX `id_categoria_UNIQUE` (`idCategoria` ASC) VISIBLE,
  UNIQUE INDEX `nome_categoria_UNIQUE` (`nome_categoria` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `loja_de_roupa`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja_de_roupa`.`cliente` (
  `cpf` VARCHAR(14) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(15) NOT NULL,
  `endereco` VARCHAR(150) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `sexo` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`cpf`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `loja_de_roupa`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja_de_roupa`.`produto` (
  `idProduto` INT NOT NULL,
  `nome_produto` VARCHAR(60) NOT NULL,
  `descricao` VARCHAR(60) NOT NULL,
  `preco` DECIMAL(6,2) NOT NULL,
  `tamanho` VARCHAR(45) NOT NULL,
  `cor` VARCHAR(45) NOT NULL,
  `marca` VARCHAR(60) NOT NULL,
  `idCategoria` INT NOT NULL,
  PRIMARY KEY (`idProduto`),
  UNIQUE INDEX `idProduto_UNIQUE` (`idProduto` ASC) VISIBLE,
  UNIQUE INDEX `nome_produto_UNIQUE` (`nome_produto` ASC) VISIBLE,
  UNIQUE INDEX `descricao_UNIQUE` (`descricao` ASC) VISIBLE,
  INDEX `idCategoria_idx` (`idCategoria` ASC) VISIBLE,
  CONSTRAINT `idCategoria`
    FOREIGN KEY (`idCategoria`)
    REFERENCES `loja_de_roupa`.`categoria` (`idCategoria`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `loja_de_roupa`.`estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja_de_roupa`.`estoque` (
  `idEstoque` INT NOT NULL,
  `idProduto` INT NOT NULL,
  `qtdEstoque` INT NOT NULL,
  `data_deEntrada` DATE NOT NULL,
  `dataSaida` DATE NOT NULL,
  PRIMARY KEY (`idEstoque`),
  UNIQUE INDEX `idEstoque_UNIQUE` (`idEstoque` ASC) VISIBLE,
  INDEX `idProduto` (`idProduto` ASC) VISIBLE,
  CONSTRAINT `estoque_ibfk_1`
    FOREIGN KEY (`idProduto`)
    REFERENCES `loja_de_roupa`.`produto` (`idProduto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `loja_de_roupa`.`fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja_de_roupa`.`fornecedor` (
  `idFornecedor` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `telefone` VARCHAR(20) NULL DEFAULT NULL,
  `endereco` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`idFornecedor`),
  UNIQUE INDEX `idFornecedor_UNIQUE` (`idFornecedor` ASC) VISIBLE,
  UNIQUE INDEX `telefone_UNIQUE` (`telefone` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `loja_de_roupa`.`fornecedorproduto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja_de_roupa`.`fornecedorproduto` (
  `idFornecedor` INT NOT NULL,
  `idProduto` INT NOT NULL,
  PRIMARY KEY (`idFornecedor`, `idProduto`),
  UNIQUE INDEX `idFornecedor_UNIQUE` (`idFornecedor` ASC) VISIBLE,
  UNIQUE INDEX `idProduto_UNIQUE` (`idProduto` ASC) VISIBLE,
  CONSTRAINT `fornecedorproduto_ibfk_1`
    FOREIGN KEY (`idProduto`)
    REFERENCES `loja_de_roupa`.`produto` (`idProduto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `idFornecedor`
    FOREIGN KEY (`idFornecedor`)
    REFERENCES `loja_de_roupa`.`fornecedor` (`idFornecedor`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `loja_de_roupa`.`funcionário`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja_de_roupa`.`funcionário` (
  `cpf` VARCHAR(14) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `cargo` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(15) NOT NULL,
  `endereco` VARCHAR(150) NOT NULL,
  `dataNascimento` DATE NULL DEFAULT NULL,
  `email` VARCHAR(50) NULL DEFAULT NULL,
  `sexo` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`cpf`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE,
  UNIQUE INDEX `telefone_UNIQUE` (`telefone` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `loja_de_roupa`.`venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja_de_roupa`.`venda` (
  `idVenda` INT NOT NULL,
  `dataVenda` DATE NOT NULL,
  `valorTotal` DECIMAL(6,2) NOT NULL,
  `descontoTotal` DECIMAL(6,2) NOT NULL,
  `formaPagamento` VARCHAR(50) NOT NULL,
  `statusEntrega` VARCHAR(50) NOT NULL,
  `cpf_cliente` VARCHAR(14) NOT NULL,
  `cpf_funcionario` VARCHAR(14) NOT NULL,
  `observacoes` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`idVenda`),
  UNIQUE INDEX `idVenda_UNIQUE` (`idVenda` ASC) VISIBLE,
  INDEX `Cliente_cpf_idx` (`cpf_cliente` ASC) VISIBLE,
  INDEX `Funcionario_cpf_idx` (`cpf_funcionario` ASC) VISIBLE,
  CONSTRAINT `Cliente_cpf`
    FOREIGN KEY (`cpf_cliente`)
    REFERENCES `loja_de_roupa`.`cliente` (`cpf`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Funcionario_cpf`
    FOREIGN KEY (`cpf_funcionario`)
    REFERENCES `loja_de_roupa`.`funcionário` (`cpf`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `loja_de_roupa`.`itemvendaproduto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja_de_roupa`.`itemvendaproduto` (
  `idItem` INT NOT NULL,
  `idVenda` INT NOT NULL,
  `idProduto` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `precoUnitario` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`idItem`),
  UNIQUE INDEX `idItem_UNIQUE` (`idItem` ASC) VISIBLE,
  INDEX `idVenda_idx` (`idVenda` ASC) VISIBLE,
  INDEX `idProduto_idx` (`idProduto` ASC) VISIBLE,
  CONSTRAINT `idProduto`
    FOREIGN KEY (`idProduto`)
    REFERENCES `loja_de_roupa`.`produto` (`idProduto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `idVenda`
    FOREIGN KEY (`idVenda`)
    REFERENCES `loja_de_roupa`.`venda` (`idVenda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `loja_de_roupa`.`promoção`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja_de_roupa`.`promoção` (
  `idPromocao` INT NOT NULL,
  `descricao` VARCHAR(255) NULL DEFAULT NULL,
  `tipoDesconto` VARCHAR(15) NOT NULL,
  `valorDesconto` DECIMAL(6,2) NOT NULL,
  `dataInicio` DATE NOT NULL,
  `dataFim` DATE NOT NULL,
  PRIMARY KEY (`idPromocao`),
  UNIQUE INDEX `idPromocao_UNIQUE` (`idPromocao` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `loja_de_roupa`.`promocaoproduto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja_de_roupa`.`promocaoproduto` (
  `idPromocao` INT NOT NULL,
  `idProduto` INT NOT NULL,
  PRIMARY KEY (`idPromocao`, `idProduto`),
  UNIQUE INDEX `idPromocao_UNIQUE` (`idPromocao` ASC) VISIBLE,
  UNIQUE INDEX `idProduto_UNIQUE` (`idProduto` ASC) VISIBLE,
  CONSTRAINT `idPromocao`
    FOREIGN KEY (`idPromocao`)
    REFERENCES `loja_de_roupa`.`promoção` (`idPromocao`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `promocaoproduto_ibfk_1`
    FOREIGN KEY (`idProduto`)
    REFERENCES `loja_de_roupa`.`produto` (`idProduto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `loja_de_roupa` ;
