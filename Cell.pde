class Cell {
	int x, y;
	int state;

	boolean highlite = false;

	static final int EMPTY = 0;
	static final int CITY = 1;
	static final int JUNCTION = 2;
	static final int ROAD = 3;

	boolean[] roads = {false, false, false, false};


	Cell(int x, int y) {
		this.x = x;
		this.y = y;
		state = EMPTY;
	}

	void setCity() {
		state = CITY;
	}

	void setJunction() {
		state = JUNCTION;
	}

	void setRoad(boolean[] newRoads) {
		//state = ROAD;
		for (int i = 0; i < roads.length; ++i) {
			roads[i] = newRoads[i] || roads[i];
		}
	}

	void highlite(boolean h) {
		highlite = h;
	}

	boolean isJunction() {
		int sum = 0;
		for (boolean road : roads) {
			if (road) {
				sum++;
			}
		}
		return sum >=3;
	}

	void draw(PGraphics bg) {
		bg.pushMatrix();
		bg.translate(x*sizeOfCell+sizeOfCell/2, y*sizeOfCell+sizeOfCell/2);

		bg.noStroke();
		bg.fill(100);

		if (roads[0]) {
			bg.rect(-sizeOfCell/6, -sizeOfCell/2, sizeOfCell/9, sizeOfCell/2+sizeOfCell/7);
			bg.rect(sizeOfCell/18, -sizeOfCell/2, sizeOfCell/9, sizeOfCell/2+sizeOfCell/7);
		}

		if (roads[3]) {
			bg.rect(-sizeOfCell/6, -sizeOfCell/6, sizeOfCell/9, sizeOfCell/2+sizeOfCell/6);
			bg.rect(sizeOfCell/18, -sizeOfCell/6, sizeOfCell/9, sizeOfCell/2+sizeOfCell/6);
		}

		if (roads[1]) {
			bg.rect(-sizeOfCell/2, -sizeOfCell/6, sizeOfCell/2+sizeOfCell/7, sizeOfCell/9);
			bg.rect(-sizeOfCell/2, sizeOfCell/18, sizeOfCell/2+sizeOfCell/7, sizeOfCell/9);
		}

		if (roads[2]) {
			bg.rect(-sizeOfCell/6, -sizeOfCell/6, sizeOfCell/2+sizeOfCell/6, sizeOfCell/9);
			bg.rect(-sizeOfCell/6, sizeOfCell/18, sizeOfCell/2+sizeOfCell/6, sizeOfCell/9);
		}

		switch (state) {
			case CITY:
				bg.fill(255, 0, 0);
				bg.ellipse(0,0,sizeOfCell/2, sizeOfCell/2);
				break;
			case JUNCTION:
				bg.fill(255, 0, 255);
				bg.ellipse(0, 0, sizeOfCell/2, sizeOfCell/2);
				break;
			case ROAD:
				bg.fill(0, 100, 0);
			//	bg.ellipse(0, 0, sizeOfCell/2, sizeOfCell/2);
				break;
			default:
				fill(0);
				break;
		}



		if (highlite) {
			bg.stroke(255, 0, 0);
			bg.noFill();
			bg.rect(-sizeOfCell/2, -sizeOfCell/2, sizeOfCell, sizeOfCell);
		}


		bg.popMatrix();
	}
}
