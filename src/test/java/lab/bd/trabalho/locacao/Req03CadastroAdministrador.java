package lab.bd.trabalho.locacao;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.fail;

import java.sql.SQLException;

import org.junit.jupiter.api.Test;

import lab.bd.trabalho.locacao.model.Administrador;
import lab.bd.trabalho.locacao.model.Aluno;
import lab.bd.trabalho.locacao.persistence.AdministradorDao;
import lab.bd.trabalho.locacao.persistence.AlunoDao;

public class Req03CadastroAdministrador {

	@Test
	void ct01Cadastro_Adm() {
		Administrador adm = new Administrador();
		adm.setCodigo(100);
		adm.setNome("Administrador Teste");
		adm.setSenha("senha123");
		adm.setUsuario("Teste");
		AdministradorDao aDao = new AdministradorDao();
		try {
			assertEquals("ADMINISTRADOR CADASTRADO YAY :)", aDao.inserir(adm));
			//Só funciona na primeira vez o teste, já que não é possivel deletar o usuario criado
		} catch (ClassNotFoundException | SQLException e) {
			fail("erro na insercao " + e.getMessage());
			System.out.println(e.getMessage());
		}
	}
	
	@Test
	void ct02Cadastrar_Incorretamente() {
		Administrador adm = new Administrador();
		adm.setCodigo(77);
		adm.setNome("Administrador Teste Errado");
		adm.setSenha("senha123456");
		adm.setUsuario("Teste Errado");
		AdministradorDao aDao = new AdministradorDao();
		try {
			aDao.inserir(adm);
		} catch (ClassNotFoundException | SQLException e) {
			assertEquals("Codigo de ADM ja cadastrado", e.getMessage());
		}

	}

}
