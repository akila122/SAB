package rs.etf.sab.student;

import java.sql.Connection;
import rs.etf.sab.operations.*;
import rs.etf.sab.tests.TestHandler;
import rs.etf.sab.tests.TestRunner;


public class StudentMain {

	static AddressOperations addressOperations;
	static CityOperations cityOperations;
	static CourierOperations courierOperations;
	static CourierRequestOperation courierRequestOperation;
	static DriveOperation driveOperation;
	static GeneralOperations generalOperations;
	static PackageOperations packageOperations;
	static StockroomOperations stockroomOperations;
	static UserOperations userOperations;
	static VehicleOperations vehicleOperations;

	public static void main(String[] args) {

		Connection conn = Connector.connect();

		if (conn == null) {
			System.out.println("Connection failed.");
			return;
		}

		addressOperations = new ra160248_AddressOperations(conn);
		cityOperations = new ra160248_CityOperations(conn);
		courierOperations = new ra160248_CourierOperations(conn);
		courierRequestOperation = new ra160248_CourierRequestOperations(conn);
		driveOperation = new ra160248_DriveOperations(conn);
		generalOperations = new ra160248_GeneralOperations(conn);
		packageOperations = new ra160248_PackageOperations(conn);
		stockroomOperations = new ra160248_StockroomOperations(conn);
		userOperations = new ra160248_UserOperations(conn);
		vehicleOperations = new ra160248_VehicleOperations(conn);

		generalOperations.eraseAll();

		TestHandler.createInstance(addressOperations, cityOperations, courierOperations, courierRequestOperation,
				driveOperation, generalOperations, packageOperations, stockroomOperations, userOperations,
				vehicleOperations);

		TestRunner.runTests();

	}
}