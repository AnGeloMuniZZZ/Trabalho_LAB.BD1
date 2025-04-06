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

import lab.bd.trabalho.locacao.model.Administrador;
import lab.bd.trabalho.locacao.persistence.AdministradorDao;

@Controller
public class LoginAdministradorController {

	protected Administrador atual = new Administrador();
	
	@Autowired
	private AdministradorDao aDao;
	
	@RequestMapping(name = "loginAdministrador", value = "/loginAdministrador", method = RequestMethod.GET)
	public ModelAndView administradorGet(@RequestParam Map<String, String> params, ModelMap model) {
		return new ModelAndView("loginAdministrador");
	}
	
	@RequestMapping(name = "loginAdministrador", value = "/loginAdministrador", method = RequestMethod.POST)
	public ModelAndView alunoPost(@RequestParam Map<String, String> params, ModelMap model) {
		String codigo = params.get("codigo");
		String nome = params.get("nome");
		String usuario = params.get("usuario");
		String senha = params.get("senha");
		String cmd = params.get("botao");
		
		Administrador a = new Administrador();
		a.setCodigo(Integer.parseInt(codigo));
		a.setNome(nome);
		a.setUsuario(usuario);
		a.setSenha(senha);
		
		String saida = "";
		String erro = "";
		
		try {
			if (cmd.equalsIgnoreCase("inserir")) {
				saida = aDao.inserir(a);
			}
			else if (cmd.equalsIgnoreCase("Logar")) {
				atual = aDao.realizarLogin(a);
			}

		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		}
		model.addAttribute("erro", erro);
		model.addAttribute("saida", saida);
		model.addAttribute("administrador", a);
		
		return new ModelAndView("loginAdministrador");
	}
}


