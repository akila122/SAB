package rs.etf.sab.student;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.LinkedList;
import java.util.List;

import rs.etf.sab.operations.StockroomOperations;

public class ra160248_StockroomOperations extends Connected implements StockroomOperations {

	public ra160248_StockroomOperations(Connection conn) {
		super(conn);
		// TODO Auto-generated constructor stub
	}

	@Override
	public boolean deleteStockroom(int arg0) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call deleteStockroom (?)}");
			stmt.setInt(2, arg0);
			stmt.registerOutParameter(1, Types.INTEGER);
			stmt.execute();
			return stmt.getInt(1) == 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
				return false;
			}
		}
	}

	@Override
	public int deleteStockroomFromCity(int arg0) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call deleteStockroomFromCity (?)}");
			stmt.setInt(2, arg0);
			stmt.registerOutParameter(1, Types.INTEGER);
			stmt.execute();
			return stmt.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
				return -1;
			}
		}
	}

	@Override
	public List<Integer> getAllStockrooms() {
		List<Integer> ret = new LinkedList<>();
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{call getAllStockrooms ()}");
			ResultSet rs = stmt.executeQuery();

			while (rs.next())
				ret.add(rs.getInt(1));

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
				return null;
			}
		}

		return ret;
	}

	@Override
	public int insertStockroom(int arg0) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call insertStockroom (?)}");
			stmt.setInt(2, arg0);
			stmt.registerOutParameter(1, Types.INTEGER);
			stmt.execute();
			return stmt.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
				return -1;
			}
		}
	}

}
