package rs.etf.sab.student;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.LinkedList;
import java.util.List;

import rs.etf.sab.operations.VehicleOperations;

public class ra160248_VehicleOperations extends Connected implements VehicleOperations {

	public ra160248_VehicleOperations(Connection conn) {
		super(conn);
		// TODO Auto-generated constructor stub
	}

	@Override
	public boolean changeCapacity(String arg0, BigDecimal arg1) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call changeCapacity (?, ?)}");
			stmt.setString(2, arg0);
			stmt.setBigDecimal(3, arg1);
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
	public boolean changeConsumption(String arg0, BigDecimal arg1) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call changeConsumption (?, ?)}");
			stmt.setString(2, arg0);
			stmt.setBigDecimal(3, arg1);
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
	public boolean changeFuelType(String arg0, int arg1) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call changeFuelType (?, ?)}");
			stmt.setString(2, arg0);
			stmt.setInt(3, arg1);
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
	public int deleteVehicles(String... arg0) {
		int ret = 0;
		CallableStatement stmt = null;

		for (String vehicle : arg0) {
			try {
				stmt = conn.prepareCall("{? = call deleteVehicle (?)}");
				stmt.setString(2, vehicle);
				stmt.registerOutParameter(1, Types.INTEGER);
				stmt.execute();
				if (stmt.getInt(1) > 0)
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
	public List<String> getAllVehichles() {
		List<String> ret = new LinkedList<>();
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{call getAllVehicles ()}");
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
	public boolean insertVehicle(String arg0, int arg1, BigDecimal arg2, BigDecimal arg3) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call insertVehicle (?, ?, ?, ?)}");
			stmt.setString(2, arg0);
			stmt.setInt(3, arg1);
			stmt.setBigDecimal(4, arg2);
			stmt.setBigDecimal(5, arg3);
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
	public boolean parkVehicle(String arg0, int arg1) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call parkVehicle (?, ?)}");
			stmt.setString(2, arg0);
			stmt.setInt(3, arg1);
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
