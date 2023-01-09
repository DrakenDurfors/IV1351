package controller;

import integration.SchoolDAO;
import integration.SchoolDBException;

import model.Instrument;
import model.InstrumentException;

import model.Lease;

import java.util.List;

/**
 * Handles communication between the view, model, and integration layers.
 */
public class Controller {
    private final SchoolDAO schoolDB;
    private final int MAX_RENTALS = 2;

    public Controller() throws SchoolDBException {
        schoolDB = new SchoolDAO();
    }

    /**
     * Lists all available instruments
     * 
     * @param type The type of instrument you want to check for
     * @return A list containing instruments
     * @throws InstrumentException if unable to get instruments
     */
    public List<Instrument> getRentableInstruments(String type) throws InstrumentException {
        String failMsg = "Unable to list rentable instruments.";
        try {
            return schoolDB.findRentableInstrumentsOfType(type);
        } catch (Exception e) {
            throw new InstrumentException(failMsg, e);
        }
    }

    /**
     * Creates a database entry for the rental
     * 
     * @param instrumentID The id of the instrument to be rented
     * @param studentID    The id of the student who wants to rent
     * @throws InstrumentException If unable to perform the rental
     */
    public void rentInstrument(String instrumentID, String studentID) throws InstrumentException {
        String failMsg = "Unable to rent instrument with id: '" + instrumentID + "' to studentID: '" + studentID + "'.";
        if (instrumentID == null || studentID == null) {
            throw new InstrumentException(failMsg);
        }
        try {
            
            Lease instrumentRentals = schoolDB.findActiveLeasesForInstrument(instrumentID);
            if (instrumentRentals != null) {
                throw new InstrumentException(failMsg);
            }
            List<Lease> studentRentals = schoolDB.findActiveLeasesForStudent(studentID);
            if (studentRentals != null && studentRentals.size() >= MAX_RENTALS) {
                throw new InstrumentException(failMsg);
            }

            schoolDB.createInstrumentLease(instrumentID, studentID);
        } catch (Exception e) {
            throw new InstrumentException(failMsg, e);
        }
    }

    /**
     * Terminates the rental of a specified instrument by a specified user
     * 
     * @param instrumentID The id of the rented instrument
     * @param studentID    The id of the student
     * @throws InstrumentException If unable to perform the termination of rental
     */
    public void terminateRental(String instrumentID, String studentID) throws InstrumentException {
        String failMsg = "Unable to terminate rental of instrument with id: '" + instrumentID + "' to studentID: '"
                + studentID + "'.";
        try {
            schoolDB.updateInstrumentLeaseAsTerminated(instrumentID, studentID);
        } catch (Exception e) {
            throw new InstrumentException(failMsg, e);
        }
    }
}