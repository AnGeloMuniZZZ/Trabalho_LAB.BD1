package lab.bd.trabalho.locacao.persistence;

import java.sql.SQLException;

public interface ICrudLoginDao<T> {

	public T realizarLogin(T t) throws ClassNotFoundException, SQLException;
}
