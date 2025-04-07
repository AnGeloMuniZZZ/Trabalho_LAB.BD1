<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Visualização dos Exemplares</title>
</head>
<body>
		<div class="conteiner" align="center">
		<h1>Visualização dos Exemplares</h1>
		<form action="visualizarExemplar" method="post">
			<table>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="3">
						<input type="number" min="0" step="1" name="cod" id="cod" placeholder="Código" value='<c:out value="${livro.codigo_exemplar }"/>'>
					</td>
					<td>
						<input type="submit" name="botao" value="buscar" class="btn btn-dark">
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<p><c:out value="${livro.nome }"/></p>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<p><c:out value="${livro.qtd_paginas }"/></p>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<p><c:out value="${livro.sigla }"/></p>
					</td>
				</tr>
				<tr>
					<td>
						<p><c:out value="${edicao }"/></p>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td><input style="margin: 0 2px;" type="submit" name="botao" value="listar" class="btn btn-dark"><td/>
				</tr>
			</table>
		</form>
	</div>
	<br/>
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
		<c:if test="${not empty livros}"> 
			<c:if test="${not empty revistas }">
				<table>
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
								<td>${l.codigo_exemplar }</td>
								<td>${l.administrador_codigo }</td>
								<td>${l.nome }</td>
								<td>${l.qtd_paginas }</td>
								<td>${l.sigla }</td>
								<td>${l.edicao }</td>
								<td><a href="${pageContext.request.contextPath }/visualizarExemplar?acao=editar&id=${l.codigo_exemplar}">VER</a></td>
							</tr>
						</c:forEach>
						<c:forEach var="r" items="${revistas }">
							<tr>
								<td>${r.codigo_exemplar }</td>
								<td>${r.administrador_codigo }</td>
								<td>${r.nome }</td>
								<td>${r.qtd_paginas }</td>
								<td>${r.sigla }</td>
								<td></td>
								<td><a href="${pageContext.request.contextPath }/visualizarExemplar?acao=editar&id=${r.codigo_exemplar}">VER</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
		</c:if>
	</div>
</body>
</html>