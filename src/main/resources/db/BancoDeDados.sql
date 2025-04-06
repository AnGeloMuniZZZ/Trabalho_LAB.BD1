CREATE DATABASE LocacaoLivros
GO
USE LocacaoLivros
GO
-------------------------------------------------------------------------- CRIAÇÃO DE TABELAS --------------------------------------------------------------------------- 
CREATE TABLE Aluno(
cpf	VARCHAR(11) NOT NULL PRIMARY KEY,
ra	VARCHAR(10) NOT NULL,
nome_completo VARCHAR(180)	NOT NULL,
email VARCHAR(80) NOT NULL,
senha VARCHAR(8) NOT NULL
)
GO

CREATE TABLE Administrador(
codigo INTEGER NOT NULL PRIMARY KEY,
nome VARCHAR(180) NOT NULL,
usuario VARCHAR(80) NOT NULL,
senha VARCHAR(20) NOT NULL
)
GO

CREATE TABLE Exemplar(
codigo_exemplar INT NOT NULL PRIMARY KEY,
Administrador_codigo INTEGER NOT NULL,
nome VARCHAR(180) NOT NULL,
qtd_paginas INT NOT NULL,
FOREIGN KEY (Administrador_codigo) REFERENCES Administrador(codigo)
)
GO

CREATE TABLE Revista (
ExemplarCodigo INT NOT NULL PRIMARY KEY,
issn VARCHAR(8) NOT NULL
FOREIGN KEY (ExemplarCodigo) REFERENCES Exemplar (codigo_exemplar)
)
GO

CREATE TABLE Livro (
ExemplarCodigo INT NOT NULL PRIMARY KEY,
isbn VARCHAR(13) NOT NULL,
edicao INT NOT NULL
FOREIGN KEY (ExemplarCodigo) REFERENCES Exemplar (codigo_exemplar)
)
GO

CREATE TABLE Locacao (
codigo_locacao INT NOT NULL,
AlunoCpf VARCHAR(11) NOT NULL,
ExemplarCodigo INT NOT NULL,
data_retirada DATE NOT NULL,
qtd_dias INT NOT NULL
PRIMARY KEY (codigo_locacao, AlunoCpf, ExemplarCodigo)
FOREIGN KEY (AlunoCpf) REFERENCES Aluno (cpf),
FOREIGN KEY (ExemplarCodigo) REFERENCES Exemplar (codigo_exemplar)
)
GO

------------------------------------------------------------------------- CRIAÇÃO DE PROCEDUREs ------------------------------------------------------------------------ 
-- Calcula o 1º digito verificador --
CREATE PROCEDURE calcular_primeiro_digito_cpf(@cpf VARCHAR(11), @primeiroDigito INTEGER OUTPUT) AS
DECLARE @contador INTEGER
DECLARE @multiplicador INTEGER
DECLARE @resultadoSoma INTEGER
DECLARE @digitoAtual INTEGER
SET @contador = 1
SET @multiplicador = 10
SET @resultadoSoma = 0

WHILE(@contador <= 9) BEGIN
	SET @digitoAtual = CAST(SUBSTRING(@cpf, @contador, 1) AS INTEGER)
	SET @resultadoSoma = @resultadoSoma + (@digitoAtual * @multiplicador)
	SET @contador = @contador + 1
	SET @multiplicador = @multiplicador - 1
END
SET @resultadoSoma = @resultadoSoma % 11

IF @resultadoSoma < 2 BEGIN
	SET @primeiroDigito = 0
END
ELSE BEGIN
	SET @primeiroDigito = 11 - @resultadoSoma
END
GO

-- Calcula o 2º digito verificador --
CREATE PROCEDURE calcular_segundo_digito_cpf(@cpf VARCHAR(11), @segundoDigito INTEGER OUTPUT) AS 
DECLARE @contador INTEGER
DECLARE @multiplicador INTEGER
DECLARE @resultadoSoma INTEGER
DECLARE @digitoAtual INTEGER
SET @contador = 1
SET @multiplicador = 11
SET @resultadoSoma = 0

WHILE(@contador <= 10) BEGIN
	SET @digitoAtual = CAST(SUBSTRING(@cpf, @contador, 1) AS INTEGER)
	SET @resultadoSoma = @resultadoSoma + (@digitoAtual * @multiplicador)
	SET @contador = @contador + 1
	SET @multiplicador = @multiplicador - 1
END
SET @resultadoSoma = @resultadoSoma % 11

IF @resultadoSoma < 2 BEGIN
	SET @segundoDigito = 0
END
ELSE BEGIN
	SET @segundoDigito = 11 - @resultadoSoma
END
GO

-- Valida o CPF --
CREATE PROCEDURE validar_cpf(@cpf VARCHAR(11), @validacao BIT OUTPUT) AS
DECLARE @primeiroDigito AS INTEGER
DECLARE @segundoDigito AS INTEGER
DECLARE @primeiro AS INTEGER
DECLARE @segundo AS INTEGER

SET @primeiroDigito = CAST(SUBSTRING(@cpf, 10, 1) AS INTEGER)
SET @segundoDigito = CAST(SUBSTRING(@cpf, 11, 1) AS INTEGER)
EXEC calcular_primeiro_digito_cpf @cpf, @primeiro OUTPUT
EXEC calcular_segundo_digito_cpf @cpf, @segundo OUTPUT

IF (@primeiroDigito = @primeiro AND @segundoDigito = @segundo) BEGIN
	SET @validacao = 1
