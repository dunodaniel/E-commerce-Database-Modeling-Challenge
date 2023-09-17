-- criação do banco de dados para o cenário E-commerce
create database if not exists ecommerce;
use ecommerce;


-- criar tabela cliente
create table if not exists clients(
	idclient int auto_increment primary key,
    fname varchar(10),
    minit char(3),
    lname varchar(20),
    cpf char(11) not null,
    address varchar(300),
    constraint unique_cpf_client unique (cpf)
) auto_increment = 1;   

    
-- criar tabela produto    
create table if not exists product(
	idproduct int auto_increment primary key,
	pname varchar(30),
	classification_kids bool default false,
	category enum ('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') not null,
	avaliacao float default 0,
    size varchar(10)
) auto_increment = 1;


-- criar tabela pedido     
create table if not exists orders(
	idorder int auto_increment primary key,
	idorderclient int,
	orderstatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
	orderdescription varchar(255),
	sendvalue float default 10,
    paymentcash bool default false,
    idpayment int unique,
    constraint fk_orders_client foreign key (idorderclient) references clients (idclient) on update cascade on delete set null
) auto_increment = 1;   

   
-- criar tabela pagamento    
create table if not exists payments (
    idclient int,
    idpayment int,
    typepayment enum('boleto', 'cartão', 'dois cartões'),
    limitavailable float,
    primary key (idclient , idpayment),
    constraint fk_payments_orders foreign key (idpayment) references orders (idpayment)
);   

    
-- criar tabela estoque    
create table if not exists productstorage (
    idprodstorage int auto_increment primary key,
    storagelocation varchar(255),
    quantity int default 0
) auto_increment = 1;

    
-- criar tabela fornecedor    
create table if not exists supplier(
	idsupplier int auto_increment primary key,
	socialname varchar(255),
	cnpj char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (cnpj)
) auto_increment = 1;  

 
-- criar tabela vendedor    
create table if not exists seller(
	idseller int auto_increment primary key,
	socialname varchar(255),
    abstname varchar (255),
	cnpj char(15),
    cpf char(9),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (cnpj),
    constraint unique_cpf_seller unique (cpf)
) auto_increment = 1;  


-- criar tabela produto/vendedor    
create table if not exists productseller(
	idpseller int,
	idproduct int,
    prodquantity int default 1,
    primary key (idpseller, idproduct),
    constraint fk_product_seller foreign key (idpseller) references seller(idseller),
    constraint fk_product_product foreign key (idproduct) references product(idproduct)
);


-- criar tabela produto/pedido
create table productorder(
		idpoproduct int,
        idpoorder int,
        poquantity int default 1,
        postatus enum('Disponivel', 'Sem estoque') default 'Disponivel',
        primary key (idpoproduct, idpoorder),
		constraint fk_productorder_seller foreign key (idpoproduct) references product(idproduct),
		constraint fk_productorder_product foreign key (idpoorder) references orders(idorder)
);


-- criar tabela produto/estoque
create table storagelocation(
	idlproduct int,
    idlstorage int,
    location varchar(255) not null,
    primary key (idlproduct, idlstorage),
    constraint fk_storage_location_product foreign key (idlproduct) references product(idproduct),
    constraint fk_storage_location_storage foreign key (idlstorage) references productstorage(idprodstorage)
);


-- criar tabela produto/fornecedor
create table if not exists productsupplier(
	idpssupplier int,
    idpsproduct int,
    quantity int not null,
    primary key (idpssupplier, idpsproduct),
    constraint fk_product_supplier_supplier foreign key (idpssupplier) references supplier(idsupplier),
    constraint fk_product_supplier_product foreign key (idpsproduct) references product(idproduct)
);

-- show tables; 
-- show databases;
-- desc clients;
-- desc product;
-- desc orders;
-- desc productstorage;
