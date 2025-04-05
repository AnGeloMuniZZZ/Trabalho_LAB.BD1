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

import lab.bd.trabalho.locacao.model.Revista;

@Repository
public class RevistaDao implements ICrudExDao<Revista> {
	
	@Autowired
	private ConnectionDao gDao;

	@Override
	public String inserir(Revista r) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "{CALL controle_exemplar(?, ?, ?, ?, ?, ?, ?)}";
		CallableStatement cs = con.prepareCall(sql);
		cs.setString(1, "I");
		cs.setInt(2, r.getCodigo_exemplar());
		cs.setString(3, r.getNome());
		cs.setInt(4, r.getQtd_paginas());
		cs.setString(5, r.getIssn());
		cs.setNull(6, Types.INTEGER);
		cs.registerOutParameter(7, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(7);
		cs.close();
		con.close();
		return saida;
	}

	@Override
	public String atualizar(Revista r) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "{CALL controle_exemplar(?, ?, ?, ?, ?, ?, ?)}";
		CallableStatement cs = con.prepareCall(sql);
		cs.setString(1, "U");
		cs.setInt(2, r.getCodigo_exemplar());
		cs.setString(3, r.getNome());
		cs.setInt(4, r.getQtd_paginas());
		cs.setString(5, r.getIssn());
		cs.setNull(6, Types.INTEGER);
		cs.registerOutParameter(7, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(7);
		cs.close();
		con.close();
		return saida;
	}

	@Override
	public String excluir(Revista r) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "{CALL controle_exemplar(?, ?, ?, ?, ?, ?, ?)}";
		CallableStatement cs = con.prepareCall(sql);
		cs.setString(1, "D");
		cs.setInt(2, r.getCodigo_exemplar());
		cs.setNull(3, Types.VARCHAR);
		cs.setNull(4, Types.INTEGER);
		cs.setNull(5, Types.VARCHAR);
		cs.setNull(6, Types.INTEGER);
		cs.registerOutParameter(7, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(7);
		cs.close();
		con.close();
		return saida;
	}

	@Override
	public Revista buscar(Revista r) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "SELECT codigo_exemplar, nome, qtd_paginas, ExemplarCodigo, issn FROM Exemplar, Revista "
				+ "WHERE codigo_exemplar = ExemplarCodigo AND codigo_exemplar LIKE ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, r.getCodigo_exemplar());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			r.setCodigo_exemplar(rs.getInt("codigo_exemplar"));
			r.setNome(rs.getString("nome"));
			r.setQtd_paginas(rs.getInt("qtd_paginas"));
			r.setExemplarcodigo(rs.getInt("ExemplarCodigo"));
			r.setIssn(rs.getString("isbn"));
		}
		rs.close();
		ps.close();
		con.close();
		return r;
	}

	@Override
	public List<Revista> listar() throws ClassNotFoundException, SQLException {
		List<Revista> revistas = new ArrayList<Revista>();
		Connection con = gDao.getConnection();
		String sql = "SELECT codigo_exemplar, nome, qtd_paginas, ExemplarCodigo, isbn, edicao FROM Exemplar, Livro "
				+ "WHERE codigo_exemplar = ExemplarCodigo";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Revista revista = new Revista();
			revista.setCodigo_exemplar(rs.getInt("codigo_exemplar"));
			revista.setNome(rs.getString("nome"));
			revista.setQtd_paginas(rs.getInt("qtd_paginas"));
			revista.setExemplarcodigo(rs.getInt("ExemplarCodigo"));
			revista.setIssn(rs.getString("isbn"));
			revistas.add(revista);
		}
		rs.close();
		ps.close();
		con.close();
		return revistas;
	}
}
