<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Administrador</title>
</head>
<body style="background-color: rgb(51,51,51)">
	<div align="center" class="login">
		<form method="post" action="loginAdministrador" style="color: white; vertical-align:text-bottom">
		<!-- Lembar de tentar colocar display size max para centralizar na tela -->
			<h1>Login Administrador</h1>
			<table>
				<tr>
					<td>
						<label for="login">Login: </label>
					</td>
					<td colspan="3">
						<input type="text" placeholder="Nome de Usuario" name="login" value='<c:out value="${administrador.usuario }"/>'>
					</td>
				</tr>
				<tr>
					<td>
						<label for="senha">Senha: </label>
					</td>
					<td colspan="3">
						<input type="password" placeholder="Sua senha" name="senhalogin" value='<c:out value="${administrador.senha }"/>'>
					</td>
				</tr>
				<tr>
					<td colspan="4"><input type="submit" value="Logar" name="botao" style="width: 100%"></td>
				</tr>
				<tr>
					<td>
						<a href="index">Entrar como Aluno</a>
						<!-- Diniuir botao e tamanho fonte, se der deixar ele arredondado -->
					</td>
				</tr>
			</table>
		</form>
		
		<div>
			<c:if test="${validar > 0}" >
				<c:if test="${not empty validar}" >
				<h1>Logado com sucesso!!!</h1>
				<a href="controleExemplar">Fazer controle dos exemplares</a>
				<a href="controleAluno">Fazer controle dos alunos</a>
				</c:if>
			</c:if>
			<form action="loginAdministrador" method="post">
				<table>
					<tr style="border-bottom: solid white 12px;">
						<td colspan="4">
							<input type="number" name="codigo" placeholder="Código" value='<c:out value="${administrador.codigo }"/>'>
						</td>
					</tr>
					<tr>
						<td>
							<input type="text" name="nome" placeholder="Nome" value='<c:out value="${administrador.nome }"/>'>	
						</td>
					</tr>
					<tr style="border-bottom: solid white 12px;">
						<td colspan="4">
							<input type="text" name="usuario" placeholder="Nome de usuario" value='<c:out value="${administrador.usuario }"/>'>
						</td>
					</tr>
					<tr style="border-bottom: solid white 12px;">
						<td colspan="4">
							<input type="text" placeholder="Sua senha" name="senha" value='<c:out value="${administrador.senha }"/>'>
						</td>
					</tr>
					<tr style="border-bottom: solid white 12px;">
						<td><input style="margin: 0 2px;" type="submit" name="botao" value="inserir" class="btn btn-dark"><td/>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<div class="conteiner" align="center">
		<c:if test="${not empty saida }">
			<h2><c:out value="${saida }"/></h2>
		</c:if>
	</div>
		<div class="conteiner" align="center">
		<c:if test="${not empty erro }">
			<h2><c:out value="${erro }"/></h2>
		</c:if>
	</div>
</body>
</html>