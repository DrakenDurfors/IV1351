package controller;

import integration.SchoolDAO;
import integration.SchoolDBException;

import model.InstrumentException;
import model.Instrument;

public class Controller {
    private final SchoolDAO schoolDB;

    public Controller() throws SchoolDBException {
        schoolDB = new SchoolDAO();
    }

    /**Lists all available instruments
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

    /**Creates a database entry for the rental
     * @param instrumentID The id of the instrument to be rented
     * @param studentID The id of the student who wants to rent
     * @throws InstrumentException If unable to perform the rental
     */
    public void rentInstrument(String instrumentID, String studentID) throws InstrumentException {
        String failMsg = "Unable to rent instrument with id: '" + instrumentID + "' to studentID: '" + studentID + "'.";
        if(instrumentID == null || studentID == null){
            throw new InstrumentException(failMsg);
        }

        try {
            schoolDB.rentInstrument(instrumentID, studentID);
        } catch (Exception e) {
            throw new InstrumentException(failMsg, e);
        }
    }

    /**Terminates the rental of a specified instrument by a specified user
     * @param instrumentID The id of the rented instrument
     * @param studentID The id of the student
     * @throws InstrumentException If unable to perform the termination of rental
     */
    public void terminateRental(String instrumentID, String studentID) throws InstrumentException {
        String failMsg = "Unable to terminate rental of instrument with id: '" + instrumentID + "' to studentID: '" + studentID + "'.";
        try {
            return schoolDB.terminateRental(instrumentID, studentID);
        } catch (Exception e) {
            throw new InstrumentException(failMsg, e);
        }
    }
}