END
ELSE BEGIN
	SET @validacao = 0
END
GO

-- Gera o ultimo digito do RA --
CREATE PROCEDURE gerar_digito_verificador_ra (@ra_incompleto VARCHAR(9), @digito VARCHAR(1) OUTPUT) AS
DECLARE @resultadoMult AS INTEGER
DECLARE @contador AS INTEGER
DECLARE @digitoAtual AS INTEGER
SET @resultadoMult = 1
SET @contador = 1

WHILE(@contador <= 9) BEGIN
	SET @digitoAtual = CAST(SUBSTRING(@ra_incompleto, @contador, 1) AS INTEGER)
	SET @resultadoMult = @resultadoMult * @digitoAtual
	SET @contador = @contador + 1
END

SET @resultadoMult = (@resultadoMult / 4)

IF (@resultadoMult >= 10) BEGIN
	SET @digito = '0'
END
ELSE BEGIN
	SET @digito = CAST(@resultadoMult AS VARCHAR(1))
END
GO

--Valida a existencia de um RA --
CREATE PROCEDURE encontrar_ra (@ra VARCHAR(10), @validacao BIT OUTPUT) AS
DECLARE @ra_encontrado VARCHAR(11)
SELECT @ra_encontrado = ra FROM Aluno WHERE ra = @ra
IF (@ra_encontrado IS NULL) BEGIN
	SET @validacao = 0
END
ELSE BEGIN
	SET @validacao = 1
END
GO

-- Gerar RA --
CREATE PROCEDURE gerar_ra(@ra VARCHAR(10) OUTPUT) AS
DECLARE @ra_valido BIT
DECLARE @digito AS VARCHAR(1)
SET @ra_valido = 1

WHILE (@ra_valido = 1) BEGIN
	SET @ra = '222' + 
			CAST(SUBSTRING(CAST(YEAR(GETDATE()) AS VARCHAR(4)),3,2) AS VARCHAR(2)) + 
			CAST(CASE 
					WHEN MONTH(GETDATE()) BETWEEN 1 AND 6 THEN 1
					ELSE 2
				 END AS VARCHAR(1)) +
			CAST(CAST(RAND()*(10) AS INTEGER) AS VARCHAR(1)) + 
			CAST(CAST(RAND()*(10) AS INTEGER) AS VARCHAR(1)) +
			CAST(CAST(RAND()*(10) AS INTEGER) AS VARCHAR(1))

	EXEC gerar_digito_verificador_ra @ra, @digito OUTPUT
	SET @ra = @ra + @digito
	EXEC encontrar_ra @ra, @ra_valido OUTPUT
END
GO

-- Validar senha --
CREATE PROCEDURE validar_senha(@senha VARCHAR(8), @validacao BIT OUTPUT) AS
DECLARE @contador AS INTEGER
SET @contador = LEN(@senha)

IF @senha LIKE '%[0-9]%' AND @contador = 8 BEGIN
	SET @validacao = 1
END
ELSE BEGIN
	SET @validacao = 0
END
GO

--Verificar email identico --
CREATE PROCEDURE verificar_email_igual (@email_incompleto VARCHAR(80), @numero_convertido VARCHAR(5) OUTPUT) AS
DECLARE @contador INT,
		@emailTemp VARCHAR(80)

		SELECT @emailTemp = email FROM Aluno WHERE email LIKE @email_incompleto
		SET @contador = 0

		WHILE (@email_incompleto LIKE @emailTemp) BEGIN
			IF (@contador = 0) BEGIN
				SET @emailTemp = @emailTemp + CAST(@contador AS VARCHAR(5))
			END
			SET @contador = @contador + 1
			SET @emailTemp = SUBSTRING(@emailTemp, 1, LEN(@emailTemp) -1) + CAST(@contador AS VARCHAR(5))
			SELECT @email_incompleto = email FROM Aluno WHERE email LIKE @emailTemp
		END
		SET @numero_convertido = CAST(@contador AS VARCHAR(5))
GO

--Criando o email --
CREATE PROCEDURE criar_email (@nome_completo VARCHAR(180), @email VARCHAR(80) OUTPUT) AS
DECLARE @primeiroNome VARCHAR(90),
		@ultimoNome VARCHAR(90),
		@numero VARCHAR(5)
		
		SET @primeiroNome = RTRIM(SUBSTRING(@nome_completo, 1, CHARINDEX(' ',@nome_completo)))
		SET @ultimoNome = LTRIM(REVERSE(SUBSTRING(REVERSE(@nome_completo), 1, CHARINDEX(' ',REVERSE(@nome_completo)))))
		SET @email = @primeiroNome + '.' + @ultimoNome
		EXEC verificar_email_igual @email, @numero OUTPUT
		IF (@numero != 0) BEGIN
			SET @email = @email + @numero
		END
GO

--Valida a existencia de um CPF --
CREATE PROCEDURE encontrar_cpf (@cpf VARCHAR(11), @validacao BIT OUTPUT) AS

DECLARE @cpf_encontrado VARCHAR(11)
SELECT @cpf_encontrado = cpf FROM Aluno WHERE cpf = @cpf
IF (@cpf_encontrado IS NULL) BEGIN
	SET @validacao = 0
END
ELSE BEGIN
	SET @validacao = 1
END
GO

--Realiza o CONTROLE de entrada de Dados da tabela ALUNO
CREATE PROCEDURE controle_aluno (@opc CHAR(1), @cpf VARCHAR(11), @nome_completo VARCHAR(180), @senha VARCHAR(8), @saida VARCHAR(100) OUTPUT) AS

