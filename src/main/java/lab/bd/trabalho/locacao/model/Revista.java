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
public class Revista extends Exemplar {

	private int exemplarcodigo;
	private String sigla;

}
