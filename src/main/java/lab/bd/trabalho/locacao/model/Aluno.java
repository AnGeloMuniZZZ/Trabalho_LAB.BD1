package lab.bd.trabalho.locacao.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Aluno {
	
	private String cpf;
	private String ra;
	private String nome_completo;
	private String email;
	private String senha;

}
