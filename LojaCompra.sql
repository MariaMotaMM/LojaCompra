CREATE DATABASE CompraLoja;

USE CompraLoja;

CREATE TABLE Produto (
Produto_ID int primary key auto_increment,
nome VARCHAR(100),
preco DECIMAL (10,2),
estoque INT
);

INSERT INTO Produto (nome, preco, estoque)
VALUES ( "Mochila", 60.00, 40),
("Liquidificador", 145.00, 80),
("Ventilador", 120.00,45),
("Armário", 400.00,5),
("Lápis",7.00,80);

SELECT nome, preco, estoque FROM produto;

CREATE TABLE Clientes (
Cliente_ID int primary key auto_increment,
nome VARCHAR (100),
email VARCHAR (100),
telefone VARCHAR (15)
);

INSERT INTO Clientes (nome, email, telefone)
VALUES ('Maria Clara', 'mariaclara@email.com', '987654321'),
('João Silva', 'joao@email.com', '912345678'),
('Ana Souza', 'ana@email.com', '934567890'),
('Carlos Oliveira', 'carlos@email.com', '965432109'),
('Fernanda Lima', 'fernanda@email.com', '976543210');

SELECT * FROM clientes;

CREATE TABLE Pedidos (
Pedido_ID INT PRIMARY KEY AUTO_INCREMENT ,
Cliente_ID_FK INT NOT NULL,
Data_Pedido DATE,
FOREIGN KEY(Cliente_ID_FK) REFERENCES Clientes (Cliente_ID)
);

Insert into pedidos (Cliente_ID_FK,Data_Pedido)
values (1,'20240808'),
(2,'20240508'),
(3,'20240807'),
(4,'20240608'),
(5,'20240504');

SELECT * FROM Pedidos;

CREATE TABLE DetalhesPedido(
Detalhe_ID INT PRIMARY KEY AUTO_INCREMENT ,
Pedido_ID_FK INT NOT NULL,
Produto_ID_FK INT NOT NULL,
quantidade INT,
preco_unitario DECIMAL (10,2),
FOREIGN KEY (Pedido_ID_FK) REFERENCES Pedidos (Pedido_ID),
FOREIGN KEY (Produto_ID_FK) REFERENCES Produto (Produto_ID)
);

INSERT INTO DetalhesPedido (Pedido_ID_FK, Produto_ID_FK,quantidade,preco_unitario)
VALUES (1,1, 4,60.00),
(1,2,2,140.00),
(2,3,7,20.00),
(4,2,5,20.000),
(5,5,2,140.00);

SELECT*FROM Detalhespedido;

SELECT * FROM DetalhesPedido AS dt 
JOIN Produto AS pr ON dt.Produto_ID_FK = pr.Produto_ID
JOIN Pedidos AS ped ON dt.Pedido_ID_FK = ped.Pedido_ID;


SELECT pr.nome AS 'nome do produto',
       dt.quantidade AS qtd, 
       dt.preco_unitario AS 'pç unit'
FROM DetalhesPedido AS dt 
JOIN Produto AS pr ON dt.Produto_ID_FK = pr.Produto_ID
WHERE dt.Pedido_ID_FK = 1;

SELECT SUM(estoque) FROM Produto;

SELECT SUM(preco) FROM Produto;

SELECT SUM(preco *estoque) FROM Produto;

SELECT dt.pedido_ID_FK, SUM(dt.quantidade * dt.preco_unitario)
 AS 'venda total'FROM DetalhesPedido AS dt
 WHERE dt.Pedido_ID_FK =2 
 GROUP BY dt.Pedido_ID_FK;