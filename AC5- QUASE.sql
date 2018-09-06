
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
	NOME VARCHAR(60) NOT NULL,
	EMAIL VARCHAR(50) NOT NULL,
	CELULAR VARCHAR(20) NOT NULL,
	
	CONSTRAINT UQ_EMAIL UNIQUE(EMAIL),
	CONSTRAINT UQ_CELULAR UNIQUE(CELULAR),
	CONSTRAINT FK_ID_USUARIO FOREIGN KEY(ID_USUARIO) REFERENCES USUARIO(ID)
); 
CREATE TABLE ALUNO (
	ID INT IDENTITY,
	IdUsuario int not null,
	NOME VARCHAR (60) NOT NULL,  
	EMAIL VARCHAR (50) NOT NULL,
	CELULAR VARCHAR(20) NOT NULL,
	RA varchar(10) NOT NULL,
	FOTO VARCHAR(255),
	
	CONSTRAINT PK_ALUNO PRIMARY KEY(ID),
	Constraint FK_IdUsuario_Aluno FOREIGN KEY (IdUsuario) REFERENCES Usuario (ID),
	CONSTRAINT UQ_EMAIL_ALUNO UNIQUE (EMAIL),
	CONSTRAINT UQ_CELULAR_ALUNO UNIQUE (CELULAR)
);

CREATE TABLE PROFESSOR(
	ID INT IDENTITY,
	IDUSUARIO int not null,
	EMAIL VARCHAR (50) NOT NULL,
	CELULAR VARCHAR (20) NOT NULL, 
	APELIDO VARCHAR (30) Not null,

	CONSTRAINT PK_PROFESSOR PRIMARY KEY (ID),
	Constraint FK_IDUSUARIO_Professor FOREIGN KEY (IDUSUARIO) REFERENCES Usuario (ID),
	CONSTRAINT UQ_EMAIL_PROFESSOR UNIQUE (EMAIL),
	CONSTRAINT UQ_CELULAR_PROFESSOR UNIQUE (CELULAR)
);

create table Disciplina (
	ID int Primary Key Identity not null,
	Nome varchar(60) not null,
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
	Constraint CK_status_Disciplina check (status in ('Aberta', 'Fechada')),
	Constraint CK_CargaHoraria check (CargaHoraria in (40,80)),
	constraint CK_PercentualTeorico check (PercentualTeorico between 0 and 100),
	constraint CK_PercentualPratico check (PercentualPratico between 0 and 100),
	CONSTRAINT FK_IdCoordenador_Disciplina FOREIGN KEY (IdCoordenador) REFERENCES Coordenador (ID),

			
);

CREATE TABLE CURSO(
	ID INT IDENTITY not null,
	NOME VARCHAR (60) NOT NULL,

	CONSTRAINT PK_CURSO PRIMARY KEY (ID),
	CONSTRAINT UQ_NOME_CURSO UNIQUE (NOME)
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
	IdProfessor int,
	Metodologia varchar(200),
	Recursos varchar(200),
	CriterioAvaliacao varchar(100),
	PlanoDeAulas varchar (1000),

	CONSTRAINT FK_IdCoordenador_DisciplinaOfertada FOREIGN KEY (IdCoordendador) REFERENCES Coordenador (ID),
	CONSTRAINT FK_IdDisciplina_DisciplinaOfertada FOREIGN KEY (IdDisiciplina) REFERENCES Disciplina (ID),
	CONSTRAINT FK_IdCurso_DisciplinaOfertada FOREIGN KEY (IdCurso) REFERENCES Curso (ID),
	CONSTRAINT FK_IdProfessor_DisciplinaOfertada FOREIGN KEY (IdProfessor) REFERENCES Professor (ID),

	Constraint CK_Ano check (Ano between 1900 and 2100),
	Constraint CK_Semestre check (Semestre in(1,2)),
	Constraint CK_Turma check (Turma between 'A' and 'Z'),


	);


	
	
	
CREATE TABLE SOLICITACAO_MATRICULA( 
	ID INT IDENTITY,
	ID_ALUNO INT NOT NULL,
	ID_DICIPLINA_OFERTADA INT NOT NULL,
	DT_SOLICITACAO DATETIME NOT NULL DEFAULT(GETDATE()),
	ID_COORDENADOR INT,
	STATUS VARCHAR(30) DEFAULT ('SOLICITADA'),

	CONSTRAINT PK_ID_SOLICITACAO_MATRICULA PRIMARY KEY (ID),
	CONSTRAINT CK_STATUS_SOLICITACAO_MATRICULA CHECK(STATUS IN ('SOLICITADA', 'APROVADA', 'REJEITADA', 'CANCELADA')),
	CONSTRAINT FK_ID_ALUNO_SOLICITACAO_MATRICULA FOREIGN KEY (ID_ALUNO) REFERENCES ALUNO (ID),
	CONSTRAINT FK_Id_Coordenador_SOLICITAÇÃO_MATRICULA FOREIGN KEY (ID_COORDENADOR) REFERENCES Coordenador (ID),
	CONSTRAINT FK_ID_DICIPLINA_OFERTADA_SOLICITAÇÃO_MATRICULA FOREIGN KEY (ID_DICIPLINA_OFERTADA) REFERENCES DisciplinaOfertada (ID),
);	


