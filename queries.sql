-- Inserção de dados e queries
USE ecommerce;

-- Exibir tabelas
SHOW TABLES;

-- Descrever tabela clients
DESC clients;

-- Inserção de dados na tabela clients
INSERT INTO clients (fname, minit, lname, cpf, address) VALUES
    ('João', 'A', 'Santos', '12345678901', 'Rua das Flores, 123, Cidade A'),
    ('Ana', 'B', 'Silva', '98765432109', 'Avenida Central, 456, Cidade B'),
    ('Carlos', 'C', 'Oliveira', '45678912307', 'Rua dos Pássaros, 789, Cidade C'),
    ('Mariana', 'D', 'Pereira', '78912345605', 'Alameda das Árvores, 101, Cidade D'),
    ('Pedro', 'E', 'Fernandes', '98765432113', 'Avenida Principal, 50, Cidade E'),
    ('Luisa', 'F', 'Martins', '65478912311', 'Rua do Comércio, 29, Cidade F');

-- Inserção de dados na tabela product
INSERT INTO product (pname, classification_kids, category, avaliação, size) VALUES
    ('Fone de ouvido Bluetooth', false, 'Eletrônico', 4.5, NULL),
    ('Boneca Barbie', true, 'Brinquedos', 4.0, NULL),
    ('Vestido Floral', true, 'Vestimenta', 5.0, 'M'),
    ('Microfone Profissional', false, 'Eletrônico', 4.2, NULL),
    ('Sofá de Couro', false, 'Móveis', 4.8, '2x60x80'),
    ('Arroz Integral', false, 'Alimentos', 4.7, NULL),
    ('Amazon Echo Dot', false, 'Eletrônico', 4.3, NULL);

-- Consultar dados da tabela clients
SELECT * FROM clients;

-- Consultar dados da tabela product
SELECT * FROM product;

-- Exclusão de pedidos (comentei a deleção para evitar a remoção acidental)
-- DELETE FROM orders WHERE idorderclient IN (1, 2, 3, 4);

-- Inserção de dados na tabela orders
INSERT INTO orders (idorderclient, orderstatus, orderdescription, sendvalue, paymentcash) VALUES
    (1, DEFAULT, 'Compra via aplicativo', NULL, true),
    (2, DEFAULT, 'Compra via aplicativo', 50.0, false),
    (3, 'Confirmado', NULL, NULL, true),
    (4, DEFAULT, 'Compra via website', 150.0, false);

-- Consultar dados da tabela orders
SELECT * FROM orders;

-- Inserção de dados na tabela productorder
INSERT INTO productorder (idpoproduct, idpoorder, poquantity, postatus) VALUES
    (1, 2, 2, 'Disponivel'),
    (2, 2, 1, 'Sem estoque'),
    (3, 1, 1, 'Disponivel');

-- Inserção de dados na tabela productstorage
INSERT INTO productstorage (storagelocation, quantity) VALUES
    ('Rio de Janeiro', 1000),
    ('Rio de Janeiro', 500),
    ('São Paulo', 10),
    ('São Paulo', 100),
    ('São Paulo', 10),
    ('Brasília', 60);

-- Inserção de dados na tabela storagelocation
INSERT INTO storagelocation (idlproduct, idlstorage, location) VALUES
    (1, 2, 'RJ'),
    (2, 6, 'GO');

-- Inserção de dados na tabela supplier
INSERT INTO supplier (socialname, cnpj, contact) VALUES
    ('Fornecedora ABC', '12345678901234', '21987654321'),
    ('Eletrônicos XYZ', '98765432109876', '21985471236'),
    ('Super Foods', '45678901234567', '21976543218');

-- Consultar dados da tabela supplier
SELECT * FROM supplier;

-- Inserção de dados na tabela productsupplier
INSERT INTO productsupplier (idpssupplier, idpsproduct, quantity) VALUES
    (1, 1, 500),
    (1, 2, 400),
    (2, 4, 633),
    (3, 3, 5),
    (2, 5, 10);

-- Inserção de dados na tabela seller
INSERT INTO seller (socialname, abstname, cnpj, cpf, location, contact) VALUES
    ('Tech Eletronics', NULL, '12345678901234', NULL, 'Rio de Janeiro', '21994628751'),
    ('Boutique Durgas', NULL, NULL, '98765432101', 'Rio de Janeiro', '21956789532'),
    ('Kids World', NULL, '45678901234567', NULL, 'São Paulo', '11986574849');

-- Consultar dados da tabela seller
SELECT * FROM seller;

-- Consultar estrutura da tabela productseller
DESC productseller;

-- Inserção de dados na tabela productseller
INSERT INTO productseller (idpseller, idproduct, prodquantity) VALUES
    (1, 6, 80),
    (2, 7, 10);

-- Queries SQL

-- Consultar dados da tabela productseller
SELECT * FROM productseller;

-- Contar o número de clientes
SELECT COUNT(*) FROM clients;

-- Consultar dados dos clientes e seus pedidos associados
SELECT * FROM clients c, orders o WHERE c.idclient = o.idorderclient;

-- Consultar o nome, sobrenome, ID do pedido e status dos pedidos dos clientes
SELECT CONCAT(fname, ' ', lname) AS client, idorder AS request, orderstatus AS status FROM clients c, orders o WHERE c.idclient = o.idorderclient;

-- Inserção de novo pedido
INSERT INTO orders (idorderclient, orderstatus, orderdescription, sendvalue, paymentcash) VALUES
    (2, DEFAULT, 'Compra via aplicativo', NULL, true);

-- Contar o número de clientes com pedidos
SELECT COUNT(*) FROM clients c, orders o WHERE c.idclient = o.idorderclient;

-- Consultar dados da tabela orders com limite e ordenação
SELECT * FROM orders WHERE idorder <= 3 ORDER BY idorderclient DESC;

-- Recuperação de pedidos com produtos associados
SELECT * FROM clients c
    INNER JOIN orders o ON c.idclient = o.idorderclient
    INNER JOIN productorder p ON p.idpoorder = o.idorder;

-- Contar o número de pedidos realizados por clientes
SELECT c.idclient, fname, COUNT(*) AS number_of_orders FROM clients c
    INNER JOIN orders o ON c.idclient = o.idorderclient
    GROUP BY idclient
    HAVING number_of_orders > 1;

-- Quantos pedidos foram realizados pelos clientes?
SELECT c.idclient, fname, COUNT(*) AS number_of_orders FROM clients c
    INNER JOIN orders o ON c.idclient = o.idorderclient
    GROUP BY idclient;
