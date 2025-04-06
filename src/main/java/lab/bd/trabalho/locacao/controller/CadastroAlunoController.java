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
public class CadastroAlunoController {

	@Autowired
	private AlunoDao aDao;
	
	@RequestMapping(name = "cadastroAluno", value = "/cadastroAluno", method = RequestMethod.GET)
	public ModelAndView alunoGet(@RequestParam Map<String, String> params, ModelMap model) {
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
		return new ModelAndView("alunos");
	}
	
	@RequestMapping(name = "cadastroAluno", value = "/cadastroAluno", method = RequestMethod.POST)
	public ModelAndView alunoPost(@RequestParam Map<String, String> params, ModelMap model) {
		String cpf = params.get("cpf");
		String nome = params.get("nome_completo");
		String senha = params.get("senha");
		String cmd = params.get("botao");
		
		Aluno a = new Aluno();
		if (cmd.contentEquals("inserir")) {
			a.setCpf(cpf);
			a.setNome_completo(nome);
			a.setSenha(senha);
		}
		
		String saida = "";
		String erro = "";
		List<Aluno> alunos = new ArrayList<Aluno>();
		
		try {
			if (cmd.equalsIgnoreCase("inserir")) {
				saida = aDao.inserir(a);
				//Criação da variavel aTemp para retirada dos campos RA e email, que eram apenas tradados no SQL
				Aluno aTemp = aDao.buscar(a);
				a.setEmail(aTemp.getEmail());
				a.setRa(aTemp.getRa());
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
		
		return new ModelAndView("aluno");
	}
}
