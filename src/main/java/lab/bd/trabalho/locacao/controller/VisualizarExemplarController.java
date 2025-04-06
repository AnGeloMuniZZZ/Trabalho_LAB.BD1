package lab.bd.trabalho.locacao.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class VisualizarExemplarController {

	@RequestMapping(name = "visualizarExemplar", value = "/visualizarExemplar", method = RequestMethod.GET)
	public ModelAndView exemplarGet(@RequestParam Map<String, String> params, ModelMap model) {
		String acao = params.get("acao");
		return new ;
		
	}
}
