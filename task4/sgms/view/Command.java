package view;

/**
 * Defines all commands that can be performed by a user of the chat application.
 */
public enum Command {
    /**
     * Lists all instruments available to rent.
     */
    LIST,
    /**
     * Rents a specified instrument to a specified student.
     */
    RENT,
    /**
     * Terminates the rental of an instrument.
     */
    TERMINATE,
    /**
     * Lists all commands.
     */
    HELP,
    /**
     * Leave the chat application.
     */
    QUIT,
    /**
     * None of the valid commands above was specified.
     */
    ILLEGAL_COMMAND
}
