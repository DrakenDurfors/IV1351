package integration;

import model.Instrument;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class SchoolDAO {
    private Connection connection;

    private PreparedStatement listAvailableStmt;
    private PreparedStatement startLeaseStmt;
    private PreparedStatement terminateLeaseStmt;


    public SchoolDAO() throws SchoolDBException{
        try {
            connectToDB();
        } catch (Exception e) {
            // TODO: handle exception
        }
    }

    private void connectToDB() throws ClassNotFoundException, SQLException{
        try {
            //connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/soundgood", "postgres", "admin");
            connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "admin");
            connection.setAutoCommit(false);
            System.out.println("Connection established");
        } catch (SQLException e) {
            // TODO: handle exception properly
            System.out.println("DEAD CONNECTION");
            e.printStackTrace();
        }
        
    }

    public List<Instrument> findRentableInstrumentsOfType(String type) {
        return null;
    }

    public void rentInstrument(String instrumentID, String studentID) throws SQLException {
        int studentToRentID =3;
        int instrumentToRentID=3;
        startLeaseStmt.setInt(0, studentToRentID);
        startLeaseStmt.setInt((1, instrumentToRentID));

    }

    public void terminateRental(String instrumentID, String studentID) {
    }

    private void prepareStatements() throws SQLException {
        startLeaseStmt = connection.prepareStatement(
                "INSERT INTO instrument_lease (lease_start, lease_end, student_id, instruments_id) VALUES (now(),null,?,?)");


    }

}
