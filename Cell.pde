class Cell {
	int x, y;
	int state;

  Cell[][] cells;

	boolean highlite = false;
	int hColor = color(255, 0, 0);

	static final int EMPTY = 0;
	static final int CITY = 1;
	static final int JUNCTION = 2;
	static final int ROAD = 3;

	boolean[] roads = {false, false, false, false};


	Cell(Cell[][] cells, int x, int y) {
    this.cells = cells;
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

	void highlite(int r, int g, int b) {
		highlite = true;
		hColor = color(r, g, b);
	}

	void highlite(boolean t) {
		highlite = t;
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

  ArrayList<Cell> getRoads() {
    ArrayList<Cell> roadCells = new ArrayList<Cell>();
    if (roads[0]) {
      roadCells.add(cells[x][y-1]);
    }

    if (roads[1]) {
      roadCells.add(cells[x-1][y]);
    }

    if (roads[2]) {
      roadCells.add(cells[x+1][y]);
    }

    if (roads[3]) {
      roadCells.add(cells[x][y+1]);
    }
    return roadCells;
  }

	void drawBackground(PGraphics bg) {
		bg.pushMatrix();
		bg.translate(x*sizeOfCell+sizeOfCell/2, y*sizeOfCell+sizeOfCell/2);

    // bg.strokeCap;
    bg.stroke(100);
    bg.strokeWeight(3);

    if (roads[0]) {
      bg.line(sizeOfCell/6, -sizeOfCell/2, sizeOfCell/6, sizeOfCell/6);
      bg.line(-sizeOfCell/6, -sizeOfCell/2, -sizeOfCell/6, sizeOfCell/6);
		}

		if (roads[3]) {
      bg.line(sizeOfCell/6, sizeOfCell/2, sizeOfCell/6, -sizeOfCell/6);
      bg.line(-sizeOfCell/6, sizeOfCell/2, -sizeOfCell/6, -sizeOfCell/6);
		}

		if (roads[1]) {
      bg.line(-sizeOfCell/2, sizeOfCell/6, sizeOfCell/6, sizeOfCell/6);
      bg.line(-sizeOfCell/2, -sizeOfCell/6, sizeOfCell/6, -sizeOfCell/6);
		}

		if (roads[2]) {
      bg.line(sizeOfCell/2, sizeOfCell/6, -sizeOfCell/6, sizeOfCell/6);
      bg.line(sizeOfCell/2, -sizeOfCell/6, -sizeOfCell/6, -sizeOfCell/6);
		}

		switch (state) {
			case CITY:
				bg.fill(255, 0, 0);
				bg.ellipse(0,0,sizeOfCell/2, sizeOfCell/2);
				break;
			case JUNCTION:
				bg.fill(255, 0, 255);
				// bg.ellipse(0, 0, sizeOfCell/2, sizeOfCell/2);
				break;
			case ROAD:
				bg.fill(0, 100, 0);
			//	bg.ellipse(0, 0, sizeOfCell/2, sizeOfCell/2);
				break;
			default:
				fill(0);
				break;
		}

		bg.popMatrix();
	}

  void draw() {
		pushMatrix();
		translate(x*sizeOfCell+sizeOfCell/2, y*sizeOfCell+sizeOfCell/2);

    if (highlite) {
      stroke(hColor);
      noFill();
      rect(-sizeOfCell/2, -sizeOfCell/2, sizeOfCell, sizeOfCell);
    }

    popMatrix();
  }

  String toString() {
    return "x: " + x + " y: " + y + " State: " + state;
  }

  void translateToCell() {
    pushMatrix();
    translate(x*sizeOfCell + sizeOfCell/2, y*sizeOfCell + sizeOfCell/2);
  }

  void transalteEnd() {
    popMatrix();
  }
}
