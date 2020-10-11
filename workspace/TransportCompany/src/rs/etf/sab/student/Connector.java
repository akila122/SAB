package rs.etf.sab.student;

import java.sql.*;

public class Connector {

	private static final String username = "sa";
	private static final String password = "pass";
	private static final String database = "TransportCompany";
	private static final int port = 1434;
	private static final String server = "localhost";

	private static final String connectionUrl = "jdbc:sqlserver://" + server + ":" + port + ";databaseName=" + database;

	public static Connection connect() {
		try {
			return DriverManager.getConnection(connectionUrl, username, password);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}

	}

}
