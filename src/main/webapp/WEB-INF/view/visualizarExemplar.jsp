<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Visualização dos Exemplares</title>
<link rel="stylesheet" href="./css/css_stylesheet.css">
</head>
<body>

	<div class=div_gata_sora__direita></div>
	<div class=div_gata_sora__esquerda></div>
	<div div align="center" class="div_degrade">
	<div>
		<form action="visualizarExemplar" method="post">
			<h1>Visualização dos Exemplares</h1>
			<table>
				<tr >
					<td colspan="1"><label for="cod">Cód. Exemplar:</label></td>
					<td colspan="1"><input type="number" min="0" step="1" name="cod" id="cod" placeholder="Código" value='<c:out value="${livro.codigo_exemplar }"/>'></td>
					<td colspan="1"><input type="submit" name="botao" value="buscar"></td>
				</tr>
				<tr>
					<td colspan="1"><label for="nome">Nome:</label></td>
					<td colspan="2"><p><c:out value="${livro.nome }"/></p></td>
				</tr>
				<tr>
					<td colspan="1"><label for="qtd_paginas">Qtd. paginas:</label></td>
					<td colspan="2"><p><c:out value="${livro.qtd_paginas }"/></p></td>
				</tr>
				<tr>
					<td colspan="1"><label for="sigla">Sigla:</label></td>
					<td colspan="2"><p><c:out value="${livro.sigla }"/></p></td>
				</tr>
				<tr>
					<td colspan="1"><label for="edicao">Edicao:</label></td>
					<td colspan="2"><p><c:out value="${edicao }"/></p></td>
				</tr>
				<tr>
					<td colspan="3"><input style="width: 100%" type="submit" name="botao" value="listar"><td/>
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
				<table class="table_border table tabela_restricao">
					<thead>
						<tr>
							<th>Codigo Exemplar</th>
							<th>Codigo Administrador</th>
							<th>Nome</th>
							<th>Qtd. Páginas</th>
							<th>ISSN/ISBN</th>
							<th>Edição</th>
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
								<td><a class="a_link_clicavel" href="${pageContext.request.contextPath }/visualizarExemplar?acao=editar&id=${l.codigo_exemplar}">VER</a></td>
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
								<td><a class="a_link_clicavel" href="${pageContext.request.contextPath }/visualizarExemplar?acao=editar&id=${r.codigo_exemplar}">VER</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
		</c:if>
	</div>
	</div>
	
	
</body>
</html>