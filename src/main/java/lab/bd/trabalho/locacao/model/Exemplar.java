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
public class Exemplar {
	
	private int codigo_exemplar;
	private int administrador_codigo;
	private String nome;
	private int qtd_paginas;

}
