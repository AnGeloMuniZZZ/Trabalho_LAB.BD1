package lab.bd.trabalho.locacao.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class Administrador {

	private int codigo;
	private String nome;
	private String usuario;
	private String senha;

}
