package lab.bd.trabalho.locacao.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lab.bd.trabalho.locacao.model.Administrador;
import lab.bd.trabalho.locacao.model.Aluno;

@Repository
public class AdministradorDao implements ICrudInserirDao<Administrador>, ICrudLoginDao<Administrador> {

	@Autowired
	private ConnectionDao gDao;
	
	@Override
	public String inserir(Administrador a) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "{CALL controle_inserir_administrador(?, ?, ?, ?, ?)}";
		CallableStatement cs = con.prepareCall(sql);
		cs.setInt(1, a.getCodigo());
		cs.setString(2, a.getNome());
		cs.setString(3, a.getUsuario());
		cs.setString(4, a.getSenha());
		cs.registerOutParameter(5, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(5);
		cs.close();
		con.close();
		return saida;
	}

	@Override
	public Administrador realizarLogin(Administrador a) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "{CALL realizar_login_adm(?, ?, ?)}";
		CallableStatement cs = con.prepareCall(sql);
		cs.setString(1, a.getUsuario());
		cs.setString(2, a.getSenha());
		cs.registerOutParameter(3, Types.INTEGER);
		cs.execute();
		String sql2 = "SELECT codigo, nome, usuario, senha FROM Administrador WHERE codigo LIKE ?";
		PreparedStatement ps = con.prepareStatement(sql2);
		ps.setInt(1, Integer.parseInt(cs.getString(3)));
		ResultSet rs = ps.executeQuery();
		if(rs.next()) {
			a.setCodigo(Integer.parseInt(rs.getString("codigo")));
			a.setNome(rs.getString("nome"));
			a.setUsuario(rs.getString("usuario"));
			a.setSenha(rs.getString("senha"));
		}
		cs.close();
		rs.close();
		ps.close();
		con.close();
		return a;
	}
	
}
