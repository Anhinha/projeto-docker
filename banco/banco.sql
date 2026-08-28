CREATE DATABASE IF NOT EXISTS projeto_db;

USE projeto_db;

CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    quantidade_estoque INT NOT NULL,
    categoria_id INT NOT NULL,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)   
);

INSERT INTO categorias (nome, descricao, ativo) VALUES
('Lanches', 'Opções salgados da lanchonete', TRUE),
('Doces', 'Bolos e doces da lanchonete', TRUE),
('Bebidas', 'Bebidas quentes, frias e sucos', TRUE);

INSERT INTO produtos (nome, preco, quantidade_estoque, categoria_id) VALUES
('Cuscuz', 16.00, 10, 1),
('Tapioca', 16.00, 10, 1),
('Salgados', 9.00, 15, 1),
('Pastel', 12.00, 10, 1),
('Bolo', 8.00, 8, 2),
('Brownie', 10.00, 8, 2),
('Café', 2.50, 30, 3),
('Refrigerante', 6.00, 20, 3),
('Suco', 6.00, 20, 3);

