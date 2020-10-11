package rs.etf.sab.student;

import java.util.LinkedList;
import java.util.List;

import rs.etf.sab.operations.CityOperations;
import java.sql.*;

public class ra160248_CityOperations extends Connected implements CityOperations {

	public ra160248_CityOperations(Connection conn) {
		super(conn);
	}

	@Override
	public int deleteCity(String... arg0) {

		int ret = 0;
		CallableStatement stmt = null;

		for (String city : arg0) {
			try {
				stmt = conn.prepareCall("{? = call deleteCityByName (?)}");
				stmt.setString(2, city);
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
	public boolean deleteCity(int zip) {

		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call deleteCityByZip (?)}");
			stmt.setInt(2, zip);
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
	public List<Integer> getAllCities() {
		List<Integer> ret = new LinkedList<>();
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{call getAllCities ()}");
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
	public int insertCity(String name, String zip) {
		CallableStatement stmt = null;
		try {
			stmt = conn.prepareCall("{? = call insertCity (?, ?)}");
			stmt.setString(2, name);
			stmt.setInt(3, Integer.parseInt(zip));
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
