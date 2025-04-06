<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tela login aluno</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</head>
<body style="background-color: rgb(51,51,51)">
	<div align="center">
		<form method="post" action="aluno" style="color: white; vertical-align:text-bottom">
		<!-- Lembar de tentar colocar display size max para centralizar na tela -->
			<h1>Login Aluno</h1>
			<table>
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
						<a href="aluno">Cadastrar</a>
					</td>
					<td>
						<a href="administrador">Entrar como Administrador</a>
						<!-- Diniuir botao e tamanho fonte, se der deixar ele arredondado -->
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>