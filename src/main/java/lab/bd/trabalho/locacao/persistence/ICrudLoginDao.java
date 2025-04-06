package lab.bd.trabalho.locacao.persistence;

import java.sql.SQLException;

public interface ICrudLoginDao<T> {

	/**
	 * Faz a leitura dos atributos usuario/senha, e valida se os mesmos estao corretos,
	 * caso corretos retornan um numero, 1 para Verdadeiro (Login realizado com sucesso) e
	 * 0 para False (Login ou senha invalidos)
	 * 
	 * @param A Entidade T a fazer um Login
	 * @return
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public int realizarLogin(T t) throws ClassNotFoundException, SQLException;
}
