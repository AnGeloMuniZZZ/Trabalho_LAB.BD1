<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Controle de aluno</title>
</head>
<body style="background-color: rgb(51,51,51)">
	<div>
		<h1>Controle de Aluno</h1>
		<form action="controleAluno" method="post">
			<table>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<input type="number" name="cpf" id="cpf" placeholder="CPF" value='<c:out value="${aluno.cpf }"/>'>
					</td>
					<td>
						<input type="submit" name="botao" value="Buscar" class="btn btn-dark">
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<p>RA: <c:out value="${aluno.ra }"/></p>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<p>Nome: <c:out value="${aluno.nome_completo }"/></p>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<p>Email: <c:out value="${aluno.email }"/></p>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<p>Senha: </p>
						<input type="text" name="senha" id="senha" value='<c:out value="${aluno.senha }"/>'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td><input style="margin: 0 2px;" type="submit" name="botao" value="Atualizar" class="btn btn-dark"><td/>
					<td><input type="submit" name="botao" value="Listar" class="btn btn-warning w-100"></td>
				</tr>
			</table>
		</form>
		<a href="loginAdministrador">Deslogar</a>
		<a href="controleExemplar">Cadastrar Exemplares</a>
	</div>
	<br/>
	<div align="center">
		<c:if test="${not empty saida }">
			<h2><c:out value="${saida }"/></h2>
		</c:if>
	</div>
		<div align="center">
		<c:if test="${not empty erro }">
			<h2><c:out value="${erro }"/></h2>
		</c:if>
	</div>
	<div class="conteiner" align="center">
		<c:if test="${not empty alunos }">
			<table>
				<thead>
					<tr>
						<th>CPF</th>
						<th>RA</th>
						<th>Nome Completo</th>
						<th>Email</th>
						<th>Senha</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="a" items="${alunos }">
						<tr>
							<td>${a.cpf }</td>
							<td>${a.ra }</td>
							<td>${a.nome_completo }</td>
							<td>${a.email }</td>
							<td>${a.senha }</td>
							<td><a href="${pageContext.request.contextPath }/controleAluno?acao=editar&id=${a.cpf}">EDITAR</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
</body>
</html>