DROP DATABASE IF EXISTS estacionamento_app;
CREATE DATABASE estacionamento_app;
USE estacionamento_app;



CREATE TABLE Cidade (
    id_cidade INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    id_estado INT NOT NULL,
    FOREIGN KEY (id_estado) REFERENCES Estado(id_estado)
);

CREATE TABLE Estado (
    id_estado INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE Localizacao (
    id_localizacao INT PRIMARY KEY AUTO_INCREMENT,
    rua VARCHAR(255) NOT NULL,
    cep VARCHAR(10) NOT NULL,
    id_cidade INT NOT NULL,
    FOREIGN KEY (id_cidade) REFERENCES Cidade(id_cidade)
);

CREATE TABLE Estacionamento (
    id_estacionamento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    capacidade_total INT NOT NULL,
    ativo BOOLEAN NOT NULL,
    id_localizacao INT NOT NULL,
    FOREIGN KEY (id_localizacao) REFERENCES Localizacao(id_localizacao)
);

CREATE TABLE Vaga (
    id_vaga INT PRIMARY KEY AUTO_INCREMENT,
    numero VARCHAR(50) NOT NULL,
    tipo ENUM('carro', 'moto', 'caminhao') NOT NULL,
    id_estacionamento INT NOT NULL,
    FOREIGN KEY (id_estacionamento) REFERENCES Estacionamento(id_estacionamento)
);

CREATE TABLE Usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ModeloVeiculo (
    id_modelo INT PRIMARY KEY AUTO_INCREMENT,
    nome_modelo VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE Veiculo (
    id_veiculo INT PRIMARY KEY AUTO_INCREMENT,
    placa VARCHAR(10) NOT NULL UNIQUE,
    cor VARCHAR(50),
    id_modelo INT NOT NULL,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_modelo) REFERENCES ModeloVeiculo(id_modelo),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Movimentacao (
    id_movimentacao INT PRIMARY KEY AUTO_INCREMENT,
    id_veiculo INT NOT NULL,
    id_vaga INT NOT NULL,
    id_estacionamento INT NOT NULL,
    data_entrada DATETIME NOT NULL,
    data_saida DATETIME,
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo),
    FOREIGN KEY (id_vaga) REFERENCES Vaga(id_vaga),
    FOREIGN KEY (id_estacionamento) REFERENCES Estacionamento(id_estacionamento)
);

CREATE TABLE Feedback (
    id_feedback INT PRIMARY KEY AUTO_INCREMENT,
    nota INT NOT NULL,
    comentario TEXT,
    data_feedback TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_usuario INT NOT NULL,
    id_estacionamento INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_estacionamento) REFERENCES Estacionamento(id_estacionamento)
);