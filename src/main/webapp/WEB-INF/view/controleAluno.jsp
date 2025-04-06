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
						<input type="text" name="nome" id="nome" placeholder="Nome completo" value='<c:out value="${aluno.nome }"/>'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<input type="text" name="nome" id="nome" placeholder="Nome completo" value='<c:out value="${aluno.ra }"/>'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<input type="text" name="senha" id="senha" value='<c:out value="${aluno.senha }"/>'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td><input style="margin: 0 2px;" type="submit" name="botao" value="atualizar" class="btn btn-dark"><td/>
					<td><p>Obs. O CPF e o nome <b>NÂO</b> são alteráveis.</p></td>
				</tr>
			</table>
		</form>
		<input type="button" name="voltar" id="voltar" onclick="location.href='locacao'" value="Voltar ao login">
	</div>
</body>
</html>