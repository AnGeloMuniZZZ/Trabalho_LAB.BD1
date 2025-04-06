package lab.bd.trabalho.locacao.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import lab.bd.trabalho.locacao.model.Administrador;
import lab.bd.trabalho.locacao.model.Livro;
import lab.bd.trabalho.locacao.model.Revista;
import lab.bd.trabalho.locacao.persistence.LivroDao;
import lab.bd.trabalho.locacao.persistence.RevistaDao;

@Controller
public class ControleExemplarController {

	@Autowired
	private LivroDao lDao;
	@Autowired
	private RevistaDao rDao;
	
	@RequestMapping(name = "controleExemplar", value = "/controleExemplar", method = RequestMethod.GET)
	public ModelAndView pessoaGet(@RequestParam Map<String, String> params, ModelMap model) {
		String acao = params.get("acao");
		String exemplarcodigo = params.get("exemplarcodigo");
		Livro l = new Livro();
		List<Livro> livros = new ArrayList<>();
		Revista r = new Revista();
		List<Revista> revistas = new ArrayList<>();
		String erro = "";
		
		//Verificar se é um livro ou revista pelo codigo do exemplar usando o codigo de exemplar
		l.setExemplarcodigo(Integer.parseInt(exemplarcodigo));
		char verifica = lDao.descobrirSigla(l);
		
		try {
			if(verifica == 'L') {
				if (exemplarcodigo != null && !exemplarcodigo.isBlank()) {
					l.setExemplarcodigo(Integer.parseInt(exemplarcodigo));
					if (acao.equals("excluir")) {
						lDao.excluir(l);
						livros = lDao.listar();
						l = null;
					} else if (acao.equals("editar")) {
						l = lDao.buscar(l);
						livros = null;
					}
				} 
			}else {
				if (exemplarcodigo != null && !exemplarcodigo.isBlank()) {
					l.setExemplarcodigo(Integer.parseInt(exemplarcodigo));
					if (acao.equals("excluir")) {
						rDao.excluir(r);
						revistas = rDao.listar();
						r = null;
					} else if (acao.equals("editar")) {
						r = rDao.buscar(r);
						revistas = null;
					}
				}
			} 
		}catch (SQLException | ClassNotFoundException e) {
			e.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("livro", l);
			model.addAttribute("livros", livros);
			model.addAttribute("revista", r);
			model.addAttribute("revistas", revistas);
		}
		return new ModelAndView("controleExemplar");
	}
	
	@RequestMapping(name = "controleExemplar", value = "/controleExemplar", method = RequestMethod.POST)
	public ModelAndView pessoaPost(@RequestParam Map<String, String> params, ModelMap model) {
		String codigoExemplar = params.get("codigo_exemplar");
		String nome = params.get("nome");
		String qtdPaginas = params.get("qtdPaginas");
		String issnisbn = params.get("siglaExemplar");
		String edicao = params.get("edicao");
		String cmd = params.get("botao");
		
		Livro l = new Livro();
		if (!cmd.equalsIgnoreCase("Listar")) {
			l.setCodigo_exemplar(Integer.parseInt(codigoExemplar));
		}
		if (cmd.contentEquals("Inserir"))  {
			l.setCodigo_exemplar(Integer.parseInt(codigoExemplar));
			l.setNome(nome);
			l.setQtd_paginas(Integer.parseInt(qtdPaginas));
			LoginAdministradorController id;
			Administrador atual = id.atual;
			l.setAdministrador_codigo(0);
			l.setEdicao(Integer.parseInt(edicao));
		} else if (cmd.equalsIgnoreCase("Atualizar")) {
			l.setNome(nome);
			l.setQtd_paginas(Integer.parseInt(qtdPaginas));
			l.setEdicao(Integer.parseInt(edicao));
		}
		
		String saida = "";
		String erro = "";
		List<Livro> livros = new ArrayList<Livro>();
		
		try {
			if (cmd.equalsIgnoreCase("Inserir")) {
				saida = cDao.inserir(c);
			}
			if (cmd.equalsIgnoreCase("Atualizar")) {
				saida = cDao.atualizar(c);
			}
			if (cmd.equalsIgnoreCase("Excluir")) {
				saida = cDao.excluir(c);
			}
			if (cmd.equalsIgnoreCase("Buscar")) {
				c = cDao.buscar(c);
			}
			if (cmd.equalsIgnoreCase("Listar")) {
				clientes = cDao.listar();
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			if (!cmd.equalsIgnoreCase("Buscar")) {
				c = null;
			}
			if (!cmd.equalsIgnoreCase("Listar")) {
				clientes = null;
			}
		}
		model.addAttribute("erro", erro);
		model.addAttribute("saida", saida);
		model.addAttribute("cliente", c);
		model.addAttribute("clientes", clientes);
		
		return new ModelAndView("controleExemplar");
	}
}