DECLARE @validacao_cpf BIT
DECLARE @validacao_senha BIT
DECLARE @duplicata_cpf BIT
DECLARE @ra VARCHAR(10)
DECLARE @email VARCHAR(80)
DECLARE @erro VARCHAR(200)

-- INSERIR ALUNO
IF (UPPER(@opc) = 'I') BEGIN
	EXEC validar_cpf @cpf, @validacao_cpf OUTPUT
	EXEC validar_senha @senha, @validacao_senha OUTPUT
	EXEC encontrar_cpf @cpf, @duplicata_cpf OUTPUT
	IF(@validacao_cpf = 0 OR @validacao_senha = 0 OR @duplicata_cpf = 1) BEGIN
		RAISERROR('Dados de entrada invalidos', 16, 1)
		RETURN
	END
	ELSE BEGIN
		BEGIN TRY
			EXEC gerar_ra @ra OUTPUT -- NAO PRECIA MAIS DO CPF
			EXEC criar_email @nome_completo, @email OUTPUT
			INSERT INTO Aluno VALUES (@cpf, @ra, @nome_completo, @email, @senha)
			SET @saida = 'Aluno(a) ' + @nome_completo + ' INSERIDO(A) com sucesso'
		END TRY
		BEGIN CATCH
			SET @erro = ERROR_MESSAGE()
			RAISERROR(@erro, 16, 1)
			RETURN
		END CATCH
	END
END

ELSE BEGIN
	-- UPDATE ALUNO (alterar senha)
	IF (UPPER(@opc) = 'U') BEGIN
		EXEC validar_senha @senha, @validacao_senha OUTPUT
		EXEC encontrar_cpf @cpf, @duplicata_cpf OUTPUT
		IF(@validacao_senha = 1 AND @duplicata_cpf = 1) BEGIN
			BEGIN TRY
				UPDATE Aluno SET senha = @senha WHERE cpf = @cpf
				SET @saida = 'Aluno(a) ' + @nome_completo + ' ATUALIZADO(A) com sucesso'
			END TRY
			BEGIN CATCH
				SET @erro = ERROR_MESSAGE()
				RAISERROR(@erro, 16, 1)
				RETURN
			END CATCH
		END
		ELSE BEGIN
			RAISERROR('Senha invalida ou CPF nao encontrado', 16, 1)
		END
	END
	ELSE BEGIN
		RAISERROR('Opcao invalida', 16, 1)
	END
END
GO

--Verifica se o numero digitado e um ISBN(L) ou ISSN(R)
CREATE PROCEDURE descobrir_tipo_isbn_issn (@isbn_issn VARCHAR(13), @validacao CHAR(1) OUTPUT) AS

IF (LEN(@isbn_issn) = 13) BEGIN
	SET @validacao = 'L'
END
ELSE BEGIN
	IF(LEN(@isbn_issn) = 8) BEGIN
		SET @validacao = 'R'
	END
END
GO

--Valida a existencia de um Cod de Exemplar--
CREATE PROCEDURE encontrar_codigo_exemplar (@codigo_exemplar INTEGER, @validacao BIT OUTPUT) AS

DECLARE @codigo_exemplar_encontrado INTEGER
SELECT @codigo_exemplar_encontrado = codigo_exemplar FROM Exemplar WHERE codigo_exemplar = @codigo_exemplar
IF (@codigo_exemplar_encontrado IS NULL) BEGIN
	SET @validacao = 0
END
ELSE BEGIN
	SET @validacao = 1
END
GO

-- Verifica a existencia de um ADMINISTRADOR no Banco
CREATE PROCEDURE encontrar_adm (@codigo INTEGER, @validacao BIT OUTPUT) AS
IF(EXISTS(SELECT codigo FROM Administrador WHERE codigo = @codigo)) BEGIN
	SET @validacao = 1
END
ELSE BEGIN
	SET @validacao = 0
END
GO

-- Realiza o CONTROLE de entrada de Dados da tabela EXEMPLAR e REVISTA/LIVRO
CREATE PROCEDURE controle_exemplar (@opc CHAR(1), @codigo_exemplar INTEGER, @administradorCod INTEGER, @nome VARCHAR(180), @qtd_paginas INTEGER, @isbn_issn VARCHAR(13), @edicao INTEGER, @saida VARCHAR(100) OUTPUT) AS

DECLARE @query VARCHAR(MAX)
DECLARE @tabela VARCHAR(8)
DECLARE @tipo_isbn_issn CHAR(1)
DECLARE @duplicata_codigo_exemplar BIT
DECLARE @duplicata_codigo_adm BIT
DECLARE @erro VARCHAR(200)

IF (UPPER(@opc) = 'D') BEGIN																				-- DELETAR 
	EXEC encontrar_codigo_exemplar @codigo_exemplar, @duplicata_codigo_exemplar OUTPUT
	IF (@duplicata_codigo_exemplar = 1) BEGIN
		BEGIN TRY
			DELETE Revista WHERE ExemplarCodigo = @codigo_exemplar
			DELETE Livro WHERE ExemplarCodigo = @codigo_exemplar
			DELETE Exemplar WHERE codigo_exemplar = @codigo_exemplar
			SET @saida = 'EXEMPLAR excluido com sucesso' 
		END TRY
		BEGIN CATCH
			SET @erro = ERROR_MESSAGE()
			RAISERROR(@erro, 16, 1)
		END CATCH
	END
	ELSE BEGIN
		RAISERROR('Codigo do EXEMPLAR nao encontrado', 16, 1)
		RETURN
	END
