DROP TABLE IF EXISTS historico;
DROP TABLE IF EXISTS filme_genero;
DROP TABLE IF EXISTS genero;
DROP TABLE IF EXISTS filmes;
DROP TABLE IF EXISTS perfil;
DROP TABLE IF EXISTS conta;
DROP TABLE IF EXISTS planos;



CREATE TABLE planos (
    id_plano SERIAL,
    nome VARCHAR(50) NOT NULL,
    valor NUMERIC(10, 2) NOT NULL,
    limite_perfis INT NOT NULL,
    CONSTRAINT pk_planos PRIMARY KEY (id_plano)
);


CREATE TABLE conta (
    id_conta SERIAL,
    nome_titular VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    data_vencimento DATE,
    id_plano INT NOT NULL,
    CONSTRAINT pk_conta PRIMARY KEY (id_conta),
    CONSTRAINT fk_conta_plano FOREIGN KEY (id_plano) REFERENCES planos(id_plano)
);


CREATE TABLE perfil (
    id_perfil SERIAL,
    nome VARCHAR(50) NOT NULL,
    class_etaria VARCHAR(10) NOT NULL,
    id_conta INT NOT NULL,
    CONSTRAINT pk_perfil PRIMARY KEY (id_perfil),
    CONSTRAINT fk_perfil_conta FOREIGN KEY (id_conta) REFERENCES conta(id_conta)
);


CREATE TABLE filmes (
    id_filme SERIAL,
    titulo VARCHAR(100) NOT NULL,
    sinopse TEXT,
    ano_lancamento INT,
    duracao INT,
    class_indicativa VARCHAR(10),
    CONSTRAINT pk_filmes PRIMARY KEY (id_filme)
);


CREATE TABLE genero (
    id_genero SERIAL,
    nome VARCHAR(50) NOT NULL,
    CONSTRAINT pk_genero PRIMARY KEY (id_genero)
);


CREATE TABLE filme_genero (
    id_filme INT,
    id_genero INT,
    CONSTRAINT pk_filme_genero PRIMARY KEY (id_filme, id_genero),
    CONSTRAINT fk_fg_filme FOREIGN KEY (id_filme) REFERENCES filmes(id_filme),
    CONSTRAINT fk_fg_genero FOREIGN KEY (id_genero) REFERENCES genero(id_genero)
);


CREATE TABLE historico (
    id_historico SERIAL,
    id_perfil INT NOT NULL,
    id_filme INT NOT NULL,
    data_visu TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tempo_parado INT,
    CONSTRAINT pk_historico PRIMARY KEY (id_historico),
    CONSTRAINT fk_hist_perfil FOREIGN KEY (id_perfil) REFERENCES perfil(id_perfil),
    CONSTRAINT fk_hist_filme FOREIGN KEY (id_filme) REFERENCES filmes(id_filme)
);

--INSERÇÃO DE DADOS

INSERT INTO planos (nome, valor, limite_perfis) VALUES
('Básico', 25.90, 1),
('Padrão', 39.90, 2),
('Premium', 55.90, 4);


INSERT INTO conta (nome_titular, email, senha, cpf, data_vencimento, id_plano) VALUES
('Ana Izabelle', 'ana.iza@email.com', '123456', '111.111.111-11', '2025-01-10', 3),    -- Plano Premium
('Mateus Oliveira', 'mateus.oli@email.com', '123456', '222.222.222-22', '2025-01-11', 2), -- Plano Padrão
('Eliseu Coelho', 'eliseu.co@email.com', '123456', '333.333.333-33', '2025-01-12', 1),    -- Plano Básico
('Andrew Luiz', 'andrew.lu@email.com', '123456', '444.444.444-44', '2025-01-13', 3),      -- Plano Premium
('Karine Oliveira', 'karine.oli@email.com', '123456', '555.555.555-55', '2025-01-14', 2); -- Plano Padrão


INSERT INTO perfil (nome, class_etaria, id_conta) VALUES
('Ana Admin', '18+', 1),
('Ana Kids', 'Livre', 1),
('Mateus Perfil', '18+', 2),
('Eliseu Perfil', '18+', 3),
('Andrew Perfil', '18+', 4), 
('Karine Perfil', '18+', 5); 

INSERT INTO filmes (titulo, ano_lancamento, duracao, class_indicativa) VALUES
('Vingadores: Ultimato', 2019, 181, '12'),
('O Poderoso Chefão', 1972, 175, '18+'),
('Toy Story', 1995, 81, 'Livre'),
('Interestelar', 2014, 169, '10');


INSERT INTO historico (id_perfil, id_filme, tempo_parado) VALUES
(1, 1, 181),
(3, 4, 60), 
(2, 3, 10),
(5, 2, 175),
(6, 1, 45); 

-- CONSULTAS (RELATÓRIOS)

SELECT titulo, ano_lancamento 
FROM filmes 
WHERE ano_lancamento > 2010 
ORDER BY ano_lancamento DESC;


SELECT nome, class_etaria 
FROM perfil 
WHERE class_etaria <> '18+';


SELECT titulo, duracao 
FROM filmes 
WHERE duracao > 120;


SELECT 
    c.nome_titular, 
    c.email, 
    p.nome AS nome_plano
FROM conta c
INNER JOIN planos p ON c.id_plano = p.id_plano;


SELECT 
    pf.nome AS apelido_perfil, 
    f.titulo AS nome_filme, 
    h.tempo_parado
FROM historico h
INNER JOIN perfil pf ON h.id_perfil = pf.id_perfil
INNER JOIN filmes f ON h.id_filme = f.id_filme
WHERE h.tempo_parado > 0 
  AND h.tempo_parado < f.duracao;


-- consulta de colunas
SELECT * FROM conta;

SELECT * FROM perfil;

SELECT * FROM filmes;

SELECT * FROM historico;

SELECT * FROM planos;