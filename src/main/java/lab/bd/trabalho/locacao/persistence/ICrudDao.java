package lab.bd.trabalho.locacao.persistence;

import java.sql.SQLException;
import java.util.List;

public interface ICrudDao<T> extends ICrudInserirDao<T>{
	
	public String atualizar (T t) throws ClassNotFoundException, SQLException;
	public T buscar(T t) throws ClassNotFoundException, SQLException;
	public List<T> listar() throws ClassNotFoundException, SQLException;

}