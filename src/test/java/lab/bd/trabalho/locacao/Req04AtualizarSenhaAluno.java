package lab.bd.trabalho.locacao;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.fail;

import java.sql.SQLException;

import org.junit.jupiter.api.Test;

import lab.bd.trabalho.locacao.model.Aluno;
import lab.bd.trabalho.locacao.persistence.AlunoDao;

public class Req04AtualizarSenhaAluno {

	@Test
	void ct01Atualizar_Aluno() {
		Aluno aluno = new Aluno();
		aluno.setCpf("02953699066");
		aluno.setSenha("senha111");
		AlunoDao aDao = new AlunoDao();
		try {
			assertEquals("Aluno(a) ATUALIZADO(A) com sucesso", aDao.atualizar(aluno));
			//Só funciona na primeira depois ele "atualiza" ela por cima dela mesma
		} catch (ClassNotFoundException | SQLException e) {
			fail("erro na insercao " + e.getMessage());
			System.out.println(e.getMessage());
		}
	}

	@Test
	void ct02Atualizar_Incorretamente() {
		Aluno aluno = new Aluno();
		aluno.setCpf("02953699066");
		aluno.setSenha("Erada");
		AlunoDao aDao = new AlunoDao();
		try {
			aDao.atualizar(aluno);
		} catch (ClassNotFoundException | SQLException e) {
			assertEquals("Senha invalida ou CPF nao encontrado", e.getMessage());
		}

	}
	
}
