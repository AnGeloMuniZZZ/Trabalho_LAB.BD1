package lab.bd.trabalho.locacao.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Administrador {
	
	private int codigo;
	private String nome;
	private String usuario;
	private String senha;

}
