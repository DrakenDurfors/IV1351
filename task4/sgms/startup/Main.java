package startup;

import view.BlockInterpreter;
import controller.Controller;
import integration.SchoolDBException;

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