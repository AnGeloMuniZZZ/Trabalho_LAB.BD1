package lab.bd.trabalho.locacao.persistence;

import java.sql.SQLException;

public interface ICrudLoginDao<T> {

	public int realizarLogin(T t) throws ClassNotFoundException, SQLException;
}
