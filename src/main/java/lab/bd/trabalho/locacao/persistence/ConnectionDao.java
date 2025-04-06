package lab.bd.trabalho.locacao.persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.springframework.stereotype.Repository;

@Repository
public class ConnectionDao {

	private Connection c;

	/**
	 * Funcao que realiza a conexao com o banco de dados sql
	 * 
	 * @return Um conexao com o banco de dados SQL
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public Connection getConnection() throws ClassNotFoundException, SQLException {

		String hostName = "localhost";//"DESKTOP-GH1LJAD";
		String dbName = "LocacaoLivros";
		String user = "sa";
		String senha = "senha123";
		Class.forName("net.sourceforge.jtds.jdbc.Driver");
		c = DriverManager.getConnection(String.format(
				"jdbc:jtds:sqlserver://%s:1433;databaseName=%s;user=%s;password=%s;", hostName, dbName, user, senha));

		return c;
	}
}
