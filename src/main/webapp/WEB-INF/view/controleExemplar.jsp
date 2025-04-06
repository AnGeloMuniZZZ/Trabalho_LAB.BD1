<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Controle de Exemplares</title>
</head>
<body>
		<div class="conteiner" align="center">
		<h1>Controle de Exemplares</h1>
		<!-- Usando exemplar para mostrar que ambos livro e revista podem ser inseridos -->
		<form action="controleExemplar" method="post">
			<table>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="3">
						<input type="number" name="codigo_exemplar" id="cod" placeholder="Código" value='<c:out value="${livro.codigo_exemplar }"/>'>
					</td>
					<td>
						<input type="submit" name="botao" value="buscar" class="btn btn-dark">
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<input type="text" name="codAdm" id="nome" placeholder="nome" value='<c:out value="${livro.codAdm }"/>'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<input type="text" name="nome" id="nome" placeholder="nome" value='<c:out value="${livro.nome }"/>'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<input type="number" name="qtdPaginas" id="qtdPaginas" value='<c:out value="${livro.qtdPaginas }"/>'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<input type="number" name="siglaExemplar" id="siglaExemplar" placeholder="Codigo de publicação do exemplar" value='<c:out value="${livro.isbn }"/>'>
					</td>
				</tr>
				<tr>
					<td>
						<input type="number" name="edicao" id="edicao" placeholder="Edição" value="<c:out value='${livro.edicao }'/>">
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
                    <td><input type="submit" name="botao" value="Inserir" class="btn btn-success w-100"></td>
                    <td><input type="submit" name="botao" value="Atualizar" class="btn btn-primary w-100"></td>
                    <td><input type="submit" name="botao" value="Excluir" class="btn btn-danger w-100"></td>
                    <td><input type="submit" name="botao" value="Listar" class="btn btn-warning w-100"></td>
				</tr>
			</table>
		</form>
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
		<c:if test="${not empty livros || not empty revistas }">
			<table class=""table table-dark table-striped-columns>
				<thead>
					<tr>
						<th>Codigo Exemplar</th>
						<th>Codigo Administrador</th>
						<th>Nome</th>
						<th>Qtd. Páginas</th>
						<th>ISSN/ISBN</th>
						<th>Edição(Livro)</th>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="l" items="${livros }">
						<tr>
							<td>${e.codigo_exemplar }</td>
							<td>${e.administrador_codigo }</td>
							<td>${e.nome }</td>
							<td>${e.qtd_paginas }</td>
							<td>${e.codI }</td>
							<td>${e.edicao }</td>
							<td><a href="${pageContext.request.contextPath }/controleExemplar?acao=editar&id=${l.exemplarcodigo}">EDITAR</a></td>
							<td><a href="${pageContext.request.contextPath }/controleExemplar?acao=excluir&id=${l.exemplarcodigo}">EXCLUIR</a></td>
						</tr>
					</c:forEach>
					<c:forEach var="r" items="${revistas }">
						<tr>
							<td>${r.codigo_exemplar }</td>
							<td>${r.administrador_codigo }</td>
							<td>${r.nome }</td>
							<td>${r.qtd_paginas }</td>
							<td>${r.codI }</td>
							<td></td>
							<td><a href="${pageContext.request.contextPath }/controleExemplar?acao=editar&id=${r.exemplarcodigo}">EDITAR</a></td>
							<td><a href="${pageContext.request.contextPath }/controleExemplar?acao=excluir&id=${r.exemplarcodigo}">EXCLUIR</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
</body>

</html>