END
ELSE BEGIN
	EXEC descobrir_tipo_isbn_issn @isbn_issn, @tipo_isbn_issn OUTPUT
	IF (@tipo_isbn_issn = 'R') BEGIN
		SET @tabela = 'Revista'
	END
	ELSE BEGIN
		IF (@tipo_isbn_issn = 'L') BEGIN
			SET @tabela = 'Livro'
		END
		ELSE BEGIN
			RAISERROR('Numero de ISBN ou ISSN invalido', 16, 1)
			RETURN
		END
	END

	IF (UPPER(@opc) = 'I') BEGIN																				-- INSERIR
		IF (@tipo_isbn_issn = 'R') BEGIN
			SET @query = 'INSERT INTO ' + @tabela + ' VALUES (' +CAST(@codigo_exemplar AS VARCHAR(10))+ ',' +@isbn_issn+ ')'
		END
		ELSE BEGIN
			IF (@tipo_isbn_issn = 'L' AND @edicao IS NOT NULL AND @edicao > 0) BEGIN
				SET @query = 'INSERT INTO ' + @tabela + ' VALUES (' +CAST(@codigo_exemplar AS VARCHAR(10))+ ',' +@isbn_issn+ ',' +CAST(@edicao AS VARCHAR(3))+ ')'
			END
			ELSE BEGIN
				RAISERROR('Edicao invalida', 16, 1)
				RETURN
			END
		END

		EXEC encontrar_codigo_exemplar @codigo_exemplar, @duplicata_codigo_exemplar OUTPUT
		EXEC encontrar_adm @administradorCod, @duplicata_codigo_adm OUTPUT
		IF (@duplicata_codigo_exemplar = 0 AND @duplicata_codigo_adm = 1 AND @tipo_isbn_issn IS NOT NULL) BEGIN
			BEGIN TRY
				INSERT INTO Exemplar VALUES (@codigo_exemplar, @administradorCod, @nome, @qtd_paginas)
				EXEC (@query)
				SET @saida = 'EXEMPLAR e ' + UPPER(@tabela) + ' inseridos com sucesso' 
			END TRY
			BEGIN CATCH
				SET @erro = ERROR_MESSAGE()
				RAISERROR(@erro, 16, 1)
			END CATCH
		END
		ELSE BEGIN
			RAISERROR('Nao foi possivel Inserir um EXEMPLAR Verifique(COD_Exemplar, COD_ADM, ISBN_ISSN)', 16, 1)
		END
	END

ELSE BEGIN
		IF (UPPER(@opc) = 'U') BEGIN																			-- ATUALIZAR
			EXEC encontrar_codigo_exemplar @codigo_exemplar, @duplicata_codigo_exemplar OUTPUT
			IF (@duplicata_codigo_exemplar = 1) BEGIN
				IF(@edicao IS NOT NULL AND @edicao > 0) BEGIN
					SET @query = 'UPDATE Livro SET edicao = ' + CAST(@edicao AS VARCHAR(3)) + ' WHERE ExemplarCodigo = ' + CAST(@codigo_exemplar AS VARCHAR(10))
				END
				ELSE BEGIN
					IF (@tipo_isbn_issn = 'L') BEGIN
						RAISERROR('Edicao Invalida', 16, 1)
						RETURN
					END
				END

				IF (@tipo_isbn_issn IS NOT NULL) BEGIN
					BEGIN TRY
						EXEC(@query)
						UPDATE Exemplar SET nome = @nome, qtd_paginas = @qtd_paginas WHERE codigo_exemplar = @codigo_exemplar
						SET @saida = 'EXEMPLAR atualizado com sucesso'
					END TRY
					BEGIN CATCH
						SET @erro = ERROR_MESSAGE()
						RAISERROR(@erro, 16, 1)
					END CATCH
				END
				ELSE BEGIN
					RAISERROR('Dados de atualizacao invalidos', 16, 1)
					RETURN
				END
			END
			ELSE BEGIN
				RAISERROR('Codigo De Exemplar nao encontrado', 16, 1)
				RETURN
			END
		END
		ELSE BEGIN
			RAISERROR('Opcao Invalida', 16, 1)
		END
	END
END
GO

-- Valida a existencia de um LOGIN de um ALUNO
CREATE PROCEDURE realizar_login_aluno (@login VARCHAR(80), @senha VARCHAR(8), @validacao BIT OUTPUT) AS
IF(EXISTS (SELECT email, senha FROM Aluno WHERE email = @login AND senha = @senha)) BEGIN
	SET @validacao = 1
END
ELSE BEGIN
	SET @validacao = 0
END
GO

-- Valida a existencia de um LOGIN de um ADMINISTRADOR
CREATE PROCEDURE realizar_login_adm (@login VARCHAR(80), @senha VARCHAR(8), @validacao BIT OUTPUT) AS
IF(EXISTS (SELECT usuario, senha FROM Administrador WHERE usuario = @login AND senha = @senha)) BEGIN
	SET @validacao = 1
END
ELSE BEGIN
	SET @validacao = 0
END
GO

-- Verifica se uma locacao ja existe no sistema
CREATE PROCEDURE encontra_locacao (@codigo_locacao INT, @validacao BIT OUTPUT)
AS
	DECLARE @copiaCod INT

	SELECT @copiaCod = codigo_locacao FROM Locacao WHERE codigo_locacao = @codigo_locacao
	IF (@copiaCod IS NULL) BEGIN
		SET @validacao = 0
	END
	ELSE BEGIN
		SET @validacao = 1
	END
