package startup;

import view.BlockInterpreter;
import controller.Controller;
import integration.SchoolDBException;

/**
 * Starts the program by initialising the view with a new controller and running the
 * method in the view corresponding to run().
 */
public class Main{

    public static void main(String[] args){
        try {
            new BlockInterpreter(new Controller()).handleCmds();
        } catch (SchoolDBException e) {
            System.out.println("Unable to connect to soundgood database");
            e.printStackTrace();
        }
    }
}