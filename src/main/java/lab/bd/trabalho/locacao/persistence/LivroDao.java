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

import lab.bd.trabalho.locacao.model.Livro;

@Repository
public class LivroDao implements ICrudExDao<Livro>{

	@Autowired
	private ConnectionDao gDao;

	@Override
	public String inserir(Livro l) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "{CALL controle_exemplar(?, ?, ?, ?, ?, ?, ?, ?)}";
		CallableStatement cs = con.prepareCall(sql);
		cs.setString(1, "I");
		cs.setInt(2, l.getCodigo_exemplar());
		cs.setInt(3, l.getAdministrador_codigo());
		cs.setString(4, l.getNome());
		cs.setInt(5, l.getQtd_paginas());
		cs.setString(6, l.getIsbn());
		cs.setInt(7, l.getEdicao());
		cs.registerOutParameter(8, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(8);
		cs.close();
		con.close();
		return saida;
	}

	@Override
	public String atualizar(Livro l) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "{CALL controle_exemplar(?, ?, ?, ?, ?, ?, ?, ?)}";
		CallableStatement cs = con.prepareCall(sql);
		cs.setString(1, "U");
		cs.setInt(2, l.getCodigo_exemplar());
		cs.setInt(3, l.getAdministrador_codigo());
		cs.setString(4, l.getNome());
		cs.setInt(5, l.getQtd_paginas());
		cs.setString(6, l.getIsbn());
		cs.setInt(7, l.getEdicao());
		cs.registerOutParameter(8, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(8);
		cs.close();
		con.close();
		return saida;
	}

	@Override
	public String excluir(Livro l) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "{CALL controle_exemplar(?, ?, ?, ?, ?, ?, ?, ?)}";
		CallableStatement cs = con.prepareCall(sql);
		cs.setString(1, "D");
		cs.setInt(2, l.getCodigo_exemplar());
		cs.setNull(3, Types.INTEGER);
		cs.setNull(4, Types.VARCHAR);
		cs.setNull(5, Types.INTEGER);
		cs.setNull(6, Types.VARCHAR);
		cs.setNull(7, Types.INTEGER);
		cs.registerOutParameter(8, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(8);
		cs.close();
		con.close();
		return saida;
	}

	@Override
	public Livro buscar(Livro l) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "SELECT codigo_exemplar, Administrador_codigo, nome, qtd_paginas, ExemplarCodigo, isbn, edicao FROM Exemplar, Livro "
				+ "WHERE codigo_exemplar = ExemplarCodigo AND codigo_exemplar LIKE ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, l.getCodigo_exemplar());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			l.setCodigo_exemplar(rs.getInt("codigo_exemplar"));
			l.setAdministrador_codigo(rs.getInt("Administrador_codigo"));
			l.setNome(rs.getString("nome"));
			l.setQtd_paginas(rs.getInt("qtd_paginas"));
			l.setExemplarcodigo(rs.getInt("ExemplarCodigo"));
			l.setIsbn(rs.getString("isbn"));
			l.setEdicao(rs.getInt("edicao"));
		}
		rs.close();
		ps.close();
		con.close();
		return l;
	}

	@Override
	public List<Livro> listar() throws ClassNotFoundException, SQLException {
		List<Livro> livros = new ArrayList<Livro>();
		Connection con = gDao.getConnection();
		String sql = "SELECT codigo_exemplar, Administrador_codigo, nome, qtd_paginas, ExemplarCodigo, isbn, edicao FROM Exemplar, Livro "
				+ "WHERE codigo_exemplar = ExemplarCodigo";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Livro livro = new Livro();
			livro.setCodigo_exemplar(rs.getInt("codigo_exemplar"));
			livro.setAdministrador_codigo(rs.getInt("Administrador_codigo"));
			livro.setNome(rs.getString("nome"));
			livro.setQtd_paginas(rs.getInt("qtd_paginas"));
			livro.setExemplarcodigo(rs.getInt("ExemplarCodigo"));
			livro.setIsbn(rs.getString("isbn"));
			livro.setEdicao(rs.getInt("edicao"));
			livros.add(livro);
		}
		rs.close();
		ps.close();
		con.close();
		return livros;
	}

}