GO

-- Realiza o controle de LOCACAO entre Alunos e Exemplares
CREATE PROCEDURE controle_locacao (@opc CHAR(1), @cod_locacao INT, @alunoCpf VARCHAR(11), @codExemplar INT, @dt_retirada DATE, @qtd_dias INT, @saida VARCHAR(100) OUTPUT)
AS
	DECLARE	@validaLocacao BIT,
		@validaCPF BIT,
		@validaExemplar BIT,
		@erro VARCHAR(200)

	IF (UPPER(@opc) = 'D') BEGIN
	EXEC encontrar_locacao @cod_locacao, @validaLocacao OUTPUT
		IF (@validaLocacao = 1) BEGIN
			BEGIN TRY
				DELETE Locacao WHERE codigo_locacao = @cod_locacao
				SET @saida = 'A deletada foi sucedida'
			END TRY
			BEGIN CATCH
				SET @erro = ERROR_MESSAGE()
				RAISERROR(@erro, 16, 1)
			END CATCH
		END
	END
	ELSE BEGIN
		IF (UPPER(@opc) = 'I') BEGIN
			EXEC encontrar_cpf @alunoCpf, @validaCPF OUTPUT
			EXEC encontrar_codigo_exemplar @codExemplar, @validaExemplar OUTPUT
			IF (@validaCPF = 1 AND @validaExemplar = 1) BEGIN
				BEGIN TRY
					INSERT INTO Locacao VALUES (@cod_locacao, @alunoCpf, @codExemplar, @dt_retirada, @qtd_dias)
					SET @saida = 'Locação inserida com sucesso'
				END TRY
				BEGIN CATCH
					SET @erro = ERROR_MESSAGE()
					RAISERROR(@erro, 16, 1)
				END CATCH
			END
			ELSE BEGIN
				RAISERROR('Trouxa errou mano', 16, 1)
			END
		END
	END
GO

-- INSERIR ADMINISTRADOR no banco
CREATE PROCEDURE controle_inserir_administrador(@codigo INTEGER, @nome VARCHAR(180), @usuario VARCHAR(80), @senha VARCHAR(8), @saida VARCHAR(100) OUTPUT) AS

DECLARE @codigo_duplicata BIT
DECLARE @erro VARCHAR(200)

EXEC encontrar_adm @codigo, @codigo_duplicata OUTPUT

IF (@codigo_duplicata != 1) BEGIN
	BEGIN TRY
		INSERT INTO Administrador VALUES (@codigo, @nome, @usuario, @senha)
		SET @saida = 'ADMINISTRADOR CADASTRADO YAY :)'
	END TRY
	BEGIN CATCH
		SET @erro = ERROR_MESSAGE()
		RAISERROR(@erro, 16, 1)
	END CATCH
END
ELSE BEGIN
	RAISERROR('Codigo de ADM ja cadastrado', 16, 1)
END
GO


---------------------------------------------------------------------------- TESTES ----------------------------------------------------------------------------- 
--Função: calcular_primeiro_digito_cpf
--teste 1 (Saida deve retornar 9, igual ao penultimo digito do cpf)
DECLARE @test1_calcular_primeiro_digito_cpf INT
EXEC calcular_primeiro_digito_cpf '10559848790', @test1_calcular_primeiro_digito_cpf OUTPUT
PRINT(@test1_calcular_primeiro_digito_cpf)
GO


--Funcao: calcular_segundo_digito_cpf
--teste 1 (Saida deve retornar 0, igual ao ultimo digito do cpf)
DECLARE @test1_calcular_segundo_digito_cpf INT
EXEC calcular_segundo_digito_cpf '10559848790', @test1_calcular_segundo_digito_cpf OUTPUT
PRINT(@test1_calcular_segundo_digito_cpf)
GO


--Funcao: validar_cpf
-- teste 1 (Saida deve retornar bit 1, True, para o cpf valido)
DECLARE @test1_validar_cpf BIT
EXEC validar_cpf '10559848790', @test1_validar_cpf OUTPUT
PRINT(@test1_validar_cpf)

-- teste 1 (Saida deve retornar bit 0, False, para o cpf invalido)
DECLARE @test2_validar_cpf BIT
EXEC validar_cpf '12345678910', @test2_validar_cpf OUTPUT
PRINT(@test2_validar_cpf)
GO


--Funcao: gerar_digito_verificador_ra (SEMPRE RETORNA 0 EU SOU LOUCO?)
-- teste 1 (Com base na regras debe retornar o utimo digito igual a 0)
DECLARE @test1_gerar_digito_verificador_ra VARCHAR(1)
EXEC gerar_digito_verificador_ra '222241235', @test1_gerar_digito_verificador_ra OUTPUT
PRINT(@test1_gerar_digito_verificador_ra)

-- teste 2 (Com base na regras debe retornar o utimo digito igual a 8) [Colevati que fez o teste]
DECLARE @test2_gerar_digito_verificador_ra VARCHAR(1)
EXEC gerar_digito_verificador_ra '222211121', @test2_gerar_digito_verificador_ra OUTPUT
PRINT(@test2_gerar_digito_verificador_ra)
GO


