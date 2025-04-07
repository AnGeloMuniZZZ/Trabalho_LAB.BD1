package lab.bd.trabalho.locacao.persistence;

import java.sql.SQLException;

public interface ICrudExDao<T> extends ICrudDao<T> {

	/**
	 * Realiza a exclusao de uma Entidade T no banco de dados SQL
	 * 
	 * @param Entidade T
	 * @return Retorna uma String sobre os status da exclusao
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public String excluir(T t) throws ClassNotFoundException, SQLException;

}
