package lab.bd.trabalho.locacao;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.fail;

import java.sql.SQLException;

import org.junit.jupiter.api.Test;

import lab.bd.trabalho.locacao.model.Aluno;
import lab.bd.trabalho.locacao.persistence.AlunoDao;

public class Req02CadastroAluno {

	@Test
	void ct01Cadastrar_Aluno() {
		Aluno aluno = new Aluno();
		aluno.setCpf("10558103669");
		aluno.setNome_completo("Nome Muito Feito de Testes Criativos");
		aluno.setSenha("senha123");
		AlunoDao aDao = new AlunoDao();
		try {
			assertEquals("Aluno(a) Nome Muito Feito de Testes Criativos INSERIDO(A) com sucesso", aDao.inserir(aluno));
			//Só funciona na primeira vez o teste, já que não é possivel deletar o usuario criado
		} catch (ClassNotFoundException | SQLException e) {
			fail("erro na insercao " + e.getMessage());
			System.out.println(e.getMessage());
		}
	}

	@Test
	void ct02Cadastrar_Incorretamente() {
		Aluno aluno = new Aluno();
		aluno.setCpf("1066");
		aluno.setNome_completo("Nome Certinho");
		aluno.setSenha("Erada");
		AlunoDao aDao = new AlunoDao();
		try {
			aDao.inserir(aluno);
		} catch (ClassNotFoundException | SQLException e) {
			assertEquals("Dados de entrada invalidos", e.getMessage());
		}

	}

}
