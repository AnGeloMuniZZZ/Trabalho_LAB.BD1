<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Controle de aluno</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</head>
<body style="background-color: rgb(51,51,51)">
	<div>
		<h1>Controle de Aluno</h1>
		<form action="aluno" method="post">
			<table>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<input type="number" name="cpf" id="cpf" placeholder="CPF" value='<c:out value="${aluno.cpf }"/>'>
					</td>
					<td>
						<input type="submit" name="botao" value="buscar" class="btn btn-dark">
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<p><c:out value="${aluno.ra }"/></p>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<p><c:out value="${aluno.nome_completo }"/></p>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<p><c:out value="${aluno.email }"/></p>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<input type="text" name="senha" id="senha" value='<c:out value="${aluno.senha }"/>'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td><input style="margin: 0 2px;" type="submit" name="botao" value="atualizar" class="btn btn-dark"><td/>
				</tr>
			</table>
		</form>
		<input type="button" name="voltar" id="voltar" onclick="location.href='locacao'" value="Deslogar">
		<a href="controleExemplar">Cadastrar Exemplares</a>
	</div>
	<br/>
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
	<div class="conteiner" align="center">
		<c:if test="${not empty alunos }">
			<table class=""table table-dark table-striped-columns>
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