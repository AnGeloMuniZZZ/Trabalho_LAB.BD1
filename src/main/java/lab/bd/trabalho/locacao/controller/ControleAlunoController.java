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

import lab.bd.trabalho.locacao.model.Aluno;
import lab.bd.trabalho.locacao.persistence.AlunoDao;

@Controller
public class ControleAlunoController {
	@Autowired
	private AlunoDao aDao;

	@RequestMapping(name = "controleAluno", value = "/controleAluno", method = RequestMethod.GET)
	/**
	 * Funcao responsavel por mapear a requisicao GET e carregar a pagina
	 * /cadastroAluno
	 * 
	 * @param params
	 * @param model
	 * @return A requisicao da pagina GET
	 */
	public ModelAndView controleAlunoGet(@RequestParam Map<String, String> params, ModelMap model) {
		String acao = params.get("acao");
		String cpf = params.get("id");
		Aluno a = new Aluno();
		List<Aluno> alunos = new ArrayList<>();
		String erro = "";
		try {
			if (cpf != null && !cpf.isBlank()) {
				a.setCpf(cpf);
				if (acao.equals("editar")) {
					a = aDao.buscar(a);
					alunos = null;
				}
			}
		} catch (SQLException | ClassNotFoundException e) {
			e.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("aluno", a);
			model.addAttribute("alunos", alunos);
		}
		return new ModelAndView("controleAluno");
	}

	@RequestMapping(name = "controleAluno", value = "/controleAluno", method = RequestMethod.POST)
	/**
	 * Realiza o Controle de Atualizacao, Busca e Listagem da Entidade Aluno
	 * 
	 * @param params
	 * @param model
	 * @return Retorna requisao POST e mensagens de erro, saida e aviso
	 */
	public ModelAndView controleAlunoPost(@RequestParam Map<String, String> params, ModelMap model) {
		String cpf = params.get("cpf");
		String senha = params.get("senha");
		String cmd = params.get("botao");

		Aluno a = new Aluno();
		if (!cmd.equalsIgnoreCase("Listar")) {
			a.setCpf(cpf);
		}
		if (cmd.equalsIgnoreCase("Atualizar")) {
			a.setSenha(senha);
		}

		String saida = "";
		String erro = "";
		List<Aluno> alunos = new ArrayList<Aluno>();

		try {
			if (cmd.equalsIgnoreCase("Atualizar")) {
				saida = aDao.atualizar(a);
			}
			if (cmd.equalsIgnoreCase("Buscar")) {
				a = aDao.buscar(a);
			}
			if (cmd.equalsIgnoreCase("Listar")) {
				alunos = aDao.listar();
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			if (!cmd.equalsIgnoreCase("Buscar")) {
				a = null;
			}
			if (!cmd.equalsIgnoreCase("Listar")) {
				alunos = null;
			}
		}
		model.addAttribute("erro", erro);
		model.addAttribute("saida", saida);
		model.addAttribute("aluno", a);
		model.addAttribute("alunos", alunos);

		return new ModelAndView("controleAluno");
	}
}
