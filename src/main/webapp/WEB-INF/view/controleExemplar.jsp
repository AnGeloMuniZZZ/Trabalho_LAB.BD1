<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Controle de Exemplares</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

</head>
<body>
		<div class="conteiner" align="center">
		<h1>Controle de Exemplares</h1>
		<!-- Usando exemplar para mostrar que ambos livro e revista podem ser inseridos -->
		<form action="exemplar" method="post">
			<table>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="3">
						<input type="number" min="0" step="1" name="cod" id="cod" placeholder="Código" value='<c:out value="${exemplar.codigo_exemplar }"/>'>
					</td>
					<td>
						<input type="submit" name="botao" value="buscar" class="btn btn-dark">
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<input type="text" name="nome" id="nome" placeholder="nome" value='<c:out value="${exemplar.nome }"/>'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<input type="number" name="qtdPaginas" id="qtdPaginas" value='<c:out value="${exemplar.qtdPaginas }"/>'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<input type="text" name="email" id="email" placeholder="email" value='<c:out value="${pessoa.email }"/>'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td><input style="margin: 0 2px;" type="submit" name="botao" value="inserir" class="btn btn-dark"><td/>
					<td><input style="margin: 0 2px;" type="submit" name="botao" value="deletar" class="btn btn-dark"><td/>
					<td><input style="margin: 0 2px;" type="submit" name="botao" value="atualizar" class="btn btn-dark"><td/>
					<td><input style="margin: 0 2px;" type="submit" name="botao" value="listar" class="btn btn-dark"><td/>
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
		<c:if test="${not empty pessoas }">
			<table class=""table table-dark table-striped-columns>
				<thead>
					<tr>
						<th>ID</th>
						<th>Nome</th>
						<th>Nascimento</th>
						<th>Email</th>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="p" items="${pessoas }">
						<tr>
							<td>${p.id }</td>
							<td>${p.nome }</td>
							<td>${p.dtNasc }</td>
							<td>${p.email }</td>
							<td><a href="${pageContext.request.contextPath }/pessoa?acao=editar&id=${p.id}">EDITAR</a></td>
							<td><a href="${pageContext.request.contextPath }/pessoa?acao=excluir&id=${p.id}">EXCLUIR</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
</body>
</html>
