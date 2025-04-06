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
	/**
	 * Funcao responsavel por mapear a requisicao GET e caregar a pagina /cadastroAluno
	 * 
	 * @param params
	 * @param model
	 * @return A requisicao da pagina
	 */
	public ModelAndView alunoGet(@RequestParam Map<String, String> params, ModelMap model) {
		return new ModelAndView("cadastroAluno");
	}

	
	@RequestMapping(name = "cadastroAluno", value = "/cadastroAluno", method = RequestMethod.POST)
	/**
	 * Cria o objeto aluno e tenta inseri-lo no banco
	 * 
	 * @param params
	 * @param model
	 * @return Retorna uma mensagem de validacao ou erro e dados gerados pelo banco
	 */
	public ModelAndView alunoPost(@RequestParam Map<String, String> params, ModelMap model) {
		String cpf = params.get("cpf");
		String nome = params.get("nome_completo");
		String senha = params.get("senha");
		String cmd = params.get("botao");
		
		Aluno a = new Aluno();
		a.setCpf(cpf);
		a.setNome_completo(nome);
		a.setSenha(senha);
		
		String saida = "";
		String erro = "";
		
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
		}
		model.addAttribute("erro", erro);
		model.addAttribute("saida", saida);
		model.addAttribute("aluno", a);
		
		return new ModelAndView("cadastroAluno");
	}
}
