package lab.bd.trabalho.locacao;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.fail;

import java.sql.SQLException;

import org.junit.jupiter.api.Test;

import lab.bd.trabalho.locacao.model.Aluno;
import lab.bd.trabalho.locacao.persistence.AlunoDao;

public class Req05LoginAluno {

	@Test
	void ct01Logar_Aluno() {
		Aluno aluno = new Aluno();
		aluno.setCpf("02953699066");
		AlunoDao aDao = new AlunoDao();
		try {
			aluno = aDao.buscar(aluno);
			assertEquals(1, aDao.realizarLogin(aluno));
			//Só funciona na primeira depois ele "atualiza" ela por cima dela mesma
		} catch (ClassNotFoundException | SQLException e) {
			fail("erro na insercao " + e.getMessage());
			System.out.println(e.getMessage());
		}
	}

	@Test
	void ct02Login_Incorreto_Aluno() {
		Aluno aluno = new Aluno();
		aluno.setCpf("02953699066");
		AlunoDao aDao = new AlunoDao();
		try {
			aDao.buscar(aluno);
			aluno.setEmail("Teste.Erronius");
			aDao.realizarLogin(aluno);
		} catch (ClassNotFoundException | SQLException e) {
			assertEquals("Usuario ou Senha Invalidos", e.getMessage());
		}

	}
}
