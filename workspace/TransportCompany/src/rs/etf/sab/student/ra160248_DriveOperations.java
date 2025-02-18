package rs.etf.sab.student;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.LinkedList;
import java.util.List;

import rs.etf.sab.operations.DriveOperation;

public class ra160248_DriveOperations extends Connected implements DriveOperation {

	public ra160248_DriveOperations(Connection conn) {
		super(conn);
	}

	@Override
	public List<Integer> getPackagesInVehicle(String arg0) {
		List<Integer> ret = new LinkedList<>();
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{call getPackagesInVehicle (?)}");
			stmt.setString(1, arg0);
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
	public int nextStop(String arg0) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call nextStop (?)}");
			stmt.setString(2, arg0);
			stmt.registerOutParameter(1, Types.INTEGER);
			stmt.execute();
			return stmt.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
			return -3;
		} finally {
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
				return -3;
			}
		}
	}

	@Override
	public boolean planingDrive(String arg0) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call planingDrive (?)}");
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

}
