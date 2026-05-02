DROP DATABASE IF EXISTS estacionamento_app;
CREATE DATABASE estacionamento_app;
USE estacionamento_app;

-- TABELA LOCALIZACAO
CREATE TABLE cidade (
    id_cidade INT AUTO_INCREMENT PRIMARY KEY,
    cidade VARCHAR(255) NOT NULL
);
-- TABELA LOCALIZACAO
CREATE TABLE estado (
    id_estado INT AUTO_INCREMENT PRIMARY KEY,
    estado VARCHAR(255) NOT NULL,
	id_cidade int not null,
  FOREIGN KEY (id_cidade) REFERENCES cidade(id_cidade)
);
CREATE TABLE localizacao (
    id_localizacao INT AUTO_INCREMENT PRIMARY KEY,
    cidade VARCHAR(100) NOT NULL,
    id_estado int not null,
      FOREIGN KEY (id_estado) REFERENCES estado(id_estado)
);
-- TABELA estado

-- TABELA ESTACIONAMENTO

CREATE TABLE estacionamento (
    id_estacionamento INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    telefone VARCHAR(20),
    capacidade_total INT NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_localizacao INT NOT NULL,

    FOREIGN KEY (id_localizacao) REFERENCES localizacao(id_localizacao)
      
);


-- TABELA USUARIO

CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- TABELA VEICULO

CREATE TABLE veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(8) NOT NULL UNIQUE,
    modelo VARCHAR(100),
    cor VARCHAR(50),
    id_usuario INT NOT NULL,

    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
        
);


-- TABELA VAGA

CREATE TABLE vaga (
    id_vaga INT AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(10) NOT NULL,
    tipo ENUM('CARRO','MOTO','PCD') NOT NULL,
    status ENUM('LIVRE','OCUPADA','MANUTENCAO') DEFAULT 'LIVRE',
    id_estacionamento INT NOT NULL,

    FOREIGN KEY (id_estacionamento) REFERENCES estacionamento(id_estacionamento)
        ON DELETE CASCADE,

    UNIQUE(numero, id_estacionamento)
);

-- TABELA MOVIMENTACAO

CREATE TABLE movimentacao (
    id_movimentacao INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT NOT NULL,
    id_vaga INT NOT NULL,
    id_estacionamento INT NOT NULL,
    data_entrada DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_saida DATETIME,
    valor_pago DECIMAL(10,2),

    FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo)
        ON DELETE CASCADE,

    FOREIGN KEY (id_vaga) REFERENCES vaga(id_vaga)
        ON DELETE CASCADE,

    FOREIGN KEY (id_estacionamento) REFERENCES estacionamento(id_estacionamento)
        ON DELETE CASCADE
);

-- TABELA FEEDBACK

CREATE TABLE feedback (
    id_feedback INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_estacionamento INT NOT NULL,
    nota TINYINT NOT NULL,
    comentario TEXT,
    data_feedback TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
        

    FOREIGN KEY (id_estacionamento) REFERENCES estacionamento(id_estacionamento)
       
);
