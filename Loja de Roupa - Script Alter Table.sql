-- ALTER TABLES DO BANCO

ALTER TABLE Cliente
DROP COLUMN email;

-- adicionar coluna email na tabela de cliente
ALTER TABLE Cliente
ADD COLUMN email VARCHAR(50) NOT NULL;

ALTER TABLE Cliente
DROP COLUMN sexo;

-- adicionar nova coluna 'sexo' à tabela Cliente
ALTER TABLE Cliente
ADD COLUMN sexo CHAR(1) NOT NULL;

-- alterar char sexo
ALTER TABLE Cliente
modify COLUMN sexo varchar(20) not null;

-- adicionar coluna 'dataNascimento' na tabela funcionario
ALTER TABLE Funcionário
ADD COLUMN dataNascimento DATE;

-- alterar tipo da coluna 'telefone' em Fornecedor (de VARCHAR(15) para VARCHAR(20))
ALTER TABLE Fornecedor
MODIFY COLUMN telefone VARCHAR(20);

-- alterar o tamanho da coluna 'marca' na tabela Produto (de VARCHAR(45) para VARCHAR(60))
ALTER TABLE Produto
MODIFY COLUMN marca VARCHAR(60) NOT NULL;

-- adicionar nova coluna 'observacoes' à tabela Venda
ALTER TABLE Venda
ADD COLUMN observacoes TEXT;

-- adicionar restrição de CHECK para garantir que precoUnitario > 0 na tabela ItemVendaProduto
ALTER TABLE ItemVendaProduto
ADD CONSTRAINT chk_preco_positivo CHECK (precoUnitario > 0);

ALTER TABLE Venda
ADD COLUMN situacao VARCHAR(20) DEFAULT 'PENDENTE';

ALTER TABLE Estoque
CHANGE COLUMN quantidade qtdEstoque INT NOT NULL;

ALTER TABLE Estoque
CHANGE COLUMN dataEntrada data_deEntrada DATE NOT NULL;

ALTER TABLE Cliente DROP CONSTRAINT telefone_UNIQUE;

ALTER TABLE funcionário
ADD COLUMN email varchar(50);

ALTER TABLE funcionário
ADD COLUMN sexo varchar(20);

ALTER TABLE venda
MODIFY COLUMN observacoes varchar(255); 

ALTER TABLE venda
DROP COLUMN situacao; 

ALTER TABLE promoção
MODIFY COLUMN descricao varchar(255);