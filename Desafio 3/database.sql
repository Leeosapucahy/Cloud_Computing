create database clientes_db;
create table 'clientes'(
    'id' int NOT NULL AUTO_INCREMENT,
    'nome' varchar(30) NOT NULL,
    'cpf' varchar(14) NOT NULL,
    'email' varchar(30) NOT NULL,
    'senha' varchar(20) NOT NULL,
    'ativo' tinyint(1) NOT NULL,
    PRIMARY KEY ('id'),
    UNIQUE KEY 'cpf' ('cpf'),
    UNIQUE KEY 'email' ('email')
)ENGINE=InnDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

create table 'enderecos'(
    'id' int NOT NULL AUTO_INCREMENT,
    'id_cliente' int NOT NULL,
    'rua' varchar(30) DEFAULT NULL,
    'numero' int NOT NULL,
    'complemento' varchar(30) DEFAULT NULL,
    'CEP' varchar(8) NOT NULL,
    'ativo' tinyint(1) NOT NULL,
    PRIMARY KEY ('id'),
    KEY 'id_cliente' ('id_cliente'),
    CONSTRAINT 'enderecos_ibfk_1' FOREIGN KEY ('id_cliente') REFERENCES 'clientes' ('id')
)ENGINE=InnDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci


create database catalago_db;
create table 'catalogo'(
    'id' int NOT NULL AUTO_INCREMENT,
    'nome' varchar(20) NOT NULL,
    'descricao' varchar(100) DEFAULT NULL,
    'preco' varchar(12) NOT NULL,
    'disponibilidade' tinyint(1) NOT NULL,
    PRIMARY KEY ('id')
)ENGINE=InnDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

create table 'inventario'(
    'id' int NOT NULL AUTO_INCREMENT,
    'id_produto' int NOT NULL,
    'id_cliente' int NOT NULL,
    PRIMARY KEY ('id')
)ENGINE=InnDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
