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

	<div>
		<div align="center">
			<form action="cadastroAluno" method="post">
				<h1 class="h1_titulo">Cadastro de Aluno</h1>
				<table>
					<tr>
						<td colspan="2"><label for="CPF">CPF:</label></td>
						<td colspan="3"><input type="number" name="cpf" id="cpf"
							placeholder="xxx.xxx.xxx-xx"
							value='<c:out value="${aluno.cpf }"/>'></td>
					</tr>
					<tr>
						<td colspan="2"><label for="Nome_Completo">Nome
								Completo:</label></td>
						<td colspan="3"><input type="text" name="nome_completo"
							id="nome" placeholder="Digite seu nome completo"
							value='<c:out value="${aluno.nome_completo }"/>'></td>
					</tr>
					<tr>
						<td colspan="2"><label for="Senha">Senha:</label></td>
						<td colspan="3"><input type="password" name="senha"
							id="senha" placeholder="Digite uma senha"
							value='<c:out value="${aluno.senha }"/>'></td>
					</tr>
					<tr>
						<td colspan="4">
							<div style="display: flex; align-items: center; gap: 25px;">
								<input type="submit" name="botao" value="inserir"> <a
									href="index" class="a_link_clicavel">Voltar ao login</a>
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>

		<div>
			<c:if test="${not empty saida }">
				<h2 class="h2_mensagem_VALIDACAO">
					<c:out value="${saida }" />
				</h2>
				<div class="div_h2">
					<h2 class="h2_mensagem_DADOS">Seu nome de usuário é:
						${aluno.email }</h2>
					<h2 class="h2_mensagem_DADOS">Seu ra é: ${aluno.ra }</h2>
				</div>
			</c:if>
			<c:if test="${not empty erro }">
				<h2 class="h2_mensagem_ERRO">
					<c:out value="${erro }" />
				</h2>
			</c:if>
		</div>



	</div>

</body>
</html>