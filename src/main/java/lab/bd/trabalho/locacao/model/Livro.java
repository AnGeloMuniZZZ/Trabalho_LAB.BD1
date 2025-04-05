package lab.bd.trabalho.locacao.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Livro extends Exemplar {
	
	private int exemplarcodigo;
	private String isbn;
	private int edicao;

}
