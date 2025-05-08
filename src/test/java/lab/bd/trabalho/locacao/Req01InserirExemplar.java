package lab.bd.trabalho.locacao;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.fail;

import java.sql.SQLException;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import lab.bd.trabalho.locacao.model.Livro;
import lab.bd.trabalho.locacao.persistence.LivroDao;

@SpringBootTest
class Req01InserirExemplar {
	
     
	@Test
	void ct01Inserir_Funcional() {
		Livro livro = new Livro(250, "5784692461856", 3);
		livro.setCodigo_exemplar(250);
		livro.setAdministrador_codigo(77);
		livro.setNome("O pequeno Renato");
		livro.setQtd_paginas(180);
		LivroDao lDao = new LivroDao();
		try {
			assertEquals("EXEMPLAR e LIVRO inseridos com sucesso", lDao.inserir(livro));
			lDao.excluir(livro);
		} catch (ClassNotFoundException | SQLException e) {
			fail("erro na insercao " + e.getMessage());
			System.out.println(e.getMessage());
		}
	
	}
	
	@Test
	void ct02Inserir_Ja_Existente() {
		Livro livro = new Livro(4, "5784692461856", 10);
		livro.setCodigo_exemplar(4);
		livro.setAdministrador_codigo(77);
		livro.setNome("O erro que ja existe");
		livro.setQtd_paginas(20);
		LivroDao lDao = new LivroDao();
		try {
			lDao.inserir(livro);
		} catch (ClassNotFoundException | SQLException e) {
			assertEquals("Nao foi possivel Inserir um EXEMPLAR Verifique(COD_Exemplar, COD_ADM, ISBN_ISSN)", e.getMessage());
		}
	
	}
	
	
}
