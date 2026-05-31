CREATE TABLE Funcionario (
    CPF VARCHAR(11) PRIMARY KEY,
    nome_funcionario VARCHAR(100) NOT NULL,
    sexo CHAR(1) NOT NULL,
    endereco TEXT,
    salario NUMERIC(10,2) NOT NULL,
    codigo_departamento INT,
    cpf_supervisor VARCHAR(11)
);

CREATE TABLE Produto (
    codigo_produto SERIAL PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    valor_unitario NUMERIC(10,2) NOT NULL,
    estoque INT NOT NULL
);

CREATE TABLE Franquia (
    codigo_franquia SERIAL PRIMARY KEY,
    endereco TEXT NOT NULL
);

CREATE TABLE Departamento (
    codigo_depart SERIAL PRIMARY KEY,
    nome_depart VARCHAR(100) NOT NULL,
    cpf_gerente VARCHAR(11),
    data_inicio_gerente DATE
);

CREATE TABLE Projeto (
    numero_projeto SERIAL PRIMARY KEY,
    nome_projeto VARCHAR(100) NOT NULL,
    local_projeto VARCHAR(100),
    codigo_departamento INT
);

CREATE TABLE Venda (
    id_venda SERIAL PRIMARY KEY,
    valor_total NUMERIC(10,2) NOT NULL,
    codigo_franquia INT,
    cpf_funcionario VARCHAR(11),
    data_venda DATE NOT NULL
);

CREATE TABLE Item_Venda (
    id_item SERIAL PRIMARY KEY,
    id_venda INT,
    codigo_produto INT,
    quantidade INT NOT NULL
);

CREATE TABLE Trabalha_em (
    cpf_funcionario VARCHAR(11),
    numero_projeto INT,
    horas NUMERIC(5,2),

    PRIMARY KEY (cpf_funcionario, numero_projeto)
);

CREATE TABLE Dependente (
    id_dependente SERIAL PRIMARY KEY,
    nome_dependente VARCHAR(100) NOT NULL,
    sexo CHAR(1) NOT NULL,
    cpf_funcionario VARCHAR(11) NOT NULL,
    data_nascimento DATE,
    parentesco VARCHAR(50)
);

ALTER TABLE Funcionario
ADD CONSTRAINT fk_departamento
FOREIGN KEY (codigo_departamento)
REFERENCES Departamento(codigo_depart);

ALTER TABLE Funcionario
ADD CONSTRAINT fk_supervisor
FOREIGN KEY (cpf_supervisor)
REFERENCES Funcionario(CPF);

ALTER TABLE Departamento
ADD CONSTRAINT fk_gerente
FOREIGN KEY (cpf_gerente)
REFERENCES Funcionario(CPF);

ALTER TABLE Projeto
ADD CONSTRAINT fk_projeto_departamento
FOREIGN KEY (codigo_departamento)
REFERENCES Departamento(codigo_depart);

ALTER TABLE Venda
ADD CONSTRAINT fk_venda_franquia
FOREIGN KEY (codigo_franquia)
REFERENCES Franquia(codigo_franquia);

ALTER TABLE Venda
ADD CONSTRAINT fk_venda_funcionario
FOREIGN KEY (cpf_funcionario)
REFERENCES Funcionario(CPF);

ALTER TABLE Item_Venda
ADD CONSTRAINT fk_item_venda
FOREIGN KEY (id_venda)
REFERENCES Venda(id_venda);

ALTER TABLE Item_Venda
ADD CONSTRAINT fk_item_produto
FOREIGN KEY (codigo_produto)
REFERENCES Produto(codigo_produto);

ALTER TABLE Trabalha_em
ADD CONSTRAINT fk_trabalha_funcionario
FOREIGN KEY (cpf_funcionario)
REFERENCES Funcionario(CPF);

ALTER TABLE Trabalha_em
ADD CONSTRAINT fk_trabalha_projeto
FOREIGN KEY (numero_projeto)
REFERENCES Projeto(numero_projeto);

ALTER TABLE Dependente
ADD CONSTRAINT fk_dependente_funcionario
FOREIGN KEY (cpf_funcionario)
REFERENCES Funcionario(CPF);