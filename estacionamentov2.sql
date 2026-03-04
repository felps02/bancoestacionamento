DROP DATABASE IF EXISTS estacionamento_app;
CREATE DATABASE estacionamento_app;
USE estacionamento_app;

CREATE TABLE estacionamento (
    id_estacionamento INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    telefone VARCHAR(20),
    capacidade_total INT NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(10) NOT NULL UNIQUE,
    modelo VARCHAR(100),
    cor VARCHAR(50),
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);


CREATE TABLE vaga (
    id_vaga INT AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(10) NOT NULL,
    tipo ENUM('CARRO','MOTO','PCD') NOT NULL,
    id_estacionamento INT NOT NULL,
    FOREIGN KEY (id_estacionamento) REFERENCES estacionamento(id_estacionamento)
);

CREATE TABLE reserva (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_veiculo INT NOT NULL,
    id_estacionamento INT NOT NULL,
    data_inicio DATETIME NOT NULL,
    data_fim DATETIME NOT NULL,
    status ENUM('ATIVA','FINALIZADA','CANCELADA') DEFAULT 'ATIVA',
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo),
    FOREIGN KEY (id_estacionamento) REFERENCES estacionamento(id_estacionamento)
);


CREATE TABLE movimentacao (
    id_movimentacao INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT NOT NULL,
    id_estacionamento INT NOT NULL,
    data_entrada DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_saida DATETIME,
    valor_pago DECIMAL(10,2),

    FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo),
    FOREIGN KEY (id_estacionamento) REFERENCES estacionamento(id_estacionamento)
);


CREATE TABLE feedback (
    id_feedback INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_estacionamento INT NOT NULL,
    nota INT NOT NULL CHECK (nota BETWEEN 1 AND 5),
    comentario TEXT,
    data_feedback TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_estacionamento) REFERENCES estacionamento(id_estacionamento)
);


