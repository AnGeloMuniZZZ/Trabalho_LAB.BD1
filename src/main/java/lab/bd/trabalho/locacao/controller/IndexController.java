package lab.bd.trabalho.locacao.controller;

import java.sql.SQLException;
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
public class IndexController {

	@Autowired
	private AlunoDao aDao;
	
	@RequestMapping(name = "index", value = "/index", method = RequestMethod.GET)
	public ModelAndView indexGet(@RequestParam Map<String, String> params, ModelMap model) {
		return new ModelAndView("index");
	}
	
	@RequestMapping(name = "index", value = "/index", method = RequestMethod.POST)
	public ModelAndView indexPost(@RequestParam Map<String, String> params, ModelMap model) {
		String usuario = params.get("login");
		String senha = params.get("senha");
		String cmd = params.get("botao");
		
		Aluno a;
		String saida = "";
		String erro = "";
		
		try {
			if (cmd.equalsIgnoreCase("Logar")) {
				a = new Aluno();
				a.setEmail(usuario);
				a.setSenha(senha);
				model.addAttribute("validar", (aDao.realizarLogin(a))); 

			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			a = null;
			
		}
		model.addAttribute("erro", erro);
		model.addAttribute("saida", saida);
		model.addAttribute("aluno", a);
		
		return new ModelAndView("index");
	}
}
