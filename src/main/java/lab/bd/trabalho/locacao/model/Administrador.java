package lab.bd.trabalho.locacao.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Administrador {
	
	private String cpf;
	private String nome;
	private String login;
	private String senha;

}
