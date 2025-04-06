package lab.bd.trabalho.locacao.model;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Locacao {
	
	private Exemplar exemplar;
	private Aluno aluno;
	private LocalDate dataRetirada;
	private int qntDias;
	
}