-- Funcao: encontrar_ra
-- teste 1 (RA existente, devera retornar 1, false)
INSERT INTO Aluno VALUES ('02953699066', '2222519080', 'Roberto Anderson Rocha', 'roberto.rocha', 'senha123') 
DECLARE @test1_encontrar_ra BIT
EXEC encontrar_ra '2222519080', @test1_encontrar_ra OUTPUT
PRINT(@test1_encontrar_ra)
SELECT * FROM Aluno WHERE ra = '2222519080'

-- teste 2 (RA inexistente, devera retornar 0, false)
DECLARE @test2_encontrar_ra BIT
EXEC encontrar_ra '0000000000', @test2_encontrar_ra OUTPUT
PRINT(@test2_encontrar_ra)
GO


--Funcao: gerar_ra (ACHO Q NAO PREISA ENVIAR O CPF, VALIDAÇÃO DEVE SER FEITA EM OUTRO LUGAR)
-- teste 1 (CPF valido, deve retornar um RA)
DECLARE @test1_gerar_ra VARCHAR(10)
EXEC gerar_ra @test1_gerar_ra OUTPUT
PRINT(@test1_gerar_ra)
GO


--Funcao: validar_senha
-- teste 1 (Senha valida, possui 8 caracteres e tem numeros, retorna bit 1, True )
DECLARE @test1_validar_senha BIT
EXEC validar_senha 'senha123', @test1_validar_senha OUTPUT
PRINT(@test1_validar_senha)

-- teste 2 (Senha invalida, nao possui numeros, retorna bit 0, False)
DECLARE @test2_validar_senha BIT
EXEC validar_senha 'senhaABC', @test2_validar_senha OUTPUT
PRINT(@test2_validar_senha)

-- teste 3 (Senha invalida, possui mais de 8 caracteres, retorna bit 0, False)
DECLARE @test3_validar_senha BIT
EXEC validar_senha 'UmaSenhaMuitoMaisMuitoLongaMesmo123', @test3_validar_senha OUTPUT
PRINT(@test3_validar_senha)
GO


--Funcao: verificar_email_igual 
-- teste 1 (Não existe emails identicos, retorna 0)
DECLARE @test1_verificar_email_igual BIT
EXEC verificar_email_igual 'fabio.alves', @test1_verificar_email_igual OUTPUT
PRINT(@test1_verificar_email_igual)

-- teste 2 (Existe um email identico, retorna 1)
INSERT INTO Aluno VALUES ('10559848790', '2222517510', 'angelo marcos da costa muniz', 'angelo.muniz', 'senha123')
SELECT * FROM Aluno
DECLARE @test2_verificar_email_igual BIT
EXEC verificar_email_igual 'angelo.muniz', @test2_verificar_email_igual OUTPUT
PRINT(@test2_verificar_email_igual)

-- teste 3 (Existe 2 emails identicos, retorna 2?)							??? era pra retornar 2 eu acho
INSERT INTO Aluno VALUES ('12345678910', '2222518920', 'kayke rodrigues de souza costa', 'kayke.costa', 'senha345')
INSERT INTO Aluno VALUES ('43211234510', '2222510270', 'kayke souza rodrigues costa', 'kayke.costa1', 'senha567')
INSERT INTO Aluno VALUES ('43211234511', '2222510270', 'kayke souza rodrigues costa', 'kayke.costa2', 'senha567')
SELECT * FROM Aluno
DECLARE @test3_verificar_email_igual varchar(1)
EXEC verificar_email_igual 'kayke.costa', @test3_verificar_email_igual OUTPUT
PRINT(@test3_verificar_email_igual)
GO


--Funcao: criar_email 
-- teste 1 (cria um email com base no nome, deve retornar "renato.morimoto")
DECLARE @test1_criar_email VARCHAR(80)
EXEC criar_email 'renato heiji morimoto', @test1_criar_email OUTPUT
PRINT(@test1_criar_email)

-- teste 2 (cria um e-mail para uma pessoa com nome homônimo na tabela, deve retornar "alexandre.oliveira2")
INSERT INTO Aluno VALUES ('05006476079', '2222517870', 'alexandre marques de oliveira', 'alexandre.oliveira', '123senha')
INSERT INTO Aluno VALUES ('71906765030', '2222512410', 'alexandre marques de oliveira', 'alexandre.oliveira1', '321senha')
SELECT * FROM Aluno
DECLARE @test2_criar_email VARCHAR(80)
EXEC criar_email 'alexandre marques de oliveira', @test2_criar_email OUTPUT
PRINT(@test2_criar_email)
GO


--Funcao: encontrar_cpf
-- teste 1 (CPF existente, devera retornar 1, true)
INSERT INTO Aluno VALUES ('30600538044', '2222518900', 'Carlos Bernardo Marcos Vinicius Martins', 'carlos.martins', 'senha123') 
DECLARE @test1_encontrar_cpf BIT
EXEC encontrar_cpf '30600538044', @test1_encontrar_cpf OUTPUT
PRINT(@test1_encontrar_cpf)
SELECT * FROM Aluno WHERE cpf = '30600538044'

-- teste 2 (CPF inexistente, devera retornar 0, false)
DECLARE @test2_encontrar_cpf BIT
EXEC encontrar_cpf '00000000000', @test2_encontrar_cpf OUTPUT
PRINT(@test2_encontrar_cpf)
GO


--Funcao: controle_aluno
-- teste 1 (Inserir um Aluno com dados validos)
DECLARE @test1_controle_aluno VARCHAR(100)
EXEC controle_aluno 'I', '41849741042', 'Hugo Santos Lima', 'umsenha1' , @test1_controle_aluno OUTPUT
PRINT(@test1_controle_aluno)
SELECT * FROM Aluno WHERE cpf = '41849741042'

