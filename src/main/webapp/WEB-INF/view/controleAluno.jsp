<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Controle de aluno</title>
<link rel="stylesheet" href="./css/css_stylesheet.css">
</head>
<body>
	<div class=div_gata_sora__direita></div>
	<div class=div_gata_sora__esquerda></div>

	<div align="center" class="div_degrade">

		<div>
			<form action="controleAluno" method="post">
				<h1 class="h1_titulo">Controle de Aluno</h1>
				<table>
					<tr>
						<td colspan="1"><label for="CPF">CPF: </label></td>
						<td colspan="3"><input type="number" name="cpf" id="cpf"
							placeholder="CPF" value='<c:out value="${aluno.cpf }"/>'></td>
						<td colspan="1"><input type="submit" name="botao"
							value="Buscar"></td>
					</tr>
					<tr>
						<td colspan="1" class="td_alinhar_justo"><p>RA:</p></td>
						<td colspan="5"><p>
								<c:out value="${aluno.ra }" />
							</p></td>
					</tr>
					<tr>
						<td colspan="1"><p>Nome:</p></td>
						<td colspan="5"><p>
								<c:out value="${aluno.nome_completo }" />
							</p></td>
					</tr>
					<tr>
						<td colspan="1"><p>Email:</p></td>
						<td colspan="5"><p>
								<c:out value="${aluno.email }" />
							</p></td>
					</tr>
					<tr>
						<td colspan="1"><p>Senha:</p></td>
						<td colspan="5"><input type="text" name="senha" id="senha"
							placeholder="Senha" value='<c:out value="${aluno.senha }"/>'></td>
					</tr>
					<tr>
						<td colspan="2"><input style="width: 100%" type="submit"
							name="botao" value="Atualizar"></td>
						<td colspan="3"><input style="width: 100%" type="submit"
							name="botao" value="Listar"></td>
					</tr>
				</table>
			</form>
		</div>

		<div>
			<br /> <a class="a_link_clicavel" href="loginAdministrador">Deslogar</a>
			<a class="a_link_clicavel" href="controleExemplar">Cadastrar
				Exemplares</a>
		</div>

		<br />

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

		<div>
			<c:if test="${not empty alunos }">
				<table class="table_border table">
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
								<td><a class="a_link_clicavel"
									href="${pageContext.request.contextPath }/controleAluno?acao=editar&id=${a.cpf}">EDITAR</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
		</div>

	</div>

</body>
</html>