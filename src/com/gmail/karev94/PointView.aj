package com.gmail.karev94;

privileged public aspect PointView {
	public void Point.print() {
		System.out.println("Point x: " + String.valueOf(this.x) + " y: " + String.valueOf(this.y));
	}
}