-- teste 2 (Inserir um Aluno com cpf invalido, retorna um erro)
DECLARE @test2_controle_aluno VARCHAR(100)
EXEC controle_aluno 'I', '12345678910', 'Vitor Raul Danilo da Silva', 'dosenha2' , @test2_controle_aluno OUTPUT
PRINT(@test2_controle_aluno)

-- teste 3 (Inserir um Aluno com uma senha invalida, retorna um erro)
DECLARE @test3_controle_aluno VARCHAR(100)
EXEC controle_aluno 'I', '03244608051', 'Carlos Luiz Barbosa', 'NovamenteUmaSenhaMuitoLongaMasESobreIsso' , @test3_controle_aluno OUTPUT
PRINT(@test3_controle_aluno)

-- teste 4 (Atualizar um Aluno com dados validos, a senha 'senha123' deve virar 'novasen1')
INSERT INTO Aluno VALUES('92668694060', '2222510490', 'Miguel Raul da Rocha', 'miguel.rocha', 'senha123')
DECLARE @test4_controle_aluno VARCHAR(100)
EXEC controle_aluno 'U', '92668694060', 'Miguel Raul da Rocha', 'novasen1' , @test4_controle_aluno OUTPUT
PRINT(@test4_controle_aluno)
SELECT * FROM Aluno WHERE cpf = '92668694060'

-- teste 5 (Atualizar um Aluno com uma senha invalida, retorna um erro e senha se mantem 'senha123')
INSERT INTO Aluno VALUES('72073408001', '2222517320', 'Nicolas Ricardo Mateus Oliveira', 'nicolas.oliveira', 'senha123')
DECLARE @test5_controle_aluno VARCHAR(100)
EXEC controle_aluno 'U', '72073408001', 'Nicolas Ricardo Mateus Oliveira', 'NaoEBrincadeiraEssaSenhaLongaViveVoltando' , @test5_controle_aluno OUTPUT
PRINT(@test5_controle_aluno)
SELECT * FROM Aluno WHERE cpf = '72073408001'

-- teste 6 (Atualizar um Aluno que nao esta cadastrado na tabela, retorna um erro)
DECLARE @test6_controle_aluno VARCHAR(100)
EXEC controle_aluno 'U', '00000000000', 'Nicolas Ricardo Mateus Oliveira', 'novasen1' , @test6_controle_aluno OUTPUT
PRINT(@test6_controle_aluno)

-- teste 7 (seleciona uma opcao diferente de "I" ou "U", retorna um erro)
DECLARE @test7_controle_aluno VARCHAR(100)
EXEC controle_aluno 'X', '98556492061', 'Vicente Renan Pietro Rocha', 'semha123' , @test7_controle_aluno OUTPUT
PRINT(@test7_controle_aluno)
GO


--Funcao: descobrir_tipo_isbn_issn
-- teste 1 (Entrar com 13 digitos, deve retornar um ISBN, L)
DECLARE @test1_descobrir_tipo_isbn_issn CHAR(1)
EXEC descobrir_tipo_isbn_issn '1234567891011', @test1_descobrir_tipo_isbn_issn OUTPUT
PRINT(@test1_descobrir_tipo_isbn_issn)

-- teste 2 (Entrar com 8 digitos, deve retornar um ISSN, R)
DECLARE @test2_descobrir_tipo_isbn_issn CHAR(1)
EXEC descobrir_tipo_isbn_issn '12345678', @test2_descobrir_tipo_isbn_issn OUTPUT
PRINT(@test2_descobrir_tipo_isbn_issn)

-- teste 1 (Entrar com digitos diferentes de 1 ou 8, deve retornar null)
DECLARE @test3_descobrir_tipo_isbn_issn CHAR(1)
EXEC descobrir_tipo_isbn_issn '123', @test3_descobrir_tipo_isbn_issn OUTPUT
PRINT(@test3_descobrir_tipo_isbn_issn)
GO


--Funcao encontrar_codigo_exemplar
-- teste 1 (Encontra um Exemplar existente, deve retornar 1, true)
INSERT INTO Exemplar VALUES (1592, 'Exemplar a se procurar: teste sem LIVRO ou REVISTA, apenas EXEMPLAR', 50)
DECLARE @test1_encontrar_codigo_exemplar BIT
EXEC encontrar_codigo_exemplar '1592', @test1_encontrar_codigo_exemplar OUTPUT
PRINT(@test1_encontrar_codigo_exemplar)
SELECT * FROM Exemplar WHERE codigo_exemplar = 1592

-- teste 2 (Procurar um Exemplar inexistente, deve retornar 0, false)
DECLARE @test2_encontrar_codigo_exemplar BIT
EXEC encontrar_codigo_exemplar '77757', @test2_encontrar_codigo_exemplar OUTPUT
PRINT(@test2_encontrar_codigo_exemplar)
GO


--Funcao: controle_exemplar
INSERT INTO Administrador VALUES (77, 'Administrador1', 'adm1', 'senha123')
-- teste 1 (Inserir um Exemplar/Revista com dados validos)
DECLARE @test1_controle_exemplar VARCHAR(100)
EXEC controle_exemplar 'I', 1, 77, 'A Primeira Revista sobre Moda', 75, '88888888', 0, @test1_controle_exemplar OUTPUT
PRINT(@test1_controle_exemplar)
SELECT * FROM Exemplar WHERE codigo_exemplar = 1
SELECT * FROM Revista WHERE ExemplarCodigo = 1

