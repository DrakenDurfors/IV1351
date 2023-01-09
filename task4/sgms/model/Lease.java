package model;

/**
 * An instance of this class represents a specific lease object and its attributes.
 */
public class Lease {
    String id;
    String studentId;
    String instrumentId;
    String start;
    String end;

    /** Constructor for the lease object
     * 
     * @param Id The lease id
     * @param Start The start of the lease
     * @param End The end of the lease
     * @param StudentID The student ID
     * @param InstrumentID Th instrument ID
     */
    public Lease (String Id, String Start, String End, String StudentID, String InstrumentID) {
        this.id = Id;
        this.start = Start;
        this.end = End;
        this.studentId = StudentID;
        this.instrumentId = InstrumentID;
    }

    /**
     * 
     * @return The lease ID.
     */
    public String getId(){
        return this.id;
    }
    /**
     * 
     * @return The student ID.
     */
    public String getStudentId(){
        return this.studentId;
    }
    /**
     * 
     * @return The instrument ID.
     */
    public String getInstrumentId(){
        return this.instrumentId;
    }

    /**
     * 
     * @return The start date of the lease.
     */
    public String getStart(){
        return this.start;
    }

    /**
     * 
     * @return The end date of the lease.
     */
    public String getEnd(){
        return this.end;
    }
}
