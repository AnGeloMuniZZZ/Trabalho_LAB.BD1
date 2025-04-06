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
public class Aluno {
	
	private String cpf;
	private String ra;
	private String nome_completo;
	private String email;
	private String senha;
	private int validar;

}
