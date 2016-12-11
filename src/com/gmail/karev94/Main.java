package com.gmail.karev94;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Main {
	public static void main(String[] args) {
		Point point = new Point();
		
		try(BufferedReader br = new BufferedReader(new InputStreamReader(System.in))) {
			while (true) {
                String input = br.readLine();
            	
                if ("setx".equals(input)) {
                	String new_x_str = br.readLine();
                	int new_x = -1;
                	try {
                		new_x = Integer.parseInt(new_x_str);
                		point.setX(new_x);
                	} catch (NumberFormatException e) {
                	      System.out.println("X must be integral");
                	}
                }
                if ("sety".equals(input)) {
                	String new_y_str = br.readLine();
                	int new_y = -1;
                	try {
                		new_y = Integer.parseInt(new_y_str);
                		point.setY(new_y);
                	} catch (NumberFormatException e) {
                	      System.out.println("Y must be integral");
                	}
                }
                if ("print".equals(input)) {
                	point.print();
                }
                if ("undo".equals(input)) {
                	point.undo();
                }
                if ("redo".equals(input)) {
                	point.redo();
                }
                if ("q".equals(input)) {
                    break;
                }
                System.out.println("-----------\n");
            }
		} catch (IOException e) {
			
		}
	}

}
