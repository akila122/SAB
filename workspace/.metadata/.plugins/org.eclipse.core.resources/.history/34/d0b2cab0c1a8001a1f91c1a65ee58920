package rs.etf.sab.student;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.LinkedList;
import java.util.List;

import rs.etf.sab.operations.PackageOperations;

public class ra160248_PackageOperations extends Connected implements PackageOperations {

	public ra160248_PackageOperations(Connection conn) {
		super(conn);
		// TODO Auto-generated constructor stub
	}

	@Override
	public boolean acceptAnOffer(int arg0) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call acceptAnOffer (?)}");
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
	public boolean changeType(int arg0, int arg1) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call changeType (?,?)}");
			stmt.setInt(2, arg0);
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
	public boolean changeWeight(int arg0, BigDecimal arg1) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call changeWeight (?,?)}");
			stmt.setInt(2, arg0);
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
	public boolean deletePackage(int arg0) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call deletePackage (?)}");
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
	public Date getAcceptanceTime(int arg0) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{call getAcceptanceTime (?)}");
			stmt.setInt(1, arg0);
			ResultSet rs = stmt.executeQuery();
			if (rs.next())
				return rs.getDate(1);
			else
				return null;
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
	}

	@Override
	public List<Integer> getAllPackages() {
		List<Integer> ret = new LinkedList<>();
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{call getAllPackages ()}");
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
	public List<Integer> getAllPackagesCurrentlyAtCity(int arg0) {
		List<Integer> ret = new LinkedList<>();
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{call getAllPackagesCurrentlyAtCity (?)}");
			stmt.setInt(1, arg0);
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
	public List<Integer> getAllPackagesWithSpecificType(int arg0) {
		List<Integer> ret = new LinkedList<>();
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{call getAllPackagesWithSpecificType (?)}");
			stmt.setInt(1, arg0);
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
	public List<Integer> getAllUndeliveredPackages() {
		List<Integer> ret = new LinkedList<>();
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{call getAllUndeliveredPackages ()}");
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
	public List<Integer> getAllUndeliveredPackagesFromCity(int arg0) {
		List<Integer> ret = new LinkedList<>();
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{call getAllPackagesWithSpecificType (?)}");
			stmt.setInt(1, arg0);
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
	public int getCurrentLocationOfPackage(int arg0) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call getCurrentLocationOfPackage (?)}");
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
	public int getDeliveryStatus(int arg0) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call getDeliveryStatus (?)}");
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
	public BigDecimal getPriceOfDelivery(int arg0) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{call getPriceOfDelivery (?)}");
			stmt.setInt(1, arg0);
			ResultSet rs = stmt.executeQuery();
			if (rs.next())
				return rs.getBigDecimal(1);
			else
				return BigDecimal.valueOf(-1);
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
	public int insertPackage(int arg0, int arg1, String arg2, int arg3, BigDecimal arg4) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call insertPackage (?, ?, ?, ?, ?)}");
			stmt.setInt(2, arg0);
			stmt.setInt(3, arg1);
			stmt.setString(4, arg2);
			stmt.setInt(5, arg3);
			stmt.setBigDecimal(6, arg4);
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
	public boolean rejectAnOffer(int arg0) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call rejectAnOffer (?)}");
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

}
