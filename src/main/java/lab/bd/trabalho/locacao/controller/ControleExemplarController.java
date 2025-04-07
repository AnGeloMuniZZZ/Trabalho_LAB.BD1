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
		String exemplarcodigo = params.get("id");
		Livro l = new Livro();
		List<Livro> livros = new ArrayList<>();
		Revista r = new Revista();
		List<Revista> revistas = new ArrayList<>();
		String erro = "";

		try {
			if (exemplarcodigo != null && !exemplarcodigo.isBlank()) {
				l.setExemplarcodigo(Integer.parseInt(exemplarcodigo));
				// Verificar se é um livro ou revista pelo codigo do exemplar usando o codigo de
				// exemplar
				char verifica = lDao.descobrirSigla(l);
				if (verifica == 'L') {
					if (acao.equals("excluir")) {
						lDao.excluir(l);
						livros = lDao.listar();
						l = null;
					} else if (acao.equals("editar")) {
						l = lDao.buscar(l);
						livros = null;
					}
				} else {
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
		String administrador_codigo = params.get("administrador_codigo");
		String nome = params.get("nome");
		String qtd_paginas = params.get("qtd_paginas");
		String issnisbn = params.get("sigla");
		String edicao = params.get("edicao");
		String cmd = params.get("botao");
		String saida = "";
		String erro = "";

		Livro l = new Livro();
		Revista r = new Revista();

		if (!cmd.equalsIgnoreCase("Listar")) {
			l.setCodigo_exemplar(Integer.parseInt(codigoExemplar));
			r.setCodigo_exemplar(Integer.parseInt(codigoExemplar));
		}
		if (cmd.contentEquals("Inserir") || cmd.equalsIgnoreCase("Atualizar")) {
			l.setAdministrador_codigo(Integer.parseInt(administrador_codigo));
			l.setNome(nome);
			l.setQtd_paginas(Integer.parseInt(qtd_paginas));
			l.setSigla(issnisbn);
			l.setEdicao(Integer.parseInt(edicao));

			r.setAdministrador_codigo(Integer.parseInt(administrador_codigo));
			r.setNome(nome);
			r.setQtd_paginas(Integer.parseInt(qtd_paginas));
			r.setSigla(issnisbn);
		}

		List<Livro> livros = new ArrayList<Livro>();
		List<Revista> revistas = new ArrayList<Revista>();

		try {
			if (cmd.equalsIgnoreCase("Listar")) {
				livros = lDao.listar();
				revistas = rDao.listar();
			} else {
				// Como no banco é feita a diferenciação aqui o objeto será passado como livro
				if (cmd.equalsIgnoreCase("Inserir")) {
					saida = lDao.inserir(l);
				}
				if (cmd.equalsIgnoreCase("Excluir")) {
					saida = lDao.excluir(l);
				}
				// Verificar se é um livro ou revista pelo codigo do exemplar usando o codigo de
				// exemplar
				char verifica = lDao.descobrirSigla(l);
				if (verifica == 'L') {

					if (cmd.equalsIgnoreCase("Atualizar")) {
						saida = lDao.atualizar(l);
					}

					if (cmd.equalsIgnoreCase("Buscar")) {
						l = lDao.buscar(l);
					}

				} else {
					if (cmd.equalsIgnoreCase("Atualizar")) {
						saida = rDao.atualizar(r);
					}
					if (cmd.equalsIgnoreCase("Buscar")) {
						r = rDao.buscar(r);
					}
				}
			}

		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			if (!cmd.equalsIgnoreCase("Buscar")) {
				l = null;
				r = null;
			}
			if (!cmd.equalsIgnoreCase("Listar")) {
				livros = null;
				revistas = null;
			}
		}
		model.addAttribute("erro", erro);
		model.addAttribute("saida", saida);
		model.addAttribute("livro", l);
		model.addAttribute("livro", r);
		model.addAttribute("livros", livros);
		model.addAttribute("revistas", revistas);

		return new ModelAndView("controleExemplar");
	}
}
