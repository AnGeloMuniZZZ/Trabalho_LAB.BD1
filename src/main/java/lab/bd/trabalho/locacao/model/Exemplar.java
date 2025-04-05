package lab.bd.trabalho.locacao.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Exemplar {
	
	private int codigo_exemplar;
	private String nome;
	private int qtd_paginas;

}
