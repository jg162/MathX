-- =====================================
-- BANCO DE DADOS MATHX
-- =====================================

DROP DATABASE IF EXISTS mathx_db;
CREATE DATABASE mathx_db;
USE mathx_db;

-- =====================================
-- TABELA DE USUÁRIOS
-- =====================================

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    tipo ENUM('Aluno','Professor','Administrador') DEFAULT 'Aluno',
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================
-- TABELA DE DISCIPLINAS
-- =====================================

CREATE TABLE disciplinas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- =====================================
-- TABELA DE EXERCÍCIOS
-- =====================================

CREATE TABLE exercicios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    descricao TEXT,
    dificuldade ENUM('Fácil','Médio','Difícil') DEFAULT 'Médio',
    disciplina_id INT,
    FOREIGN KEY (disciplina_id)
        REFERENCES disciplinas(id)
);

-- =====================================
-- TABELA DE CONVERSAS
-- =====================================

CREATE TABLE conversas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    data_inicio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id)
);

-- =====================================
-- TABELA DE MENSAGENS
-- =====================================

CREATE TABLE mensagens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    conversa_id INT NOT NULL,
    remetente ENUM('usuario','chatbot') NOT NULL,
    mensagem TEXT NOT NULL,
    data_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (conversa_id)
        REFERENCES conversas(id)
);

-- =====================================
-- TABELA DE ARQUIVOS (OCR)
-- =====================================

CREATE TABLE arquivos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    nome_arquivo VARCHAR(255),
    tipo ENUM('imagem','pdf'),
    texto_extraido LONGTEXT,
    data_upload TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id)
);

-- =====================================
-- TABELA DE AVALIAÇÕES
-- =====================================

CREATE TABLE avaliacoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    nota INT,
    comentario TEXT,
    data_avaliacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id)
);

-- =====================================
-- TABELA DE RESPOSTAS
-- =====================================

CREATE TABLE respostas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    exercicio_id INT,
    resposta LONGTEXT,
    correta BOOLEAN,
    data_resposta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id),
    FOREIGN KEY (exercicio_id)
        REFERENCES exercicios(id)
);

-- =====================================
-- DADOS INICIAIS
-- =====================================

INSERT INTO disciplinas (nome) VALUES
('Funções'),
('Trigonometria'),
('Geometria Analítica'),
('Probabilidade'),
('Matemática Financeira');

INSERT INTO usuarios (nome,email,senha,tipo)
VALUES
('Administrador','admin@mathx.com','123456','Administrador');
