package startup;

import view.BlockInterpreter;
import controller.Controller;

public class Main{

    public static void main(String[]args){
        try {
            new BlockInterpreter(new Controller()).handleCmds();
        } catch (Exception e) {
            // TODO: handle exception
        }
    }

}