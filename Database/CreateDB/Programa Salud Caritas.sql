-- Crear la base de datos iborreguitos
CREATE DATABASE icaritasborregos;
GO

-- Utilizar la base de datos iborreguitos
USE icaritasborregos;
GO

CREATE TABLE [USUARIOS] (
  [ID_USUARIO] numeric(18,0) PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [NOMBRE] varchar(100),
  [A_PATERNO] varchar(100),
  [A_MATERNO] varchar(100),
  [ID_TIPO_USUARIO] numeric(2,0),
  [EMAIL] nvarchar(255),
  [CONTRASENA] varchar(500)
);
GO

CREATE TABLE [EVENTOS] (
  [ID_EVENTO] numeric(18,0) PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [NOMBRE] varchar(200),
  [DESCRIPCION] varchar(MAX),
  [NUM_MAX_ASISTENTES] NUMERIC(18,0),
  [PUNTAJE] NUMERIC(18,0),
  [FECHA_EVENTO] datetime
);
GO

CREATE TABLE [DATOS_FISICOS] (
  [ID] NUMERIC(18,0) PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [ID_USUARIO] NUMERIC(18,0),
  [PESO] float,
  [ALTURA] float,
  [IMC] float,
  [GLUCOSA] float,
  [FECHA_ACTUALIZACION] datetime
);
GO

CREATE TABLE [HISTORICO] (
  [ID] NUMERIC(18,0) PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [ID_USUARIO] NUMERIC(18,0),
  [FECHA_MOV] datetime,
  [ID_TIPO] NUMERIC(18,0),
  [FECHA] datetime
);
GO

CREATE TABLE [BENEFICIOS] (
  [ID_BENEFICIO] NUMERIC(18,0) PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [NOMBRE] varchar(200),
  [DESCRIPCION] varchar(MAX),
  [PUNTOS] NUMERIC(18,0)
);
GO

CREATE TABLE [TIPO_USUARIO] (
  [ID_TIPO_USUARIO] NUMERIC(2,0) PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [DESCRIPCION] varchar(MAX)
);
GO

CREATE TABLE [USUARIOS_BENEFICIOS] (
  [ID] NUMERIC(18,0) PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [USUARIO] NUMERIC(18,0),
  [BENEFICIO] NUMERIC(18,0),
  [CANJEADO] bit NOT NULL DEFAULT 0
);
GO

CREATE TABLE [USUARIOS_EVENTOS] (
  [ID] NUMERIC(18,0) PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [USUARIO] NUMERIC(18,0),
  [EVENTO] NUMERIC(18,0),
  [ASISTIO] BIT NOT NULL DEFAULT 0
);
GO

CREATE TABLE [RETOS] (
  [ID_RETO] NUMERIC(18,0) PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [NOMBRE] varchar(MAX),
  [DESCRIPCION] varchar(MAX),
  [PUNTAJE] NUMERIC(18,0)
);
GO

CREATE TABLE [USUARIOS_RETOS] (
  [ID] NUMERIC(18,0) PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [ID_USUARIO] NUMERIC(18,0),
  [ID_RETO] NUMERIC(18,0),
  [COMPLETADO] bit NOT NULL DEFAULT 0
);
GO


-- Foreign Key Constraints
ALTER TABLE [DATOS_FISICOS] ADD FOREIGN KEY ([ID_USUARIO]) REFERENCES [USUARIOS] ([ID_USUARIO]);
GO

ALTER TABLE [HISTORICO] ADD FOREIGN KEY ([ID_USUARIO]) REFERENCES [USUARIOS] ([ID_USUARIO]);
GO

ALTER TABLE [HISTORICO] ADD FOREIGN KEY ([ID_TIPO]) REFERENCES [BENEFICIOS] ([ID_BENEFICIO]);
GO

ALTER TABLE [USUARIOS] ADD FOREIGN KEY ([ID_TIPO_USUARIO]) REFERENCES [TIPO_USUARIO] ([ID_TIPO_USUARIO]);
GO

ALTER TABLE [USUARIOS_BENEFICIOS] ADD FOREIGN KEY ([USUARIO]) REFERENCES [USUARIOS] ([ID_USUARIO]);
GO

ALTER TABLE [USUARIOS_BENEFICIOS] ADD FOREIGN KEY ([BENEFICIO]) REFERENCES [BENEFICIOS] ([ID_BENEFICIO]);
GO

ALTER TABLE [USUARIOS_EVENTOS] ADD FOREIGN KEY ([USUARIO]) REFERENCES [USUARIOS] ([ID_USUARIO]);
GO

ALTER TABLE [USUARIOS_EVENTOS] ADD FOREIGN KEY ([EVENTO]) REFERENCES [EVENTOS] ([ID_EVENTO]);
GO

ALTER TABLE [USUARIOS_RETOS] ADD FOREIGN KEY ([ID_USUARIO]) REFERENCES [USUARIOS] ([ID_USUARIO]);
GO

ALTER TABLE [USUARIOS_RETOS] ADD FOREIGN KEY ([ID_RETO]) REFERENCES [RETOS] ([ID_RETO]);
GO

