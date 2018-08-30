CREATE TABLE USUARIO(
	ID INT PRIMARY KEY IDENTITY,
	LOGIN VARCHAR(50) NOT NULL,
	SENHA VARCHAR(30) NOT NULL,
	DT_EXPIRACAO DATE DEFAULT('01-01-1900') NOT NULL,

	CONSTRAINT UQ_LOGIN UNIQUE(LOGIN),
	
);


CREATE TABLE COORDENADOR(
	ID INT PRIMARY KEY IDENTITY,
	ID_USUARIO INT NOT NULL,
	NOME VARCHAR(40) NOT NULL,
	EMAIL VARCHAR(50) NOT NULL,
	CELULAR VARCHAR(20) NOT NULL,
	
	CONSTRAINT UQ_EMAIL UNIQUE(EMAIL),
	CONSTRAINT UQ_CELULAR UNIQUE(CELULAR),
	CONSTRAINT FK_ID_USUARIO FOREIGN KEY(ID_USUARIO) REFERENCES USUARIO(ID)
); 
CREATE TABLE ALUNO (
	ID INT IDENTITY,
	IdUsuario int not null,
	NOME VARCHAR (30) NOT NULL,  
	EMAIL VARCHAR (50) NOT NULL,
	CELULAR VARCHAR(20) NOT NULL,
	RA TINYINT NOT NULL,
	FOTO VARCHAR(255),
	
	CONSTRAINT PK_ALUNO PRIMARY KEY(ID),
	Constraint FK_IdUsuario FOREIGN KEY (IdUsuario) REFERENCES Usuario (ID),
	CONSTRAINT UQ_EMAIL_ALUNO UNIQUE (EMAIL),
	CONSTRAINT UQ_CELULAR_ALUNO UNIQUE (CELULAR)
);

CREATE TABLE PROFESSOR(
	ID INT IDENTITY,
	IDUSUARIO int not null,
	EMAIL VARCHAR (50) NOT NULL,
	CELULAR VARCHAR (20) NOT NULL, 
	APELIDO VARCHAR (30),

	CONSTRAINT PK_PROFESSOR PRIMARY KEY (ID),
	Constraint FK_IDUSUARIO FOREIGN KEY (IDUSUARIO) REFERENCES Usuario (ID),
	CONSTRAINT UQ_EMAIL_PROFESSOR UNIQUE (EMAIL),
	CONSTRAINT UQ_CELULAR_PROFESSOR UNIQUE (CELULAR)
);
	create table Disciplina (
	ID int Primary Key Identity not null,
	Nome varchar(100) not null,
	Data date not null DEFAULT (GETDATE()) ,
	Status varchar(10) not null default ('Aberta') ,
	PlanoDeEnsino varchar(1500) not null,
	CargaHoraria tinyint not null,
	Competencias varchar(500) not null,
	Habilidades varchar(200) not null,
	Ementa varchar(500) not null,
	ConteudoProgramatico varchar(1000) not null,
	BibliografiaBasica varchar(500) not null,
	BibliografiaComplementar varchar(500) not null,
	PercentualTeorico tinyint not null,
	PercentualPratico tinyint not null,
	IdCoordenador int not null,

	constraint UQ_Nome unique (nome),
	--CONSTRAINT DF_Data 
	--constraint DF_status ,
	Constraint CK_status check (status in ('Aberta', 'Fechada')),
	Constraint CK_CargaHoraria check (CargaHoraria in (40,80)),
	constraint CK_PercentualTeorico check (PercentualTeorico between 0 and 100),
	constraint CK_PercentualPratico check (PercentualPratico between 0 and 100),
	CONSTRAINT FK_IdCoordenador FOREIGN KEY (IdCoordendador) REFERENCES Coordenador (ID),

			
);

create table DisciplinaOfertada (
	ID int Primary Key identity not null,
	IdCoordendador int not null,
	DtInicioMatricula date,
	DtFimMatricula date,
	IdDisiciplina int not null,
	IdCurso int not null,
	Ano int not null,
	Semestre tinyint,
	Turma varchar(10) not null,
	IdProfessor int not null,
	Metodologia varchar(200),
	Recursos varchar(200),
	CriterioAvaliacao varchar(100),
	PlanoDeAulas varchar (1000),

	CONSTRAINT FK_IdCoordenador FOREIGN KEY (IdCoordendador) REFERENCES Coordenador (ID),
	CONSTRAINT FK_IdDisciplina FOREIGN KEY (IdDisiciplina) REFERENCES Disicplina (ID),
	CONSTRAINT FK_IdCurso FOREIGN KEY (IdCurso) REFERENCES Curso (ID),
	CONSTRAINT FK_IdProfessor FOREIGN KEY (IdProfessor) REFERENCES Professor (ID),

	Constraint CK_Ano check (Ano between 1900 and 2100),
	Constraint CK_Semestre check (Semestre in(1,2)),
	Constraint CK_Turma check (Turma between 'A' and 'Z'),





CREATE TABLE CURSO(
	ID INT IDENTITY,
	NOME VARCHAR (30) NOT NULL,

	CONSTRAINT PK_CURSO PRIMARY KEY (ID),
	CONSTRAINT UQ_NOME_CURSO UNIQUE (NOME)
);
	
	
	
CREATE TABLE SOLICITACAO_MATRICULA(
	ID INT IDENTITY,
	ID_ALUNO INT NOT NULL,
	--ID_DICIPLINA_OFERTA INT NOT NULL,
	DT_SOLICITACAO DATETIME NOT NULL DEFAULT(GETDATE()),
	ID_COORDENADOR INT,
	STATUS VARCHAR(30) DEFAULT ('SOLICITADA'),

	CONSTRAINT PK_SOLICITACAO_MATRICULA PRIMARY KEY (ID),
	CONSTRAINT CK_STATUS CHECK(STATUS IN ('SOLICITADA', 'APROVADA', 'REJEITADA', 'CANCELADA'))
	
);	


CREATE TABLE ATIVIDADE(
	ID INT IDENTITY,
	TITULO VARCHAR(20) NOT NULL,
	DESCRICAO VARCHAR(255),
	CONTEUDO VARCHAR(255) NOT NULL,
	TIPO VARCHAR(50) NOT NULL,
	EXTRAS VARCHAR(50),
	--ID_PROFESSOR NOT NULL(TABELA FK COLOCAR DEPOIS)

	CONSTRAINT PK_ATIVIDADE PRIMARY KEY (ID),
	CONSTRAINT UK_TITULO UNIQUE (TITULO),
	CONSTRAINT CK_TIPO CHECK(TIPO IN ('RESPOSTA ABERTA', 'TESTE'))

);


CREATE TABLE ATIVIDADE_VINCULADA(
	ID INT IDENTITY,
	--ID_ATIVIDADE VARCHAR(4) IDENTITY,(TABELA FK COLOCAR DEPOIS)
	--ID_PROFESSOR TINYINT NOT NULL,(TABELA FK COLOCAR DEPOIS)
	--ID_DICIPLINA_OFERTADA TINYINT NOT NULL,(TABELA FK COLOCAR DEPOIS)
	ROTULO TINYINT NOT NULL,
	STATUS VARCHAR(30) NOT NULL,
	DT_INICIO_RESPOSTA DATETIME NOT NULL,
	DT_FIM_RESPOSTAS DATETIME NOT NULL

	CONSTRAINT PK_ATIVIDADE_VINCULADA PRIMARY KEY (ID)
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
