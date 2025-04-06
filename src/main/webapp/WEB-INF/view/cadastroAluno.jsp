<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cadastro Aluno</title>
<link rel="stylesheet" href="./css/css_stylesheet.css">
</head>
<body>

	<div class=div_gata_sora__direita></div>
	<div class=div_gata_sora__esquerda></div>

	<div align="center" class="div_login">
		<div>
			<form action="cadastroAluno" method="post">
				<h1 class="h1_titulo">Cadastro de Aluno</h1>
				<table>
					<tr>
						<td><label for="CPF">CPF:</label></td>
						<td colspan="2"><input type="number" name="cpf" id="cpf"
							placeholder="xxx.xxx.xxx-xx"
							value='<c:out value="${aluno.cpf }"/>'></td>
					</tr>
					<tr>
						<td><label for="Nome_Completo">Nome Completo:</label></td>
						<td colspan="5"><input type="text" name="nome_completo"
							id="nome" placeholder="Digite seu nome completo"
							value='<c:out value="${aluno.nome_completo }"/>'></td>
					</tr>
					<tr>
						<td><label for="Senha">Senha:</label></td>
						<td colspan="2"><input type="password" name="senha"
							id="senha" placeholder="Digite uma senha"
							value='<c:out value="${aluno.senha }"/>'></td>
					</tr>
					<tr>
						<td><input type="submit" name="botao" value="inserir">
							<a href="index" class="a_link_clicavel">Voltar ao login</a>
						<td />
					</tr>
				</table>
			</form>
		</div>

		<div style="margin-top: 15px;">
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

		<div id="dado_oculto">
			<h2>Seu nome de usuário é: ${aluno.email }</h2>
			<h2>Seu ra é: ${aluno.ra }</h2>
		</div>


	</div>
</body>
</html>