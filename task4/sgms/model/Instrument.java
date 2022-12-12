package model;

public class Instrument {
    String id;
    String brand;
    Float fee;

    /** Constructor for the Instrument object
     * 
     * @param Id The id of the instrument
     * @param Brand The brand of the instrument
     * @param Fee The cost of renting the instrtument
     */
    public Instrument (String Id, String Brand, Float Fee) {
        this.id = Id;
        this.brand = Brand;
        this.fee = Fee;
    }

    /**
     * 
     * @return The instrument ID.
     */
    public String getId(){
        return this.id;
    }

    /**
     * 
     * @return The instrument brand.
     */
    public String getBrand(){
        return this.brand;
    }

    /**
     * 
     * @return The cost of renting the instrument.
     */
    public Float getFee(){
        return this.fee;
    }
}
