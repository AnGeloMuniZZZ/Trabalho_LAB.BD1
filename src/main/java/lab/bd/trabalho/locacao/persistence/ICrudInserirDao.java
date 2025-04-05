package lab.bd.trabalho.locacao.persistence;

import java.sql.SQLException;

public interface ICrudInserirDao<T> {
	
	public String inserir(T t) throws ClassNotFoundException, SQLException;
	
}
