package rs.etf.sab.student;

import java.sql.Connection;

public abstract class Connected {
	
	protected Connection conn;
	
	public Connected(Connection conn) {
		this.conn = conn;
	}
	
}
