
CREATE DATABASE IF NOT EXISTS parkiei
   DEFAULT CHARACTER SET utf8mb4
   DEFAULT COLLATE utf8mb4_unicode_ci;
USE parkiei;
-- -----------------------------------------------------
-- Tabela: estado
-- -----------------------------------------------------
CREATE TABLE estado (
   ID_estado   INT NOT NULL AUTO_INCREMENT,
   nome        VARCHAR(255) NOT NULL,
   PRIMARY KEY (ID_estado)
) ENGINE=InnoDB;
-- -----------------------------------------------------
-- Tabela: cidade
-- -----------------------------------------------------
CREATE TABLE cidade (
   ID_cidade   INT NOT NULL AUTO_INCREMENT,
   nome        VARCHAR(50) NOT NULL,
   ID_estado   INT NOT NULL,
   PRIMARY KEY (ID_cidade),
   CONSTRAINT fk_cidade_estado
       FOREIGN KEY (ID_estado) REFERENCES estado (ID_estado)
       ON UPDATE CASCADE
       ON DELETE RESTRICT
) ENGINE=InnoDB;
-- -----------------------------------------------------
-- Tabela: estacionamento
-- -----------------------------------------------------
CREATE TABLE estacionamento (
   ID_estacionamento   INT NOT NULL AUTO_INCREMENT,
   nome                VARCHAR(255) NOT NULL,
   capacidade_total    INT NOT NULL,
   ativo               BOOLEAN NOT NULL DEFAULT TRUE,
   rua                 VARCHAR(255),
   cep                 VARCHAR(255),
   ID_cidade           INT NOT NULL,
   PRIMARY KEY (ID_estacionamento),
   CONSTRAINT fk_estacionamento_cidade
       FOREIGN KEY (ID_cidade) REFERENCES cidade (ID_cidade)
       ON UPDATE CASCADE
       ON DELETE RESTRICT
) ENGINE=InnoDB;
-- -----------------------------------------------------
-- Tabela: vaga
-- -----------------------------------------------------
CREATE TABLE vaga (
   id_VAGA             INT NOT NULL AUTO_INCREMENT,
   numero              VARCHAR(50) NOT NULL,
   tipo                ENUM('CARRO','MOTO','CAMINHAO','PCD','IDOSO') NOT NULL,
   ID_estacionamento   INT NOT NULL,
   PRIMARY KEY (id_VAGA),
   CONSTRAINT fk_vaga_estacionamento
       FOREIGN KEY (ID_estacionamento) REFERENCES estacionamento (ID_estacionamento)
       ON UPDATE CASCADE
       ON DELETE CASCADE
) ENGINE=InnoDB;
-- -----------------------------------------------------
-- Tabela: usuario
-- -----------------------------------------------------
CREATE TABLE usuario (
   ID_usuario      INT NOT NULL AUTO_INCREMENT,
   nome            VARCHAR(255) NOT NULL,
   email           VARCHAR(255) NOT NULL UNIQUE,
   senha           VARCHAR(255) NOT NULL,
   data_cadastro   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (ID_usuario)
) ENGINE=InnoDB;
-- -----------------------------------------------------
-- Tabela: modelo
-- -----------------------------------------------------
CREATE TABLE modelo (
   ID_modelo    INT NOT NULL AUTO_INCREMENT,
   nome_modelo  VARCHAR(255) NOT NULL,
   PRIMARY KEY (ID_modelo)
) ENGINE=InnoDB;
-- -----------------------------------------------------
-- Tabela: veiculo
-- -----------------------------------------------------
CREATE TABLE veiculo (
   ID_veiculo  INT NOT NULL AUTO_INCREMENT,
   placa       VARCHAR(10) NOT NULL UNIQUE,
   cor         VARCHAR(50),
   ID_modelo   INT NOT NULL,
   ID_usuario  INT NOT NULL,
   PRIMARY KEY (ID_veiculo),
   CONSTRAINT fk_veiculo_modelo
       FOREIGN KEY (ID_modelo) REFERENCES modelo (ID_modelo)
       ON UPDATE CASCADE
       ON DELETE RESTRICT,
   CONSTRAINT fk_veiculo_usuario
       FOREIGN KEY (ID_usuario) REFERENCES usuario (ID_usuario)
       ON UPDATE CASCADE
       ON DELETE CASCADE
) ENGINE=InnoDB;
-- -----------------------------------------------------
-- Tabela: movimentacao
-- -----------------------------------------------------
CREATE TABLE movimentacao (
   ID_movimento        INT NOT NULL AUTO_INCREMENT,
   ID_vaga             INT NOT NULL,
   ID_estacionamento   INT NOT NULL,
   data_entrada        DATETIME NOT NULL,
   data_saida          DATETIME NULL,
   ID_veiculo          INT NOT NULL,
   PRIMARY KEY (ID_movimento),
   CONSTRAINT fk_movimentacao_vaga
       FOREIGN KEY (ID_vaga) REFERENCES vaga (id_VAGA)
       ON UPDATE CASCADE
       ON DELETE RESTRICT,
   CONSTRAINT fk_movimentacao_estacionamento
       FOREIGN KEY (ID_estacionamento) REFERENCES estacionamento (ID_estacionamento)
       ON UPDATE CASCADE
       ON DELETE RESTRICT,
   CONSTRAINT fk_movimentacao_veiculo
       FOREIGN KEY (ID_veiculo) REFERENCES veiculo (ID_veiculo)
       ON UPDATE CASCADE
       ON DELETE RESTRICT
) ENGINE=InnoDB;
-- -----------------------------------------------------
-- Tabela: feedback
-- -----------------------------------------------------
CREATE TABLE feedback (
   ID_feedback         INT NOT NULL AUTO_INCREMENT,
   nota                VARCHAR(255) NOT NULL,
   comentario          TEXT,
   data_feedback       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
   ID_usuario          INT NOT NULL,
   ID_estacionamento   INT NOT NULL,
   PRIMARY KEY (ID_feedback),
   CONSTRAINT fk_feedback_usuario
       FOREIGN KEY (ID_usuario) REFERENCES usuario (ID_usuario)
       ON UPDATE CASCADE
       ON DELETE CASCADE,
   CONSTRAINT fk_feedback_estacionamento
       FOREIGN KEY (ID_estacionamento) REFERENCES estacionamento (ID_estacionamento)
       ON UPDATE CASCADE
       ON DELETE CASCADE
) ENGINE=InnoDB;