<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tela login aluno</title>
<link rel="stylesheet" href="./css/teste1.css">
</head>

<body>
	<div class=div_sora_direita></div>
	<div class=div_sora> </div>
	<br/>
	<div align="center"	class=login>
		<form method="post" action="visualizarExemplar" style="color: white; vertical-align:text-bottom">
		<!-- Lembar de tentar colocar display size max para centralizar na tela -->
			<h1>Login Aluno</h1>
			<table class="table_round">
				<tr>
					<td>
						<label for="login">Login: </label>
					</td>
					<td colspan="3">
						<input type="text" placeholder="Nome de Usuario" name="login" value='<c:out value="${aluno.email }"/>'>
					</td>
				</tr>
				<tr>
					<td>
						<label for="senha">Senha: </label>
					</td>
					<td colspan="3">
						<input type="text" placeholder="Sua senha" name="senha" value='<c:out value="${aluno.senha }"/>'>
					</td>
				</tr>
				<tr>
					<td colspan="4"><input type="submit" value="Logar" name="botao" style="width: 100%"></td>
				</tr>
				<tr>
					<td>
						<a href="cadastroAluno">Cadastrar</a>
					</td>
					<td>
						<a href="loginAdministrador">Entrar como Administrador</a>
						<!-- Diniuir botao e tamanho fonte, se der deixar ele arredondado -->
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>