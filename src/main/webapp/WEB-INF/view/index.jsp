<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tela login aluno</title>
<link rel="stylesheet" href="./css/css_stylesheet.css">
</head>

<body>
	<div class=div_gata_sora__direita></div>
	<div class=div_gata_sora__esquerda></div>
	<br />
	
	<div align="center" class=div_login>
		<div>
			<form method="post" action="index">
				<h1 class=h1_titulo>Login Aluno</h1>
				<table>
					<tr>
						<td><label for="login">Login: </label></td>
						<td colspan="4"><input type="text" style="width: 95%"
							placeholder="Nome de Usuario" name="login"
							value='<c:out value="${aluno.email }"/>'></td>
					</tr>
					<tr>
						<td><label for="senha">Senha: </label></td>
						<td colspan="4"><input type="password" style="width: 95%"
							placeholder="Sua senha" name="senha"
							value='<c:out value="${aluno.senha }"/>'></td>
					</tr>
					<tr>
						<td colspan="4"><input type="submit" value="Logar"
							name="botao" style="width: 100%"></td>
					</tr>
					<tr>
						<td><a href="cadastroAluno" class="a_link_clicavel">Cadastrar</a>
						</td>
						<td><a href="loginAdministrador" class="a_link_clicavel">Entrar
								como Administrador</a></td>
					</tr>
				</table>
			</form>
		</div>
		
		<div>
			<c:if test="${validar > 0}">
				<c:if test="${not empty validar}">
					<h1 class="h2_mensagem_VALIDACAO">Logado com sucesso!!!</h1>
					<a href="visualizarExemplar" class="a_link_clicavel">Alugar exemplares</a>
					<h1 class="h2_mensagem_ERRO">Aluguel não disponivel ainda!</h1>
				</c:if>
			</c:if>
		</div>

		<div>
			<c:if test="${not empty saida }">
				<h2 class="h2_mensagem_VALIDACAO"> <c:out value="${saida }" /></h2>
			</c:if>
			<c:if test="${not empty erro }">
				<h2 class="h2_mensagem_ERRO"><c:out value="${erro }" /></h2>
			</c:if>
		</div>
	</div>
</body>
</html>