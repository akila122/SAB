package rs.etf.sab.student;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

import rs.etf.sab.operations.GeneralOperations;

public class ra160248_GeneralOperations extends Connected implements GeneralOperations {

	public ra160248_GeneralOperations(Connection conn) {
		super(conn);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void eraseAll() {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{call eraseAll ()}");
			stmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}

}
