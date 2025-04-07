<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Administrador</title>
<link rel="stylesheet" href="./css/css_stylesheet.css">
</head>
<body>
	<div class=div_gata_sora__direita></div>
	<div class=div_gata_sora__esquerda></div>

	<div>

		<div align="center">
			<form method="post" action="loginAdministrador">
				<h1 class="h1_titulo">Login Administrador</h1>
				<table>
					<tr>
						<td colspan="2"><label for="login">Login: </label></td>
						<td colspan="3"><input type="text"
							placeholder="Nome de Usuario" name="login"
							value='<c:out value="${administrador.usuario }"/>'></td>
					</tr>
					<tr>
						<td colspan="2"><label for="senha">Senha: </label></td>
						<td colspan="3"><input type="password"
							placeholder="Sua senha" name="senhalogin"
							value='<c:out value="${administrador.senha }"/>'></td>
					</tr>
					<tr>
						<td colspan="4">
							<div style="display: flex; align-items: center; gap: 10px;">
								<input type="submit" value="Logar" name="botao"> <a
									href="index" class="a_link_clicavel">Entrar como Aluno</a>
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>

		<br />

		<div>
			<c:if test="${validar > 0}">
				<c:if test="${not empty validar}">
					<h1 class="h2_mensagem_VALIDACAO">Logado com sucesso!!!</h1>
					<a href="controleExemplar" class="a_link_clicavel">Fazer
						controle dos exemplares</a>
					<a href="controleAluno" class="a_link_clicavel">Fazer controle
						dos alunos</a>
				</c:if>
			</c:if>
		</div>

		<div align="center">
			<form action="loginAdministrador" method="post">
				<h1 class="h1_titulo">Cadastro de Administrador</h1>
				<table>
					<tr>
						<td colspan="2"><label for="codigo">Cod. ADM: </label></td>
						<td colspan="3"><input type="number" name="codigo"
							placeholder="Código"
							value='<c:out value="${administrador.codigo }"/>'></td>
					</tr>
					<tr>
						<td colspan="2"><label for="nome">Nome do ADM: </label></td>
						<td colspan="3"><input type="text" name="nome"
							placeholder="Nome"
							value='<c:out value="${administrador.nome }"/>'></td>
					</tr>
					<tr>
						<td colspan="2"><label for="usuario">Usuario: </label></td>
						<td colspan="3"><input type="text" name="usuario"
							placeholder="Usuario"
							value='<c:out value="${administrador.usuario }"/>'></td>
					</tr>
					<tr>
						<td colspan="2"><label for="Senha">Senha: </label></td>
						<td colspan="3"><input type="text" placeholder="Sua senha"
							name="senha" value='<c:out value="${administrador.senha }"/>'></td>
					</tr>
					<tr>
						<td colspan="8"><input style="width: 100%" type="submit"
							name="botao" value="Inserir">
						<td />
					</tr>
				</table>
			</form>
		</div>

		<div>
			<c:if test="${not empty saida }">
				<h2 class="h2_mensagem_VALIDACAO">
					<c:out value="${saida }" />
				</h2>
			</c:if>
			<c:if test="${not empty erro }">
				<h2 class="h2_mensagem_ERRO">
					<c:out value="${erro }" />
				</h2>
			</c:if>
		</div>
		
	</div>

</body>
</html>