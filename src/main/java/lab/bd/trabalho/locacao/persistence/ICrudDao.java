package lab.bd.trabalho.locacao.persistence;

import java.sql.SQLException;
import java.util.List;

public interface ICrudDao<T> extends ICrudInserirDao<T>{
	
	/**
	 * Realiza um update da Entidade T no banco de dados SQL
	 * 
	 * @param Entidade T
	 * @return Retorna uma String sobre os status do update no SQL
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public String atualizar (T t) throws ClassNotFoundException, SQLException;
	
	
	/**
	 * Busca os dados da Entidade T com base em um de seus atributos
	 * 
	 * @param A Entidade T a ser Buscada e montada
	 * @return Retorna os dados da Entidade T com base da Chave Primaria enviada
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public T buscar(T t) throws ClassNotFoundException, SQLException;
	
	
	/**
	 * Procura uma lista da Entidade T no banco de dados SQL
	 * 
	 * @return Retorna uma lista de todos os elementos encontrados no banco
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public List<T> listar() throws ClassNotFoundException, SQLException;

}