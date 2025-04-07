package lab.bd.trabalho.locacao.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lab.bd.trabalho.locacao.model.Administrador;
import lab.bd.trabalho.locacao.model.Aluno;

@Repository
public class AlunoDao implements ICrudDao<Aluno>, ICrudLoginDao<Aluno> {

	@Autowired
	private ConnectionDao gDao;

	@Override
	public String inserir(Aluno a) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "{CALL controle_aluno(?, ?, ?, ?, ?)}";
		CallableStatement cs = con.prepareCall(sql);
		cs.setString(1, "I");
		cs.setString(2, a.getCpf());
		cs.setString(3, a.getNome_completo());
		cs.setString(4, a.getSenha());
		cs.registerOutParameter(5, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(5);
		cs.close();
		con.close();
		return saida;
	}

	@Override
	public String atualizar(Aluno a) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "{CALL controle_aluno(?, ?, ?, ?, ?)}";
		CallableStatement cs = con.prepareCall(sql);
		cs.setString(1, "U");
		cs.setString(2, a.getCpf());
		cs.setNull(3, Types.VARCHAR);
		cs.setString(4, a.getSenha());
		cs.registerOutParameter(5, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(5);
		cs.close();
		con.close();
		return saida;
	}


	@Override
	public Aluno buscar(Aluno a) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "SELECT cpf, ra, nome_completo, email, senha FROM Aluno WHERE cpf LIKE ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, a.getCpf());
		ResultSet rs = ps.executeQuery();
		if(rs.next()) {
			a.setCpf(rs.getString("cpf"));
			a.setRa(rs.getString("ra"));
			a.setNome_completo(rs.getString("nome_completo"));
			a.setEmail(rs.getString("email"));
			a.setSenha(rs.getString("senha"));
		}
		rs.close();
		ps.close();
		con.close();
		return a;
	}

	@Override
	public List<Aluno> listar() throws ClassNotFoundException, SQLException {
		List<Aluno> alunos = new ArrayList<Aluno>();
		Connection con = gDao.getConnection();
		String sql = "SELECT cpf, ra, nome_completo, email, senha FROM Aluno";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Aluno aluno = new Aluno();
			aluno.setCpf(rs.getString("cpf"));
			aluno.setRa(rs.getString("ra"));
			aluno.setNome_completo(rs.getString("nome_completo"));
			aluno.setEmail(rs.getString("email"));
			aluno.setSenha(rs.getString("senha"));
			alunos.add(aluno);
		}
		rs.close();
		ps.close();
		con.close();
		return alunos;
	}
	
	@Override
	public int realizarLogin(Aluno a) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "{CALL realizar_login_aluno(?, ?, ?)}";
		CallableStatement cs = con.prepareCall(sql);
		cs.setString(1, a.getEmail());
		cs.setString(2, a.getSenha());
		cs.registerOutParameter(3, Types.VARCHAR);
		cs.execute();
		int v = Integer.parseInt(cs.getString(3));
		cs.close();
		con.close();
		return v;
	}

}
