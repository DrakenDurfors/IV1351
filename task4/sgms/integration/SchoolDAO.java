package integration;

import model.Instrument;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

public class SchoolDAO {
    private Connection connection;

    private void connectToDB() throws ClassNotFoundException, SQLException{
        connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "admin");
    }

    public List<Instrument> findRentableInstrumentsOfType(String type) {
        return null;
    }

    public void rentInstrument(String instrumentID, String studentID) {
    }

    public void terminateRental(String instrumentID, String studentID) {
    }
}
