package rs.etf.sab.student;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.LinkedList;
import java.util.List;

import rs.etf.sab.operations.CourierRequestOperation;

public class ra160248_CourierRequestOperations extends Connected implements CourierRequestOperation {

	public ra160248_CourierRequestOperations(Connection conn) {
		super(conn);
		// TODO Auto-generated constructor stub
	}

	@Override
	public boolean changeDriverLicenceNumberInCourierRequest(String arg0, String arg1) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call changeDriverLicenceNumberInCourierRequest (?,?)}");
			stmt.setString(2, arg0);
			stmt.setString(3, arg1);
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
	public boolean deleteCourierRequest(String arg0) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call deleteCourierRequest (?)}");
			stmt.setString(2, arg0);
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
	public List<String> getAllCourierRequests() {
		List<String> ret = new LinkedList<>();
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{call getAllCourierRequests ()}");
			ResultSet rs = stmt.executeQuery();

			while (rs.next())
				ret.add(rs.getString(1));

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
	public boolean grantRequest(String arg0) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call grantRequest (?)}");
			stmt.setString(2, arg0);
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
	public boolean insertCourierRequest(String arg0, String arg1) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call insertCourierRequest (?,?)}");
			stmt.setString(2, arg0);
			stmt.setString(3, arg1);
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

}
