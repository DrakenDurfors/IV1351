/*List instruments It shall be possible to list all instruments of a certain kind (guitar, saxophone, etc)
  that are available to rent. Instruments which are already rented shall not be included in the listing.
  The listing shall show brand and price for each listed instrument.
 */

/*- hyra ut ett instrumment (skapa rad i databasen)
- avsluta uthyrningen (uppdatera rad i databasen)*/

INSERT INTO instrument_lease (lease_start, lease_end, student_id, instruments_id)
VALUES (now(), null, 3, 3)