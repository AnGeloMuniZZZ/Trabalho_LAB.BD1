<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Controle de Exemplares</title>
<link rel="stylesheet" href="./css/css_stylesheet.css">
</head>
<body>
	<div class=div_gata_sora__direita></div>
	<div class=div_gata_sora__esquerda></div>

	<div div align="center" class="div_degrade">

		<div>
			<form action="controleExemplar" method="post">
				<h1>Controle de Exemplares</h1>
				<table>
					<tr>
						<td colspan="1"><label for="codigo_exemplar">Cód.
								Exemplar:</label></td>
						<td colspan="2"><input type="number" name="codigo_exemplar"
							id="cod" placeholder="Código"
							value='<c:out value="${livro.codigo_exemplar }"/>'></td>
						<td colspan="1"><input type="submit" name="botao"
							value="Buscar"></td>
					</tr>
					<tr>
						<td colspan="1"><label for="administrador_codigo">Cód.
								Administrador:</label></td>
						<td colspan="3"><input type="text"
							name="administrador_codigo" id="nome"
							placeholder="Codigo do administrador"
							value='<c:out value="${livro.administrador_codigo }"/>'></td>
					</tr>
					<tr>
						<td colspan="1"><label for="nome">Titulo do Exemplar:</label></td>
						<td colspan="3"><input type="text" name="nome" id="nome"
							placeholder="Nome" value='<c:out value="${livro.nome }"/>'></td>
					</tr>
					<tr>
						<td colspan="1"><label for="qtd_paginas">Qnt.
								Paginas:</label></td>
						<td colspan="3"><input type="number" name="qtd_paginas"
							id="qtdPaginas" placeholder="Quantidade de Páginas"
							value='<c:out value="${livro.qtd_paginas }"/>'></td>
					</tr>
					<tr>
						<td colspan="1"><label for="sigla">ISBN / ISSN:</label></td>
						<td colspan="3"><input type="number" name="sigla"
							id="siglaExemplar" placeholder="Codigo de publicação do exemplar"
							value='<c:out value="${livro.sigla }"/>'></td>
					</tr>
					<tr>
						<td colspan="1"><label for="edicao">Num. Edicao:</label></td>
						<td colspan="3"><input type="number" name="edicao"
							id="edicao" placeholder="Edição"
							value="<c:out value='${edicao }'/>"></td>
					</tr>

					<tr>
						<td colspan="1"><input style="width: 100%" type="submit"
							name="botao" value="Inserir"></td>
						<td colspan="1"><input style="width: 100%" type="submit"
							name="botao" value="Atualizar"></td>
						<td colspan="1"><input style="width: 100%" type="submit"
							name="botao" value="Excluir"></td>
						<td colspan="1"><input style="width: 100%" type="submit"
							name="botao" value="Listar"></td>
					</tr>
				</table>
			</form>
		</div>

		<br />
		<div>
			<a class="a_link_clicavel" href="loginAdministrador">Deslogar</a> <a
				class="a_link_clicavel" href="controleAluno">Controle de Alunos</a>
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
			<c:if test="${not empty livros}">
				<c:if test="${not empty revistas }">
					<table class="table_border table tabela_restricao">
						<thead>
							<tr>
								<th>Cod. Exemplar</th>
								<th>Cod. Adm</th>
								<th>Nome</th>
								<th>Qtd. Pág</th>
								<th>ISSN/ISBN</th>
								<th>Edição</th>
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
									<td><a class="a_link_clicavel"
										href="${pageContext.request.contextPath }/controleExemplar?acao=editar&id=${l.codigo_exemplar}">EDITAR</a></td>
									<td><a class="a_link_clicavel"
										href="${pageContext.request.contextPath }/controleExemplar?acao=excluir&id=${l.codigo_exemplar}">EXCLUIR</a></td>
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
									<td><a class="a_link_clicavel"
										href="${pageContext.request.contextPath }/controleExemplar?acao=editar&id=${r.codigo_exemplar}">EDITAR</a></td>
									<td><a class="a_link_clicavel"
										href="${pageContext.request.contextPath }/controleExemplar?acao=excluir&id=${r.codigo_exemplar}">EXCLUIR</a></td>
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
