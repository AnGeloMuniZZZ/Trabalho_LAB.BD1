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
	
	@Autowired
	private AdministradorDao aDao;
	
	@RequestMapping(name = "loginAdministrador", value = "/loginAdministrador", method = RequestMethod.GET)
	public ModelAndView administradorGet(@RequestParam Map<String, String> params, ModelMap model) {
		Administrador a = new Administrador();
		
		model.addAttribute("administrador", a);
		model.addAttribute("validar", 0);
		return new ModelAndView("loginAdministrador");
	}
	
	@RequestMapping(name = "loginAdministrador", value = "/loginAdministrador", method = RequestMethod.POST)
	public ModelAndView administradorPost(@RequestParam Map<String, String> params, ModelMap model) {
		String codigo = params.get("codigo");
		String nome = params.get("nome");
		String usuario = params.get("usuario");
		String senha = params.get("senha");
		String login = params.get("login");
		String senhalogin = params.get("senhalogin");
		String cmd = params.get("botao");
		
		Administrador a;
		String saida = "";
		String erro = "";
		
		try {
			if (cmd.equalsIgnoreCase("inserir")) {
				a = new Administrador();
				a.setCodigo(Integer.parseInt(codigo));
				a.setNome(nome);
				a.setUsuario(usuario);
				a.setSenha(senha);
				saida = aDao.inserir(a);
			}
			else if (cmd.equalsIgnoreCase("Logar")) {
				a = new Administrador();
				a.setUsuario(login);
				a.setSenha(senhalogin);
				model.addAttribute("validar", (aDao.realizarLogin(a))); 
				System.out.println("Passou legal, ao menos");
				System.out.println(aDao.realizarLogin(a));
			}

		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			a = null;
			
		}
		model.addAttribute("erro", erro);
		model.addAttribute("saida", saida);
		model.addAttribute("administrador", a);
		
		return new ModelAndView("loginAdministrador");
	}
}


