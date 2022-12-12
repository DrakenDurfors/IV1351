package integration;

import model.Instrument;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

public class SchoolDAO {
    private Connection connection;

    public SchoolDAO() throws SchoolDBException{
        try {
            connectToDB();
        } catch (Exception e) {
            // TODO: handle exception
        }
    }

    private void connectToDB() throws ClassNotFoundException, SQLException{
        try {
            connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/soundgood", "postgres", "admin"); 
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

    public void rentInstrument(String instrumentID, String studentID) {
    }

    public void terminateRental(String instrumentID, String studentID) {
    }
}
