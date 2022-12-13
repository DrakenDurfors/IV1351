package integration;

import model.Instrument;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SchoolDAO {
    private Connection connection;

    private final int  MAX_RENTALS = 2;

    private PreparedStatement listAvailableStmt;
    private PreparedStatement startLeaseStmt;
    private PreparedStatement terminateLeaseStmt;
    private PreparedStatement checkActiveLeaseStmt;
    private PreparedStatement checkActiveRentalStmt;


    public SchoolDAO() throws SchoolDBException{
        try {
            connectToDB();
            prepareStatements();
        } catch (Exception e) {
            // TODO: handle exception
        }
    }

    private void connectToDB() throws ClassNotFoundException, SQLException{
        try {
            //connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "admin");
            connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/soundgood", "postgres", "Ladrin123");
            connection.setAutoCommit(false);
            System.out.println("Connection established");
        } catch (SQLException e) {
            // TODO: handle exception properly
            System.out.println("DEAD CONNECTION");
            e.printStackTrace();
        }
        
    }

    public List<Instrument> findRentableInstrumentsOfType(String type) throws SQLException {
        String failMsg = "Could not fetch instruments";
        List<Instrument> instruments = new ArrayList<>();
        ResultSet result = null;
        try {

            listAvailableStmt.setString(1, type);
            result = listAvailableStmt.executeQuery();
            while (result.next()) {
                instruments.add(new Instrument(result.getString(1), result.getString(2), result.getFloat(3)));
            }
            connection.commit();
        } catch (Exception e) {
            // TODO: handle exception
            System.out.println(failMsg);
        }
        return instruments;
    }

    public void rentInstrument(String instrumentID, String studentID) throws SQLException {
        String failMsg = "Could not rent instrument";
        int affectedRows = 0;
        ResultSet currentRentals = null;
        ResultSet currentAvailable = null;
        try {
            int studentToRentID = Integer.parseInt(studentID);
            int instrumentToRentID = Integer.parseInt(instrumentID);

            // Following checks that student doesnt have more than 
            checkActiveLeaseStmt.setInt(1, studentToRentID);

            currentRentals = checkActiveLeaseStmt.executeQuery();

            if(currentRentals.next()){
                if(currentRentals.getInt(1) >= MAX_RENTALS){
                    // TODO: handle exception properly
                    throw new SQLException(failMsg);
                }
            }

            // Following checks that instrument isn't allready rented

            checkActiveRentalStmt.setInt(1, instrumentToRentID);

            currentAvailable = checkActiveRentalStmt.executeQuery();
            if(currentAvailable.next()){
                if(currentAvailable.getInt(1) >= 1){
                    // TODO: handle exception properly
                    throw new SQLException(failMsg);
                }
            }

            //rents the instrument
            startLeaseStmt.setInt(1, studentToRentID);
            startLeaseStmt.setInt(2, instrumentToRentID);

            affectedRows = startLeaseStmt.executeUpdate();
            if(affectedRows != 1){
                // TODO: handle exception properly
                throw new SQLException(failMsg);
            }
            connection.commit();

        } catch (Exception e) {
            // TODO: handle exception
        }
        
        

    }

    public void terminateRental(String instrumentID, String studentID) throws SQLException {
        String failMsg = "Could not terminate rental";
        int affectedRows = 0;
        try {
            terminateLeaseStmt.setInt(1, Integer.parseInt(studentID));
            terminateLeaseStmt.setInt(2, Integer.parseInt(instrumentID));

            affectedRows = terminateLeaseStmt.executeUpdate();
            if(affectedRows != 1){
                // TODO: handle exception properly
                throw new SQLException(failMsg);
            }
            connection.commit();
        } catch (Exception e) {
            // TODO: handle exception
            System.out.println(failMsg);
        }
    }

    private void prepareStatements() throws SQLException {

        checkActiveRentalStmt = connection.prepareStatement(
            "SELECT COUNT(*) FROM instrument_lease WHERE instruments_id = ? AND lease_end IS NULL"
        );

        checkActiveLeaseStmt = connection.prepareStatement(
            "SELECT COUNT(*) FROM instrument_lease WHERE student_id = ? AND lease_end IS NULL"
        );

        startLeaseStmt = connection.prepareStatement(
            "INSERT INTO instrument_lease (lease_start, lease_end, student_id, instruments_id) VALUES (now(),null,?,?)");
        
        listAvailableStmt = connection.prepareStatement(
            "SELECT instruments.id, instruments.brand, instruments.fee " + 
	        "FROM instruments, instrument_type " +
	        "WHERE " +
		        "(instruments.instrument_type_id = instrument_type.id AND instrument_type.name = ?) AND " +
		        "instruments.id NOT IN (SELECT DISTINCT instruments_id FROM instrument_lease WHERE lease_end IS NULL)");

        terminateLeaseStmt = connection.prepareStatement(
            "UPDATE instrument_lease SET lease_end = NOW() WHERE student_id = ? AND instruments_id = ? AND lease_end IS NULL"
        );

    }

}
