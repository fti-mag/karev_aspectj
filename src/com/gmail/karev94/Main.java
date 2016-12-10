package com.gmail.karev94;

public class Main {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Point point = new Point();
		point.setX(4);
		point.setY(5);
		point.print();
		
		System.out.println("Undo");
		point.undo();
		point.print();
		
		System.out.println("Undo");
		point.undo();
		point.print();
		
		System.out.println("Undo");
		point.undo();
		point.print();
		
		System.out.println("Redo");
		point.redo();
		point.print();
		
		point.setY(6);
		point.print();
		System.out.println("Redo");
		point.redo();
		point.print();
		System.out.println("Undo");
		point.undo();
		point.print();
		System.out.println("Redo");
		point.redo();
		point.print();
	}

}
