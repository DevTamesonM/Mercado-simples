CREATE DATABASE mercadodb;
USE mercadodb;


CREATE TABLE produto (
id_produto INT AUTO_INCREMENT PRIMARY KEY,
nome_produto VARCHAR(255) NOT NULL,
preco_produto DECIMAL(10, 2) NOT NULL,
estoque_produto INT NOT NULL
);


CREATE TABLE clientes (
id_clientes INT AUTO_INCREMENT PRIMARY KEY,
nome_clientes VARCHAR(255) NOT NULL,
email_clientes VARCHAR(255) UNIQUE NOT NULL,
telefone_clientes VARCHAR(20)
);


CREATE TABLE pedidos (
id_pedidos INT AUTO_INCREMENT PRIMARY KEY,
id_clientes INT,
data_pedidos DATE NOT NULL,
FOREIGN KEY (id_clientes) REFERENCES clientes(id_clientes)
);


CREATE TABLE itens_pedido (
id_itens_pedido INT AUTO_INCREMENT PRIMARY KEY,
id_pedidos INT,
id_produto INT,
quantidade_itens_pedido INT NOT NULL,
preco_unitario_itens_pedido DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (id_pedidos) REFERENCES pedidos(id_pedidos),
FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

CREATE TABLE funcionarios (
id_funcionarios INT AUTO_INCREMENT PRIMARY KEY,
nome_funcionarios VARCHAR(255) NOT NULL,
cargo_funcionarios VARCHAR(255) NOT NULL
);


CREATE TABLE vendas (
id_vendas INT AUTO_INCREMENT PRIMARY KEY,
id_funcionarios INT,
data_vendas DATE NOT NULL,
FOREIGN KEY (id_funcionarios) REFERENCES funcionarios(id_funcionarios)
);


CREATE TABLE itens_venda (
id_itens_venda INT AUTO_INCREMENT PRIMARY KEY,
id_vendas INT,
id_produto INT,
quantidade INT NOT NULL,
preco_unitario DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (id_vendas) REFERENCES vendas(id_vendas),
FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);


CREATE VIEW produtos_em_estoque AS
SELECT * FROM produto WHERE estoque_produto > 0;

CREATE VIEW vendas_por_produto AS
SELECT p.nome_produto AS produto, SUM(iv.quantidade) AS quantidade_vendida
FROM produto p
JOIN itens_venda iv ON p.id_produto = iv.id_produto
GROUP BY p.nome_produto;

CREATE VIEW clientes_com_mais_compras AS
SELECT c.nome_clientes AS clientes, COUNT(*) AS total_de_compras
FROM clientes c
JOIN pedidos p ON c.id_clientes = p.id_clientes
GROUP BY c.nome_clientes;

CREATE VIEW funcionarios_por_cargo AS
SELECT cargo_funcionarios, COUNT(*) AS total_de_funcionarios
FROM funcionarios
GROUP BY cargo_funcionarios;
