package rs.etf.sab.student;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.LinkedList;
import java.util.List;

import rs.etf.sab.operations.CourierOperations;

public class ra160248_CourierOperations extends Connected implements CourierOperations {

	public ra160248_CourierOperations(Connection conn) {
		super(conn);
	}

	@Override
	public boolean deleteCourier(String arg0) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call deleteCourier (?)}");
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
	public List<String> getAllCouriers() {
		List<String> ret = new LinkedList<>();
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{call getAllCouriers ()}");
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
	public BigDecimal getAverageCourierProfit(int arg0) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{call getAverageCourierProfit (?)}");
			stmt.setInt(1, arg0);

			ResultSet rs = stmt.executeQuery();
			if(rs.next())
				return rs.getBigDecimal(1);
			else return BigDecimal.valueOf(-1);
		} catch (SQLException e) {
			e.printStackTrace();
			return BigDecimal.valueOf(-1);
		} finally {
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
				return BigDecimal.valueOf(-1);
			}
		}
	}

	@Override
	public List<String> getCouriersWithStatus(int arg0) {
		List<String> ret = new LinkedList<>();
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{call getCouriersWithStatus (?)}");
			stmt.setInt(1, arg0);
			
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
	public boolean insertCourier(String arg0, String arg1) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call insertCourier (?,?)}");
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
