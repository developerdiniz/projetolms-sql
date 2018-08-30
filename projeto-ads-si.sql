CREATE TABLE ALUNO (
	ID INT IDENTITY,
	NOME VARCHAR (30) NOT NULL,  
	EMAIL VARCHAR (50) NOT NULL,
	CELULAR VARCHAR(20) NOT NULL,
	RA TINYINT NOT NULL,
	FOTO VARCHAR(255),
	
	CONSTRAINT PK_ALUNO PRIMARY KEY(ID),
	CONSTRAINT UQ_EMAIL_ALUNO UNIQUE (EMAIL),
	CONSTRAINT UQ_CELULAR_ALUNO UNIQUE (CELULAR)
);

CREATE TABLE PROFESSOR(
	ID INT IDENTITY,
	EMAIL VARCHAR (50) NOT NULL,
	CELULAR VARCHAR (20) NOT NULL, 
	APELIDO VARCHAR (30),

	CONSTRAINT PK_PROFESSOR PRIMARY KEY (ID),
	CONSTRAINT UQ_EMAIL_PROFESSOR UNIQUE (EMAIL),
	CONSTRAINT UQ_CELULAR_PROFESSOR UNIQUE (CELULAR)
);


CREATE TABLE CURSO(
	ID INT IDENTITY,
	NOME VARCHAR (30) NOT NULL,

	CONSTRAINT PK_CURSO PRIMARY KEY (ID),
	CONSTRAINT UQ_NOME_CURSO UNIQUE (NOME)
);

create table Entrega(
	ID int primary key IDENTITY not null,
	Titulo varchar(50) not null,
	Resposta varchar(50) not null,
	DtEntrega DATETIME not null DEFAULT (getdate()),
	Status varchar(10),
	Nota tinyint not null,
	DtAvaliacao datetime not null,
	IdProfessor int not null,
	Obs varchar(1000),
	IdAluno int not null ,
	IdAtividadeVinculada int not null,


	--data entregue--
--	CONSTRAINT DF_DtEntrega DEFAULT (getdate()) FOR DtEntrega,
	--status--
	CONSTRAINT DF_STATUS DEFAULT ('Entregue') FOR status,
	CONSTRAINT CK_STATUS CHECK(status in ('Entregue','Corrigido')),
	--nota--
	CONSTRAINT CK_NOTA CHECK(nota between 0 and 10), 
	--idAluno--
	CONSTRAINT UQ_IDALUNO UNIQUE( id ),
	--chave estrangeira --
	CONSTRAINT FK_ALUNO_ID FOREIGN KEY (IdAluno) REFERENCES Aluno (ID), 
	CONSTRAINT FK_PROFESSOR_ID FOREIGN KEY (IdProfessor) REFERENCES Professor (ID), 
	CONSTRAINT FK_AtividadeVinculada_ID FOREIGN KEY (IdAtividadeVinculada) REFERENCES AtividadeVinculada (ID)
	);


create table Mensagem(
	ID int primary key IDENTITY not null,
	IdAluno int not null ,
	IdProfessor int not null,
	Assunto varchar(100) not null,
	Referencia varchar(100) not null,
	Conteudo varchar(2000) not null,
	Status varchar(10),
	DtEnvio DATETIME not null DEFAULT getdate(),
	DtResposta datetime,
	Resposta varchar(2000),
	--status--
	CONSTRAINT CK_STATUS CHECK(status in ('Enviado','Lido','Respondido')),

	--data entregue--
--	CONSTRAINT DF_DtEnvio DEFAULT (getdate()) FOR DtEnvio,

	--chave estrangeira --
	CONSTRAINT FK_ALUNO_ID FOREIGN KEY (IdAluno) REFERENCES Aluno (ID), 
	CONSTRAINT FK_PROFESSOR_ID FOREIGN KEY (IdProfessor) REFERENCES Professor (ID)

);