-- teste 2 (Inserir um Exemplar/Livro com dados validos)
DECLARE @test2_controle_exemplar VARCHAR(100)
EXEC controle_exemplar 'I', 2, 77, 'O Pequeno Angelo', 153, '1313131313131', 2, @test2_controle_exemplar OUTPUT
PRINT(@test2_controle_exemplar)
SELECT * FROM Exemplar WHERE codigo_exemplar = 2
SELECT * FROM Livro WHERE ExemplarCodigo = 2

-- teste 3 (Atualizar um Exemplar/Revista com dados validos)
INSERT INTO Exemplar VALUES (3, 77,'Como nao ter sucesso em 10 passos faceis', 11)
INSERT INTO Revista VALUES (3, '36252482')
DECLARE @test3_controle_exemplar VARCHAR(100)
EXEC controle_exemplar 'U', 3, 0, 'Como nao ter sucesso em 6 passos faceis', 10, '36252000', 0, @test3_controle_exemplar OUTPUT
PRINT(@test3_controle_exemplar)
SELECT * FROM Exemplar WHERE codigo_exemplar = 3
SELECT * FROM Revista WHERE ExemplarCodigo = 3

-- teste 4 (Atualizar um Exemplar/Livro com dados validos) 
INSERT INTO Exemplar VALUES (4, 77,'Um Sonho de Talvez Duas Noites de Verao', 201)
INSERT INTO Livro VALUES (4, '3625248287159', 5)
DECLARE @test4_controle_exemplar VARCHAR(100)
EXEC controle_exemplar 'U', 4, 0,'Um Sonho de Talvez Duas Noites de Verao: Agora e pessoal 2', 320, '12548976178000', 3, @test4_controle_exemplar
PRINT(@test4_controle_exemplar)
SELECT * FROM Exemplar WHERE codigo_exemplar = 4
SELECT * FROM Livro WHERE ExemplarCodigo = 4

-- teste 5 (Apagar um Exemplar/Revista) 
INSERT INTO Exemplar VALUES (5, 77, 'Uma Revista muito mais muito MALVADA, que nao deveria existir', 666)
INSERT INTO Revista VALUES (5, '66666666')
DECLARE @test5_controle_exemplar VARCHAR(100)
EXEC controle_exemplar 'D', 5, 0, '', 0, '', 0, @test5_controle_exemplar OUTPUT
PRINT(@test5_controle_exemplar)
SELECT * FROM Exemplar WHERE codigo_exemplar = 5
SELECT * FROM Revista WHERE ExemplarCodigo = 5

-- teste 6 (Apagar um Exemplar/Livro com dados validos) 
INSERT INTO Exemplar VALUES (6, 77, 'Um Livro BOM demais para existir', 777)
INSERT INTO Livro VALUES (6, '7777777777777', 7)
DECLARE @test6_controle_exemplar VARCHAR(100)
EXEC controle_exemplar 'D', 6, 7, '', 0, '', 0, @test6_controle_exemplar OUTPUT
PRINT(@test6_controle_exemplar)
SELECT * FROM Exemplar WHERE codigo_exemplar = 6
SELECT * FROM Livro WHERE ExemplarCodigo = 6

-- teste 7 (Tentar Inserir dados invalidos) TÁ JOGANDO 3 RAISERROS
DECLARE @test7_controle_exemplar VARCHAR(100)
EXEC controle_exemplar 'I', 7, 0, 'Um Livro? Revista? Quem sabe?', 0, '0', 0, @test7_controle_exemplar OUTPUT
PRINT(@test7_controle_exemplar)
SELECT * FROM Exemplar WHERE codigo_exemplar = 7
SELECT * FROM Livro WHERE ExemplarCodigo = 7
SELECT * FROM Revista WHERE ExemplarCodigo = 7

-- teste 8 (Atualizar um Exemplar com dados invalidos)  TA JOGANDO 3 RAIERROS isso é muito erro
INSERT INTO Exemplar VALUES (8, 77, 'Revista Super Velha com DUAS unidades de mofo', 42)
INSERT INTO Revista VALUES (8, '82420261')
DECLARE @test8_controle_exemplar VARCHAR(100)
EXEC controle_exemplar 'U', 8, 0, 'Revista Super atualizada, mas cade o mofo?', 0, '0', 0, @test8_controle_exemplar OUTPUT
PRINT(@test8_controle_exemplar)
SELECT * FROM Exemplar WHERE codigo_exemplar = 8
SELECT * FROM Livro WHERE ExemplarCodigo = 8
GO


--Funcao: realizar_login
-- teste 1 (Insere um login valido, deve retornar 1)
INSERT INTO Aluno VALUES ('02953699066', '2222519080', 'Roberto Anderson Rocha', 'roberto.rocha', 'senha123') 
DECLARE @test1_realizar_login BIT
EXEC realizar_login 'roberto.rocha','', @test1_realizar_login OUTPUT
PRINT(@test1_realizar_login)
GO

--Funcao: controle_inserir_administrador
--Teste 1 (Inserir um Administrador valido)
DECLARE @test1_encontrar_adm VARCHAR(100)
EXEC controle_inserir_administrador 54, 'Luan Drocolebati', 'adm54', 'asenhalongaatacanovamente', @test1_encontrar_adm OUTPUT
PRINT(@test1_encontrar_adm)
SELECT * FROM Administrador WHERE codigo = 54
GO

-------------------------------------------------------------------------------- CRIANDO NOVA FUNCAO ----------------------------------------------------------------------------