CREATE TABLE ATIVIDADE(
	ID INT IDENTITY,
	TITULO VARCHAR(20) NOT NULL,
	DESCRICAO VARCHAR(255),
	CONTEUDO VARCHAR(255) NOT NULL,
	TIPO VARCHAR(50) NOT NULL,
	EXTRAS VARCHAR(50),
	ID_PROFESSOR INT NOT NULL,

	CONSTRAINT PK_ATIVIDADE PRIMARY KEY (ID),
	CONSTRAINT UK_TITULO UNIQUE (TITULO),
	CONSTRAINT CK_TIPO CHECK(TIPO IN ('RESPOSTA ABERTA', 'TESTE')),
	CONSTRAINT FK_ID_PROFESSOR_ATIVIDADE FOREIGN KEY (ID_PROFESSOR) REFERENCES PROFESSOR (ID),
);


CREATE TABLE ATIVIDADE_VINCULADA(
	ID INT IDENTITY,
	ID_ATIVIDADE int not null,
	ID_PROFESSOR int NOT NULL,
	ID_DISCIPLINA_OFERTADA int NOT NULL,
	ROTULO TINYINT NOT NULL,
	STATUS VARCHAR(30) NOT NULL,
	DT_INICIO_RESPOSTA DATETIME NOT NULL,
	DT_FIM_RESPOSTAS DATETIME NOT NULL

	CONSTRAINT PK_ID_ATIVIDADE_VINCULADA PRIMARY KEY (ID),
	CONSTRAINT FK_IdAtividade_ATIVIDADE_VINCULADA FOREIGN KEY (ID_ATIVIDADE) REFERENCES Atividade (ID),
	CONSTRAINT FK_ID_PROFESSOR_ATIVIDADE_VINCULADA FOREIGN KEY (ID_PROFESSOR) REFERENCES Professor (ID),
	CONSTRAINT FK_ID_DICIPLINA_OFERTADA_ATIVIDADE_VINCULADA FOREIGN KEY (ID_DISCIPLINA_OFERTADA) REFERENCES  DisciplinaOfertada (ID),
);	

	
	
create table Entrega(
	ID int primary key IDENTITY not null,
	Titulo varchar(50) not null,
	Resposta varchar(300) not null,
	DtEntrega DATETIME not null DEFAULT (getdate()),
	Status varchar(10) DEFAULT ('Entregue'),
	Nota decimal(2,2),
	DtAvaliacao date ,
	IdProfessor int ,
	Obs varchar(1000),
	IdAluno int not null ,
	IdAtividadeVinculada int not null,


	--data entregue--
--	CONSTRAINT DF_DtEntrega DEFAULT (getdate()) FOR DtEntrega,
	--status--
	CONSTRAINT CK_STATUS_Entrega CHECK(status in ('Entregue','Corrigido')),
	--nota--
	CONSTRAINT CK_NOTA CHECK(nota between 0.00 and 10.00), 
	--chave estrangeira --
	CONSTRAINT FK_ID_ALUNO_Entrega FOREIGN KEY (IdAluno) REFERENCES Aluno (ID), 
	CONSTRAINT FK_ID_PROFESSOR_Entrega FOREIGN KEY (IdProfessor) REFERENCES Professor (ID), 
	CONSTRAINT FK_ID_ATIVIDADE_VINCULADA_Entrega FOREIGN KEY (IdAtividadeVinculada) REFERENCES Atividade_Vinculada (ID)
	);


create table Mensagem(
	ID int primary key IDENTITY not null,
	IdAluno int not null ,
	IdProfessor int not null,
	Assunto varchar(100) not null,
	Referencia varchar(100) not null,
	Conteudo varchar(2000) not null,
	Status varchar(10) DEFAULT ('Enviado') not null,
	DtEnvio DATETIME not null DEFAULT getdate(),
	DtResposta datetime,
	Resposta varchar(2000),
	--status--
	CONSTRAINT CK_STATUS_MENSAGEM CHECK(Status in ('Enviado','Lido','Respondido')),

	--data entregue--
--	CONSTRAINT DF_DtEnvio DEFAULT (getdate()) FOR DtEnvio,

	--chave estrangeira --
	CONSTRAINT FK_ALUNO_ID_MENSAGEM FOREIGN KEY (IdAluno) REFERENCES Aluno (ID), 
	CONSTRAINT FK_PROFESSOR_ID_MENSAGEM FOREIGN KEY (IdProfessor) REFERENCES Professor (ID)
);

drop table USUARIO
drop table COORDENADOR
drop table Aluno 
drop table PROFESSOR
drop table Disciplina
drop table DisciplinaOfertada
drop table Curso
