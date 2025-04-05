package lab.bd.trabalho.locacao.persistence;

import java.sql.SQLException;

public interface ICrudExDao<T> extends ICrudDao<T> {
	
	public String excluir (T t) throws ClassNotFoundException, SQLException;

}
