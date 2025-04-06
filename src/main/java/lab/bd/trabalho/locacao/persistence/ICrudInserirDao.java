package lab.bd.trabalho.locacao.persistence;

import java.sql.SQLException;

public interface ICrudInserirDao<T> {
	
	/**
	 * Realiza a inserção de uma Entidade T no Banco de dados SQL
	 * 
	 * @param Entidade T
	 * @return Retorna uma String sobre os status da insercao
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public String inserir(T t) throws ClassNotFoundException, SQLException;
	
}
