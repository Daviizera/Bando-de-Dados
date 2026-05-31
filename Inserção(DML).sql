INSERT INTO Departamento (
    codigo_depart,
    nome_depart
)
VALUES
(1, 'Vendas'),
(2, 'Estoque'),
(3, 'Financeiro'),
(4, 'RH');

INSERT INTO Funcionario (
    CPF,
    nome_funcionario,
    sexo,
    endereco,
    salario,
    codigo_departamento,
    cpf_supervisor
) VALUES
('12345678901','José Silva','M','Rua das Flores, 123 - São Paulo, SP',9800.00,1,NULL),

('12345678902','Maria Santos','F','Avenida Brasil, 456 - Rio de Janeiro, RJ',10500.00,1,'12345678901'),

('12345678903','Pedro Oliveira','M','Praça Central, 789 - Belo Horizonte, MG',8200.00,1,'12345678901'),

('12345678904','Ana Costa','F','Rua Nova, 321 - Curitiba, PR',7000.00,1,'12345678902'),

('12345678905','Carlos Souza','M','Avenida Paulista, 1000 - São Paulo, SP',7600.00,1,'12345678903'),

('12345678906','Juliana Lima','F','Rua das Flores, 123 - São Paulo, SP',8900.00,1,NULL),

('12345678907','Roberto Alves','M','Avenida Brasil, 456 - Rio de Janeiro, RJ',4800.00,1,NULL),

('12345678908','Fernanda Rodrigues','F','Praça Central, 789 - Belo Horizonte, MG',5100.00,2,NULL),

('12345678909','Marcos Pereira','M','Rua Nova, 321 - Curitiba, PR',4500.00,3,NULL),

('12345678910','Luciana Ferreira','F','Avenida Paulista, 1000 - São Paulo, SP',6000.00,4,NULL);

INSERT INTO Produto (
    nome_produto,
    valor_unitario,
    estoque
)
VALUES
('Notebook Dell',3500.00,15),
('Mouse Gamer',150.00,80),
('Teclado Mecânico',320.00,40),
('Monitor 24"',950.00,25),
('Headset',280.00,50),
('SSD 1TB',450.00,35),
('Memória RAM 16GB',290.00,60),
('Webcam HD',180.00,30);

INSERT INTO Franquia (
    endereco
)
VALUES
('São Paulo - Centro'),
('Rio de Janeiro - Barra'),
('Belo Horizonte - Savassi'),
('Curitiba - Centro'),
('João Pessoa - Manaíra');

INSERT INTO Projeto (
    nome_projeto,
    local_projeto,
    codigo_departamento
)
VALUES
('Sistema de Vendas', 'São Paulo', 1),
('Controle de Estoque', 'Rio de Janeiro', 2),
('ERP Financeiro', 'Belo Horizonte', 3),
('Portal RH', 'Curitiba', 4);

INSERT INTO Trabalha_em (
    cpf_funcionario,
    numero_projeto,
    horas
)
VALUES
('12345678901',6,40),
('12345678902',6,35),

('12345678903',7,30),
('12345678904',7,25),

('12345678905',8,40),
('12345678906',8,38),

('12345678907',9,20),
('12345678908',9,25),

('12345678909',9,40),
('12345678910',9,30);

INSERT INTO Dependente (
    nome_dependente,
    sexo,
    cpf_funcionario,
    data_nascimento,
    parentesco
)
VALUES
('Lucas Silva','M','12345678901','2012-05-10','Filho'),
('Ana Clara','F','12345678902','2015-08-12','Filha'),
('João Pedro','M','12345678903','2014-03-21','Filho'),
('Mariana Costa','F','12345678904','2018-07-02','Filha'),
('Gabriel Souza','M','12345678905','2016-11-30','Filho');

INSERT INTO Venda (
    valor_total,
    codigo_franquia,
    cpf_funcionario,
    data_venda
)
VALUES
(3650.00,1,'12345678901','2026-01-10'),
(1100.00,2,'12345678902','2026-01-15'),
(4700.00,3,'12345678903','2026-02-01'),
(900.00,4,'12345678904','2026-02-10');

INSERT INTO Item_Venda (
    id_venda,
    codigo_produto,
    quantidade
)
VALUES
(1,1,1),
(1,2,1),

(2,3,2),

(3,1,1),
(3,6,2),

(4,4,1);

