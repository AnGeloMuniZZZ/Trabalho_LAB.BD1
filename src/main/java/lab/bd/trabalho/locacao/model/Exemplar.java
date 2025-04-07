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
public abstract class Exemplar {
	
	protected int codigo_exemplar;
	protected int administrador_codigo;
	protected String nome;
	protected int qtd_paginas;

}
