package rs.etf.sab.student;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.LinkedList;
import java.util.List;

import rs.etf.sab.operations.UserOperations;

public class ra160248_UserOperations extends Connected implements UserOperations {

	public ra160248_UserOperations(Connection conn) {
		super(conn);
	}

	@Override
	public boolean declareAdmin(String arg0) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call declareAdmin (?)}");
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
	public int deleteUsers(String... arg0) {

		int ret = 0;
		CallableStatement stmt = null;

		for (String city : arg0) {
			try {
				stmt = conn.prepareCall("{? = call deleteUser(?)}");
				stmt.setString(2, city);
				stmt.registerOutParameter(1, Types.INTEGER);
				stmt.execute();
				if (stmt.getInt(1)==0)
					ret ++;
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

		return ret;
	}

	@Override
	public List<String> getAllUsers() {
		List<String> ret = new LinkedList<>();
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{call getAllUsers ()}");
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
	public int getSentPackages(String... arg0) {
		int ret = 0;
		CallableStatement stmt = null;

		for (String user : arg0) {
			try {
				stmt = conn.prepareCall("{? = call getSentPackages(?)}");
				stmt.setString(2, user);
				stmt.registerOutParameter(1, Types.INTEGER);
				stmt.execute();
				if (stmt.getInt(1) < 0)
					return -1;
				else
					ret += stmt.getInt(1);
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

		return ret;
	}

	@Override
	public boolean insertUser(String arg0, String arg1, String arg2, String arg3, int arg4) {

		String namePattern = "^[A-Z][a-z]*$";
		String passPattern = "(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=_])(?=\\S+$).{8,}";

		if (!arg1.matches(namePattern) || !arg2.matches(namePattern) || !arg3.matches(passPattern))
			return false;

		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call insertUser (?, ?, ?, ?, ?)}");
			stmt.setString(2, arg0);
			stmt.setString(3, arg1);
			stmt.setString(4, arg2);
			stmt.setString(5, arg3);
			stmt.setInt(6, arg4);
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
