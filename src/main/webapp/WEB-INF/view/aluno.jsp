<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<title>Aluno</title>
</head>
<body style="background-color: rgb(51,51,51)">
	<div>
		<h1>Cadastro de Aluno</h1>
		<form action="pessoa" method="post">
			<table>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<input type="number" name="cpf" id="cpf" placeholder="CPF" value='<c:out value="${aluno.cpf }"/>'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<input type="text" name="nome" id="nome" placeholder="Nome completo" value='<c:out value="${aluno.nome }"/>'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<input type="text" name="senha" id="senha" value='<c:out value="${aluno.senha }"/>'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td><input style="margin: 0 2px;" type="submit" name="botao" value="inserir" class="btn btn-dark"><td/>
				</tr>
			</table>
		</form>
		<h2>Seu nome de usuário é: <c:out value="${aluno.email }"/></h2>
		<h2>Seu ra é: <c:out value="${aluno.ra } "/></h2>
		<input type="button" name="voltar" id="voltar" onclick="location.href='locacao'" value="Voltar ao login">
	</div>
</body>
</html>