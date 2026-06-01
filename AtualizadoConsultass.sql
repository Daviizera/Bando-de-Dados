SELECT COUNT(*) FROM Departamento;
SELECT COUNT(*) FROM Funcionario;
SELECT COUNT(*) FROM Produto;
SELECT COUNT(*) FROM Franquia;
SELECT COUNT(*) FROM Projeto;
SELECT COUNT(*) FROM Trabalha_em;
SELECT COUNT(*) FROM Dependente;
SELECT COUNT(*) FROM Venda;
SELECT COUNT(*) FROM Item_Venda;


-- FUNÇÃO: Quanto a empresa gasta com salários em determinado departamento?
CREATE OR REPLACE FUNCTION folha_departamento(
    p_departamento INT
)
RETURNS NUMERIC
AS $$
DECLARE
    total NUMERIC;
BEGIN

    SELECT SUM(salario)
    INTO total
    FROM Funcionario
    WHERE codigo_departamento = p_departamento;

    RETURN total;

END;
$$ LANGUAGE plpgsql;


-- Query-01:
SELECT folha_departamento(1);
SELECT folha_departamento(2);
SELECT folha_departamento(3);
SELECT folha_departamento(4);


-- FUNÇÃO: Quantidade de funcionários por departamento
CREATE OR REPLACE FUNCTION qtd_funcionarios_departamento(
    p_departamento INT
)
RETURNS INTEGER
AS $$
DECLARE
    total INTEGER;
BEGIN

    SELECT COUNT(*)
    INTO total
    FROM Funcionario
    WHERE codigo_departamento = p_departamento;

    RETURN total;

END;
$$ LANGUAGE plpgsql;


-- Query-02:
SELECT qtd_funcionarios_departamento(1);
SELECT qtd_funcionarios_departamento(2);
SELECT qtd_funcionarios_departamento(3);
SELECT qtd_funcionarios_departamento(4);


-- FUNÇÃO: Quanto dinheiro está parado no estoque?
CREATE OR REPLACE FUNCTION valor_total_estoque()
RETURNS NUMERIC
AS $$
DECLARE
    total NUMERIC;
BEGIN

    SELECT SUM(
        valor_unitario * estoque
    )
    INTO total
    FROM Produto;

    RETURN total;

END;
$$ LANGUAGE plpgsql;


-- Query-03:
SELECT valor_total_estoque();


-- PROCEDURES: Reajuste salarial
CREATE OR REPLACE PROCEDURE reajustar_salario(
    p_cpf VARCHAR(11),
    p_percentual NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN

    UPDATE Funcionario
    SET salario =
        salario * (1 + p_percentual/100)
    WHERE cpf = p_cpf;

END;
$$;


-- Executar 1:
CALL reajustar_salario(
    '12345678901',
    5
);


-- PROCEDURES: Transferir funcionário:
CREATE OR REPLACE PROCEDURE transferir_funcionario(
    p_cpf VARCHAR(11),
    p_departamento INT
)
LANGUAGE plpgsql
AS $$
BEGIN

    UPDATE Funcionario
    SET codigo_departamento =
        p_departamento
    WHERE cpf = p_cpf;

END;
$$;


-- Executar 2:
CALL transferir_funcionario(
    '12345678904',
    3
);


-- PROCEDURE: Aumentar estoque
CREATE OR REPLACE PROCEDURE repor_estoque(
    p_produto INT,
    p_quantidade INT
)
LANGUAGE plpgsql
AS $$
BEGIN

    UPDATE Produto
    SET estoque =
        estoque + p_quantidade
    WHERE codigo_produto =
        p_produto;

END;
$$;

-- Executar 3:
CALL repor_estoque(
    1,
    20
);


-- TRIGGERS: função: Impedir estoque negativo (Se alguém vender mais do que existe).
CREATE OR REPLACE FUNCTION validar_estoque()
RETURNS TRIGGER
AS $$
DECLARE
    estoque_atual INT;
BEGIN

    SELECT estoque
    INTO estoque_atual
    FROM Produto
    WHERE codigo_produto =
        NEW.codigo_produto;

    IF estoque_atual < NEW.quantidade THEN
        RAISE EXCEPTION
        'Estoque insuficiente';
    END IF;

    RETURN NEW;

END;
$$ LANGUAGE plpgsql;


--Trigger 1:
CREATE TRIGGER trg_validar_estoque
BEFORE INSERT
ON Item_Venda
FOR EACH ROW
EXECUTE FUNCTION validar_estoque();


-- TRIGGER — Baixar estoque automaticamente (Quando uma venda ocorrer).
CREATE OR REPLACE FUNCTION baixar_estoque()
RETURNS TRIGGER
AS $$
BEGIN

    UPDATE Produto
    SET estoque =
        estoque - NEW.quantidade
    WHERE codigo_produto =
        NEW.codigo_produto;

    RETURN NEW;

END;
$$ LANGUAGE plpgsql;


-- Trigger 2:
CREATE TRIGGER trg_baixar_estoque
AFTER INSERT
ON Item_Venda
FOR EACH ROW
EXECUTE FUNCTION baixar_estoque();

-- Trigger 3 — Registrar aumento salarial: Imagine que a empresa quer monitorar alterações de salário.

-- Primeiro:
CREATE TABLE Historico_Salario (
    id SERIAL PRIMARY KEY,
    cpf_funcionario VARCHAR(11),
    salario_antigo NUMERIC,
    salario_novo NUMERIC,
    data_alteracao TIMESTAMP
);

-- Função:
CREATE OR REPLACE FUNCTION registrar_alteracao_salario()
RETURNS TRIGGER
AS $$
BEGIN

    INSERT INTO Historico_Salario (
        cpf_funcionario,
        salario_antigo,
        salario_novo,
        data_alteracao
    )
    VALUES (
        OLD.cpf,
        OLD.salario,
        NEW.salario,
        NOW()
    );

    RETURN NEW;

END;
$$ LANGUAGE plpgsql;

-- Trigger 3:
CREATE TRIGGER trg_historico_salario
AFTER UPDATE OF salario
ON Funcionario
FOR EACH ROW
EXECUTE FUNCTION registrar_alteracao_salario();