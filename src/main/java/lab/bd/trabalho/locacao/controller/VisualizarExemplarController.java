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
public class VisualizarExemplarController {

	@Autowired
	private LivroDao lDao;
	@Autowired
	private RevistaDao rDao;

	@RequestMapping(name = "visualizarExemplar", value = "/visualizarExemplar", method = RequestMethod.GET)
	public ModelAndView visualizarExemplarGet(@RequestParam Map<String, String> params, ModelMap model) {
		String acao = params.get("acao");
		String codigo_exemplar = params.get("id");
		Livro l = new Livro();
		List<Livro> livros = new ArrayList<>();
		Revista r = new Revista();
		List<Revista> revistas = new ArrayList<>();
		String erro = "";

		try {
			if (codigo_exemplar != null && !codigo_exemplar.isBlank()) {
				l.setCodigo_exemplar(Integer.parseInt(codigo_exemplar));
				r.setCodigo_exemplar(Integer.parseInt(codigo_exemplar));
				// Verificar se é um livro ou revista pelo codigo do exemplar usando o codigo de
				// exemplar
				String verifica = lDao.descobrirSiglaPorCodigo(l);
				if (verifica.equals("L")) {
					if (acao.equals("editar")) {
						l = lDao.buscar(l);
						livros = null;
						model.addAttribute("livro", l);
					}
				} else {
					if (acao.equals("editar")) {
						r = rDao.buscar(r);
						revistas = null;
						model.addAttribute("livro", r);
					}
				}
			}
		} catch (SQLException | ClassNotFoundException e) {
			e.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			if (l == null) {
				model.addAttribute("edicao", 0);
			} else {
				model.addAttribute("edicao", l.getEdicao());
			}

			model.addAttribute("livros", livros);
			model.addAttribute("revistas", revistas);
		}
		return new ModelAndView("visualizarExemplar");
	}

	@RequestMapping(name = "visualizarExemplar", value = "/visualizarExemplar", method = RequestMethod.POST)
	public ModelAndView visualizarExemplarPost(@RequestParam Map<String, String> params, ModelMap model) {
		String codigoExemplar = params.get("codigo_exemplar");
		String cmd = params.get("botao");
		String saida = "";
		String erro = "";

		Livro l = new Livro();
		Revista r = new Revista();

		if (!cmd.equalsIgnoreCase("Listar")) {
			l.setCodigo_exemplar(Integer.parseInt(codigoExemplar));
			r.setCodigo_exemplar(Integer.parseInt(codigoExemplar));
		}

		List<Livro> livros = new ArrayList<Livro>();
		List<Revista> revistas = new ArrayList<Revista>();

		try {
			if (cmd.equalsIgnoreCase("Listar")) {
				livros = lDao.listar();
				revistas = rDao.listar();
			}
			// Verificar se é um livro ou revista pelo codigo do exemplar usando o issn ou
			// isbn
			if (cmd.equalsIgnoreCase("Buscar")) {
				String verifica = lDao.descobrirSiglaPorCodigo(l);
				if (verifica.equals("L")) {
					if (cmd.equalsIgnoreCase("Buscar")) {
						l = lDao.buscar(l);
					}
				} else {
					if (cmd.equalsIgnoreCase("Buscar")) {
						r = rDao.buscar(r);
					}
				}
			}

		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			try {
				if (!cmd.equalsIgnoreCase("Listar")) {
					String verifica = lDao.descobrirSiglaPorCodigo(l);
					if (verifica.equals("L")) {
						if (!cmd.equalsIgnoreCase("Buscar")) {
							l = null;
							r = null;
							model.addAttribute("livro", l);
						} else {
							model.addAttribute("livro", l);
						}
					} else {
						if (!cmd.equalsIgnoreCase("Buscar")) {
							l = null;
							r = null;
							model.addAttribute("livro", r);
						} else {
							model.addAttribute("livro", r);
						}
					}

				}
			} catch (ClassNotFoundException | SQLException e) {
				erro = e.getMessage();

			}
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
		if (l == null) {
			model.addAttribute("edicao", 0);
		} else {
			model.addAttribute("edicao", l.getEdicao());
		}
		model.addAttribute("livros", livros);
		model.addAttribute("revistas", revistas);

		return new ModelAndView("visualizarExemplar");
	}
}
