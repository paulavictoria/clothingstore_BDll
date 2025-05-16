UPDATE Cliente SET email = 'ana.silva@email.com', sexo = 'Feminino' WHERE cpf = '111.111.111-11';
UPDATE Cliente SET email = 'bruno.costa@email.com', sexo = 'Masculino' WHERE cpf = '222.222.222-22';
UPDATE Cliente SET email = 'carla.lima@email.com', sexo = 'Feminino' WHERE cpf = '333.333.333-33';
UPDATE Cliente SET email = 'daniel.melo@email.com', sexo = 'Masculino' WHERE cpf = '444.444.444-44';
UPDATE Cliente SET email = 'eduarda.gomes@email.com', sexo = 'Feminino' WHERE cpf = '555.555.555-55';
UPDATE Cliente SET email = 'fernando.barros@email.com', sexo = 'Masculino' WHERE cpf = '666.666.666-66';
UPDATE Cliente SET email = 'gabriela.nunes@email.com', sexo = 'Feminino' WHERE cpf = '777.777.777-77';
UPDATE Cliente SET email = 'hugo.andrade@email.com', sexo = 'Masculino' WHERE cpf = '888.888.888-88';
UPDATE Cliente SET email = 'isabela.castro@email.com', sexo = 'Feminino' WHERE cpf = '999.999.999-99';
UPDATE Cliente SET email = 'joao.marques@email.com', sexo = 'Masculino' WHERE cpf = '123.456.789-00';

UPDATE Cliente SET email = 'joao.marques@gmail.com', sexo = 'Masculino' WHERE cpf = '000.000.000-00';

UPDATE Funcionário SET dataNascimento = '1990-05-15' WHERE cpf = '111.111.111-11';
UPDATE Funcionário SET dataNascimento = '1988-07-22' WHERE cpf = '222.222.222-22';
UPDATE Funcionário SET dataNascimento = '1985-03-10' WHERE cpf = '333.333.333-33';
UPDATE Funcionário SET dataNascimento = '1992-11-05' WHERE cpf = '444.444.444-44';
UPDATE Funcionário SET dataNascimento = '1994-01-30' WHERE cpf = '555.555.555-55';
UPDATE Funcionário SET dataNascimento = '1990-06-18' WHERE cpf = '666.666.666-66';
UPDATE Funcionário SET dataNascimento = '1989-04-12' WHERE cpf = '777.777.777-77';
UPDATE Funcionário SET dataNascimento = '1987-09-25' WHERE cpf = '888.888.888-88';
UPDATE Funcionário SET dataNascimento = '1991-02-20' WHERE cpf = '999.999.999-99';
UPDATE Funcionário SET dataNascimento = '1983-08-17' WHERE cpf = '123.456.789-00';


UPDATE Funcionário SET cpf = '991.878.742-35' where cpf = '111.111.111-11';
UPDATE Funcionário SET cpf = '914.778.512-25' where cpf = '222.222.222-22';
UPDATE Funcionário SET cpf = '789.478.123-04' where cpf = '333.333.333-33';
UPDATE Funcionário SET cpf = '987.555.211-11' where cpf = '444.444.444-44';
UPDATE Funcionário SET cpf = '121.845.541-54' where cpf = '555.555.555-55';
UPDATE Funcionário SET cpf = '913.878.442-10' where cpf = '666.666.666-66';
UPDATE Funcionário SET cpf = '119.986.125-14' where cpf = '777.777.777-77';
UPDATE Funcionário SET cpf = '117.115.714-01' where cpf = '888.888.888-88';
UPDATE Funcionário SET cpf = '351.192.129-02' where cpf = '999.999.999-99';
UPDATE Funcionário SET cpf = '128.114.742-15' where cpf = '123.456.789-00';

UPDATE Venda SET observacoes = 'Cliente pediu embalagem para presente.' WHERE idVenda = 1;
UPDATE Venda SET observacoes = 'Entrega agendada para o próximo sábado.' WHERE idVenda = 2;
UPDATE Venda SET observacoes = 'Cliente utilizou cupom de desconto especial.' WHERE idVenda = 3;
UPDATE Venda SET observacoes = 'Endereço de entrega alterado pelo cliente.' WHERE idVenda = 4;
UPDATE Venda SET observacoes = 'Venda cancelada por solicitação do cliente.' WHERE idVenda = 5;
UPDATE Venda SET observacoes = 'Cliente frequente – oferecer programa de fidelidade.' WHERE idVenda = 6;
UPDATE Venda SET observacoes = 'Produto com embalagem danificada, cliente aceitou mesmo assim.' WHERE idVenda = 7;
UPDATE Venda SET observacoes = 'Pagamento confirmado após 2ª tentativa.' WHERE idVenda = 8;
UPDATE Venda SET observacoes = 'Cliente solicitou troca de cor, mas item não disponível.' WHERE idVenda = 9;
UPDATE Venda SET observacoes = 'Entrega feita com sucesso e confirmada por telefone.' WHERE idVenda = 10;


UPDATE PromocaoProduto pp
JOIN MapeamentoPromocao mp ON pp.idPromocao = mp.idAntigo
SET pp.idPromocao = mp.idNovo;

UPDATE Promoção p
JOIN MapeamentoPromocao mp ON p.idPromocao = mp.idAntigo
SET p.idPromocao = mp.idNovo;

DROP TEMPORARY TABLE MapeamentoPromocao;

SET FOREIGN_KEY_CHECKS = 1;


update Cliente
	set nome = "Diego Henrique da Silva"
		where cpf = "888.888.888-88";

update Cliente
	set cpf = "132.321.331-11"
		where cpf = "000.000.000-00";