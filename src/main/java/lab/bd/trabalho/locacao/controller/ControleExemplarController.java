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

		// Verificar se é um livro ou revista pelo codigo do exemplar usando o codigo de
		// exemplar
		l.setExemplarcodigo(Integer.parseInt(exemplarcodigo));

		try {
			char verifica = lDao.descobrirSigla(l);
			if (verifica == 'L') {
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
			} else {
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
		} catch (SQLException | ClassNotFoundException e) {
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
		String saida = "";
		String erro = "";

		Livro l = new Livro();
		Revista r = new Revista();

		// Verificar se é um livro ou revista pelo codigo do exemplar usando o codigo de
		// exemplar
		if (!(codigoExemplar == null)) {
			l.setExemplarcodigo(Integer.parseInt(codigoExemplar));

			char verifica;
			try {
				verifica = lDao.descobrirSigla(l);
				System.out.println("entrou no try 1");
				if (verifica == 'L') {
					if (!cmd.equalsIgnoreCase("Listar")) {
						l.setCodigo_exemplar(Integer.parseInt(codigoExemplar));
						System.out.println("entrou no if livro");
					}
					if (cmd.contentEquals("Inserir")) {
						l.setNome(nome);
						l.setQtd_paginas(Integer.parseInt(qtdPaginas));
						l.setAdministrador_codigo(0);
						l.setIsbn(issnisbn);
						l.setEdicao(Integer.parseInt(edicao));
					} else if (cmd.equalsIgnoreCase("Atualizar")) {
						l.setNome(nome);
						l.setQtd_paginas(Integer.parseInt(qtdPaginas));
						l.setEdicao(Integer.parseInt(edicao));
					}

					List<Livro> livros = new ArrayList<Livro>();

					try {
						if (cmd.equalsIgnoreCase("Inserir")) {
							saida = lDao.inserir(l);
						}
						if (cmd.equalsIgnoreCase("Atualizar")) {
							saida = lDao.atualizar(l);
						}
						if (cmd.equalsIgnoreCase("Excluir")) {
							saida = lDao.excluir(l);
						}
						if (cmd.equalsIgnoreCase("Buscar")) {
							l = lDao.buscar(l);
						}
						if (cmd.equalsIgnoreCase("Listar")) {
							livros = lDao.listar();
						}
					} catch (SQLException | ClassNotFoundException e) {
						erro = e.getMessage();
					} finally {
						if (!cmd.equalsIgnoreCase("Buscar")) {
							l = null;
						}
						if (!cmd.equalsIgnoreCase("Listar")) {
							livros = null;
						}
						model.addAttribute("livro", l);
						model.addAttribute("livros", livros);
					}
				} else {
					System.out.println("entrou no else como revista");
					if (!cmd.equalsIgnoreCase("Listar")) {
						r.setCodigo_exemplar(Integer.parseInt(codigoExemplar));
					}
					if (cmd.contentEquals("Inserir")) {
						r.setNome(nome);
						r.setQtd_paginas(Integer.parseInt(qtdPaginas));
						r.setAdministrador_codigo(0);
						r.setIssn(issnisbn);
					} else if (cmd.equalsIgnoreCase("Atualizar")) {
						r.setNome(nome);
						r.setQtd_paginas(Integer.parseInt(qtdPaginas));
					}

					List<Revista> revistas = new ArrayList<Revista>();

					try {
						if (cmd.equalsIgnoreCase("Inserir")) {
							saida = rDao.inserir(r);
						}
						if (cmd.equalsIgnoreCase("Atualizar")) {
							saida = rDao.atualizar(r);
						}
						if (cmd.equalsIgnoreCase("Excluir")) {
							saida = rDao.excluir(r);
						}
						if (cmd.equalsIgnoreCase("Buscar")) {
							r = rDao.buscar(r);
						}
						if (cmd.equalsIgnoreCase("Listar")) {
							revistas = rDao.listar();
						}
					} catch (SQLException | ClassNotFoundException e) {
						erro = e.getMessage();
					} finally {
						if (!cmd.equalsIgnoreCase("Buscar")) {
							l = null;
						}
						if (!cmd.equalsIgnoreCase("Listar")) {
							revistas = null;
						}
						model.addAttribute("livro", r);
						model.addAttribute("revistas", revistas);
					}
				}
			} catch (SQLException | ClassNotFoundException e) {
				erro = e.getMessage();
			} finally {
				model.addAttribute("erro", erro);
				model.addAttribute("saida", saida);
			}
		}

		return new ModelAndView("controleExemplar");
	}
}
